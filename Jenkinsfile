
@Library("CI_LIB@lib_master") _

def IMAGE_TAG = lib_Main.getDockerImage(JOB_NAME)
def REPO_CI_TOOLS = "https://github.com/zephyrproject-rtos/ci-tools.git"
def REPO_CI_TOOLS_SHA = "bfe635f102271a4ad71c1a14824f9d5e64734e57"
def CI_STATE = new HashMap()

pipeline {
  
  parameters {
   booleanParam(name: 'RUN_DOWNSTREAM', description: 'if false skip downstream jobs', defaultValue: true)
   booleanParam(name: 'RUN_TESTS', description: 'if false skip testing', defaultValue: true)
   booleanParam(name: 'RUN_BUILD', description: 'if false skip building', defaultValue: false)
   string(name: 'jsonstr_CI_STATE', description: 'Default State if no upstream job',
              defaultValue: '''{
"NRFX":{"WAITING":"false", "BRANCH_NAME":"master","GIT_BRANCH":" ","GIT_URL":"https://projecttools.nordicsemi.no/bitbucket/scm/nrffosdk/nrfx.git"},
}''')
  }

  agent {
    docker {
      image "$IMAGE_TAG"
      label "docker && build-node && ncs && linux"
      args '-e PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/workdir/.local/bin'
    }
  }
  options {
    // Checkout the repository to this folder instead of root
    checkoutToSubdirectory('zephyr')
  }

  environment {
      // ENVs for check-compliance
      GH_TOKEN = credentials('nordicbuilder-compliance-token') // This token is used to by check_compliance to comment on PRs and use checks
      GH_USERNAME = "NordicBuilder"
      COMPLIANCE_ARGS = "-r NordicPlayground/fw-nrfconnect-zephyr --exclude-module Kconfig"
      COMPLIANCE_REPORT_ARGS = "-p $CHANGE_ID -S $GIT_COMMIT -g"

      LC_ALL = "C.UTF-8"

      // ENVs for sanitycheck
      ARCH = "-a arm"
      SANITYCHECK_OPTIONS = "--inline-logs --enable-coverage -N"
      SANITYCHECK_RETRY = "--only-failed --outdir=out-2nd-pass"
      SANITYCHECK_RETRY_2 = "--only-failed --outdir=out-3rd-pass"

      // ENVs for building (triggered by sanitycheck)
      ZEPHYR_TOOLCHAIN_VARIANT = 'zephyr'
      GNUARMEMB_TOOLCHAIN_PATH = '/workdir/gcc-arm-none-eabi-7-2018-q2-update'
      ZEPHYR_SDK_INSTALL_DIR = '/opt/zephyr-sdk'
  }

  stages {
    stage('Load') {
      steps {
        println "Using Node:$NODE_NAME and Input Parameters:$params"
        println "Input CI_STATE:${params['jsonstr_CI_STATE']}"
        dir("ci-tools") {
          git branch: "master", url: "$REPO_CI_TOOLS"
          sh "git checkout ${REPO_CI_TOOLS_SHA}"
        }

        script {
          CI_STATE = lib_State.load(params['jsonstr_CI_STATE'])
          lib_State.store('ZEPHYR', CI_STATE)
          lib_State.getParentJob(CI_STATE)
          lib_State.add2jobStack('ZEPHYR', CI_STATE)
          println "CI_STATE = $CI_STATE"
        }
      }
    }

    stage('Checkout repositories') {
      when { expression { CI_STATE.ZEPHYR.RUN_TESTS || CI_STATE.ZEPHYR.RUN_BUILD } }
      steps {
        script {
          CI_STATE.ZEPHYR.REPORT_SHA = lib_Main.checkoutRepo(CI_STATE.ZEPHYR.GIT_URL, "zephyr", CI_STATE, false)
          println "CI_STATE.ZEPHYR.REPORT_SHA = " + CI_STATE.ZEPHYR.REPORT_SHA
          lib_West.InitUpdate('zephyr')
        }
      }
    }
    stage('Apply Parent Manifest Updates') {
      when { expression { CI_STATE.ZEPHYR.RUN_TESTS || CI_STATE.ZEPHYR.RUN_BUILD } }
      steps {
        script {
          println "If triggered by an upstream Project, use their changes."
          lib_West.ApplyManfestUpdates(CI_STATE)
        }
      }
    }
    stage('Run compliance check') {
      when { expression { CI_STATE.ZEPHYR.RUN_TESTS } }
      steps {
        dir('zephyr') {
          script {
            // If we're a pull request, compare the target branch against the current HEAD (the PR)
            println "CHANGE_TARGET = ${env.CHANGE_TARGET}"
            println "BRANCH_NAME = ${env.BRANCH_NAME}"
            println "TAG_NAME = ${env.TAG_NAME}"

            if (env.CHANGE_TARGET) {
              COMMIT_RANGE = "origin/${env.CHANGE_TARGET}..HEAD"
              COMPLIANCE_ARGS = "$COMPLIANCE_ARGS $COMPLIANCE_REPORT_ARGS"
              sh "echo change id: $CHANGE_ID"
              sh "echo git commit: $GIT_COMMIT"
              sh "echo commit range: $COMMIT_RANGE"
              sh "git rev-parse origin/$CHANGE_TARGET"
              sh "git rev-parse HEAD"
              println "Building a PR: ${COMMIT_RANGE}"
            }
            else if (env.TAG_NAME) {
              COMMIT_RANGE = "tags/${env.BRANCH_NAME}..tags/${env.BRANCH_NAME}"
              println "Building a Tag: ${COMMIT_RANGE}"
            }
            // If not a PR, it's a non-PR-branch or master build. Compare against the origin.
            else if (env.BRANCH_NAME) {
              COMMIT_RANGE = "origin/${env.BRANCH_NAME}..HEAD"
              println "Building a Branch: ${COMMIT_RANGE}"
            }
            else {
                assert condition : "Build fails because it is not a PR/Tag/Branch"
            }
            // Run the compliance check
            try {
              sh "(source zephyr-env.sh && ../ci-tools/scripts/check_compliance.py $COMPLIANCE_ARGS --commits $COMMIT_RANGE)"
            }
            finally {
              junit 'compliance.xml'
              archiveArtifacts artifacts: 'compliance.xml'
            }
          }
        }
      }
    }
    stage('Sanitycheck (all)') {
      when { expression { CI_STATE.ZEPHYR.RUN_BUILD } }
      steps {
        dir('zephyr') {
          sh "echo variant: $ZEPHYR_TOOLCHAIN_VARIANT"
          sh "echo SDK dir: $ZEPHYR_SDK_INSTALL_DIR"
          sh "cat /opt/zephyr-sdk/sdk_version"
          sh "source zephyr-env.sh && \
              (./scripts/sanitycheck $SANITYCHECK_OPTIONS $ARCH || \
              (sleep 10; ./scripts/sanitycheck $SANITYCHECK_OPTIONS $SANITYCHECK_RETRY) || \
              (sleep 10; ./scripts/sanitycheck $SANITYCHECK_OPTIONS $SANITYCHECK_RETRY_2))"
        }
      }
    }

    stage('Trigger testing build') {
      when { expression { CI_STATE.ZEPHYR.RUN_DOWNSTREAM } }
      steps {
        script {
          CI_STATE.ZEPHYR.WAITING = true
          def DOWNSTREAM_JOBS = lib_Main.getDownStreamJobs(CI_STATE, 'ZEPHYR')
          println "DOWNSTREAM_JOBS = " + DOWNSTREAM_JOBS
          lib_West.AddManifestUpdate("ZEPHYR", 'zephyr', CI_STATE.ZEPHYR.GIT_URL, CI_STATE.ZEPHYR.REPORT_SHA, CI_STATE)
          lib_West.ApplyManfestUpdates(CI_STATE)
          def jobs = [:]
          DOWNSTREAM_JOBS.each {
            jobs["${it}"] = {
              build job: "${it}", propagate: true, wait: true, parameters: [
                        string(name: 'jsonstr_CI_STATE', value: lib_Util.HashMap2Str(CI_STATE))]
            }
          }
          parallel jobs
        }
      }
    }
  }

  post {
    always {
      // Clean up the working space at the end (including tracked files)
      cleanWs()
    }
  }
}
