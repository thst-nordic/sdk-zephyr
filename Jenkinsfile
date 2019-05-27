def IMAGE_TAG = "ncs-toolchain:1.08"
def REPO_CI_TOOLS = "https://github.com/zephyrproject-rtos/ci-tools.git"
def REPO_CI_TOOLS_SHA = "9f4dc0be401c2b1e9b1c647513fb996bd8abd057"

pipeline {
  agent none
    options {
    // Checkout the repository to this folder instead of root
    checkoutToSubdirectory('zephyr')
  }

  environment {
      // ENVs for check-compliance
      GH_TOKEN = credentials('nordicbuilder-compliance-token') // This token is used to by check_compliance to comment on PRs and use checks
      GH_USERNAME = "NordicBuilder"
      COMPLIANCE_ARGS = "-r NordicPlayground/fw-nrfconnect-zephyr"
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
    stage('Testing') {
      parallel {
        stage('Run compliance check') {
         	agent {
              docker {
                image "$IMAGE_TAG"
                label "docker && build-node && ncs"
                args '-e PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/workdir/.local/bin'
              }
            }
          steps {
            dir("ci-tools") {
              git branch: "master", url: "$REPO_CI_TOOLS"
              sh "git checkout ${REPO_CI_TOOLS_SHA}"
            }
            
            dir('zephyr') {
              sh "git rev-parse HEAD"
	        }
	        
            // Initialize west
            sh "west init -l zephyr/"

            // Checkout
            sh "west update"
            
            dir('zephyr') {
              script {
                // If we're a pull request, compare the target branch against the current HEAD (the PR)
                if (env.CHANGE_TARGET) {
                  COMMIT_RANGE = "origin/$CHANGE_TARGET..HEAD"
                  COMPLIANCE_ARGS = "$COMPLIANCE_ARGS $COMPLIANCE_REPORT_ARGS"
                  sh "echo change id: $CHANGE_ID"
                  sh "echo git commit: $GIT_COMMIT"
                  sh "echo commit range: $COMMIT_RANGE"
                  sh "git rev-parse origin/$CHANGE_TARGET"
                  sh "git rev-parse HEAD"
                }
                // If not a PR, it's a non-PR-branch or master build. Compare against the origin.
                else {
                  COMMIT_RANGE = "origin/${env.BRANCH_NAME}..HEAD"
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
          post {
              always {
                  cleanWs()
              }
           }
        }
        
        stage('Sanitycheck (nRF5832_pca10040)') {
        	when {
        	    changeRequest()
        	}
        	agent {
              docker {
                image "$IMAGE_TAG"
                label "docker && build-node && ncs"
                args '-e PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/workdir/.local/bin'
              }
            }
        	environment {
	            PLATFORM = " -p nrf52_pca10040"
	        }

        	steps {
            // Initialize west
            sh "west init -l zephyr/"

            // Checkout
            sh "west update"
        	    dir('zephyr') {
        	      sh "echo variant: $ZEPHYR_TOOLCHAIN_VARIANT"
                  sh "echo SDK dir: $ZEPHYR_SDK_INSTALL_DIR"
                  sh "cat /opt/zephyr-sdk/sdk_version"
    
                  sh "source zephyr-env.sh && \
                     (./scripts/sanitycheck $SANITYCHECK_OPTIONS $ARCH $PLATFORM || \
                     (sleep 10; ./scripts/sanitycheck $SANITYCHECK_OPTIONS $SANITYCHECK_RETRY) || \
                     (sleep 10; ./scripts/sanitycheck $SANITYCHECK_OPTIONS $SANITYCHECK_RETRY_2))"
                }      	    
        	}
           post {
               always {
                   cleanWs()
               }

           }                        
        }

        stage('Sanitycheck (nRF5840_pca10056)') {
        	when {
        	    changeRequest()
        	}
        	agent {
              docker {
                image "$IMAGE_TAG"
                label "docker && build-node && ncs"
                args '-e PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/workdir/.local/bin'
              }
            }
            
        	environment {
	            PLATFORM = " -p nrf52840_pca10056"
	        }
        	
        	steps {
            // Initialize west
            sh "west init -l zephyr/"

            // Checkout
            sh "west update"
                    	
        	    dir('zephyr') {    
        	      sh "echo variant: $ZEPHYR_TOOLCHAIN_VARIANT"
                  sh "echo SDK dir: $ZEPHYR_SDK_INSTALL_DIR"
                  sh "cat /opt/zephyr-sdk/sdk_version"
    
                  sh "source zephyr-env.sh && \
                     (./scripts/sanitycheck $SANITYCHECK_OPTIONS $ARCH $PLATFORM || \
                     (sleep 10; ./scripts/sanitycheck $SANITYCHECK_OPTIONS $SANITYCHECK_RETRY) || \
                     (sleep 10; ./scripts/sanitycheck $SANITYCHECK_OPTIONS $SANITYCHECK_RETRY_2))"
                }      	    
        	}
           post {
               always {
                   cleanWs()
               }

           }                       
        }
        
        stage('Sanitycheck (nrf9160_pca10090)') {
        	when {
        	  changeRequest()
        	}
        	agent {
              docker {
                image "$IMAGE_TAG"
                label "docker && build-node && ncs"
                args '-e PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/workdir/.local/bin'
              }
            }
        	environment {
	            PLATFORM = " -p nrf9160_pca10090"
	        }
        	
        	steps {
            // Initialize west
            sh "west init -l zephyr/"

            // Checkout
            sh "west update"
                    	
        	    dir('zephyr') {                        	    
        	      sh "echo variant: $ZEPHYR_TOOLCHAIN_VARIANT"
                  sh "echo SDK dir: $ZEPHYR_SDK_INSTALL_DIR"
                  sh "cat /opt/zephyr-sdk/sdk_version"
    
                  sh "source zephyr-env.sh && \
                     (./scripts/sanitycheck $SANITYCHECK_OPTIONS $ARCH $PLATFORM || \
                     (sleep 10; ./scripts/sanitycheck $SANITYCHECK_OPTIONS $SANITYCHECK_RETRY) || \
                     (sleep 10; ./scripts/sanitycheck $SANITYCHECK_OPTIONS $SANITYCHECK_RETRY_2))"
                }      	    
        	}
           post {
               always {
                   cleanWs()
               }

           }                        
        }
        
        stage('Sanitycheck (all)') {
          when {
              not { changeRequest() }
          }
          agent {
            docker {
              image "$IMAGE_TAG"
              label "docker && build-node && ncs"
              args '-e PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/workdir/.local/bin'
            }
          }
          steps {
            // Initialize west
            sh "west init -l zephyr/"

            // Checkout
            sh "west update"

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
           post {
               always {
                   cleanWs()
               }
           }
         }
      }
    }
  }
}
