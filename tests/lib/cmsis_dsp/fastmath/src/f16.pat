static const uint16_t in_angles[23] = {
    0x0, 0x3a48, 0x3e48, 0x40b6, 0x4248, 0x43db, 0x44b6, 0x4648,
    0xba48, 0xbe48, 0xc0b6, 0xc248, 0xc3db, 0xc4b6, 0xc648, 0x4648,
    0x4712, 0x47db, 0x4852, 0x48b6, 0x491b, 0x497f, 0x4a48
    };

static const uint16_t in_sqrt[8] = {
    0xb666, 0x0, 0x2e66, 0x3c00, 0x4000, 0x4200, 0x4300, 0x4333
    };

static const uint16_t in_log[25] = {
    0x2e66, 0x34cd, 0x3800, 0x3c00, 0x4000, 0x2d2a, 0x3c00, 0x198f,
    0x342a, 0x365a, 0x247a, 0x2d19, 0x37c1, 0x339b, 0x343e, 0x319c,
    0x3b7c, 0x3852, 0x3708, 0x3299, 0x3437, 0x36c4, 0x356f, 0x306e,
    0x30e5
    };

static const uint16_t in_exp[52] = {
    0x0, 0x3c00, 0xb666, 0xb624, 0xb5e1, 0xb59e, 0xb55b, 0xb518,
    0xb4d5, 0xb492, 0xb44f, 0xb40d, 0xb393, 0xb30e, 0xb288, 0xb202,
    0xb17c, 0xb0f7, 0xb071, 0xafd6, 0xaecb, 0xadbf, 0xacb4, 0xab50,
    0xa939, 0xa645, 0xa02e, 0x202e, 0x2645, 0x2939, 0x2b50, 0x2cb4,
    0x2dbf, 0x2ecb, 0x2fd6, 0x3071, 0x30f7, 0x317c, 0x3202, 0x3288,
    0x330e, 0x3393, 0x340d, 0x344f, 0x3492, 0x34d5, 0x3518, 0x355b,
    0x359e, 0x35e1, 0x3624, 0x3666
    };

static const uint16_t in_vinverse[256] = {
    0x2cd1, 0x22d8, 0x330f, 0x3446, 0x368f, 0x312d, 0x33fe, 0x2dac,
    0x3854, 0x31c4, 0x3935, 0x2844, 0x2811, 0x2b4c, 0x369d, 0x335b,
    0x329c, 0x2fe6, 0x301e, 0x2dd7, 0x3822, 0x2c50, 0x364e, 0x36df,
    0x3abc, 0x2ec4, 0x30e6, 0x288e, 0x35c4, 0x38f7, 0x3373, 0x2f87,
    0x30fa, 0x38dd, 0x325f, 0x257c, 0x300a, 0x3807, 0x2d38, 0x323e,
    0x3489, 0x352a, 0x2dac, 0x31a0, 0x28f7, 0x281b, 0x31eb, 0x3bf8,
    0x3677, 0x3216, 0x30af, 0x3774, 0x33da, 0x30bd, 0x34da, 0x34fb,
    0x1ea1, 0x367c, 0x2ccb, 0x3586, 0x2db7, 0x37a3, 0x3161, 0x1814,
    0x2e8a, 0x2930, 0x2f00, 0x329c, 0x36f0, 0x3644, 0x30e7, 0x2d13,
    0x2e4c, 0x32c0, 0x353a, 0x2c3f, 0x2a96, 0x1aba, 0x3454, 0x3aaa,
    0x2d51, 0x3117, 0x261b, 0x2c74, 0x35a0, 0x3693, 0x2acf, 0x3475,
    0x2593, 0x2ba5, 0x2eba, 0x1bac, 0x1f36, 0x3a48, 0x33df, 0x353b,
    0x3539, 0x2d37, 0x2b83, 0x3a5a, 0x35ac, 0x30ab, 0x304b, 0x38f8,
    0x2d85, 0x2fcf, 0x356c, 0x36ec, 0x2ea0, 0x3949, 0x2173, 0x2195,
    0x3573, 0x26ec, 0x38c1, 0x342c, 0x33f6, 0x2f5e, 0x342d, 0x31aa,
    0x1e21, 0x2e07, 0x37d9, 0x350c, 0x2035, 0x3814, 0x3475, 0x30e2,
    0x370a, 0x3128, 0x3a59, 0x3a05, 0x3073, 0x324f, 0x33ce, 0x2c5f,
    0x2f8e, 0x2724, 0x28f1, 0x2fbb, 0x30dd, 0x3507, 0x3511, 0x2821,
    0x3273, 0x2885, 0x34c3, 0x2ccb, 0x3033, 0x2d1a, 0x34fd, 0x292d,
    0x358d, 0x32c1, 0x2d84, 0x2eb6, 0x2baf, 0x35d9, 0x30d3, 0x2d9d,
    0x384e, 0x2dc3, 0x3776, 0x349c, 0x3073, 0x371c, 0x31fa, 0x375a,
    0x3096, 0x2de9, 0x33ec, 0x2aa2, 0x2c65, 0x388b, 0x335e, 0x382f,
    0x2012, 0x3135, 0x34d1, 0x1f3d, 0x3697, 0x3254, 0x2b54, 0x31d5,
    0x3455, 0x3197, 0x35af, 0x2b37, 0x1e89, 0x2ea7, 0x3477, 0x307e,
    0x3436, 0x2a14, 0x3092, 0x38c2, 0x28e1, 0x3749, 0x353c, 0x25d2,
    0x3292, 0x245d, 0x3822, 0x251a, 0x2c8c, 0x3707, 0x2c2f, 0x344e,
    0x342b, 0x3489, 0x3696, 0x2dc9, 0x318a, 0x3584, 0x32ef, 0x359f,
    0x2f8e, 0x31ca, 0x33dd, 0x336c, 0x36a3, 0x32ad, 0x3819, 0x36ce,
    0x3724, 0x3160, 0x313a, 0x30d0, 0x2b8b, 0x3c00, 0x325e, 0x31bf,
    0x2fcb, 0x366e, 0x3811, 0x34bf, 0x2852, 0x3501, 0x3970, 0x2f2c,
    0x3553, 0x354a, 0x335f, 0x3839, 0x347e, 0x34f3, 0x38e9, 0x35bb,
    0x2fc5, 0x2f44, 0x271c, 0x2d03, 0x315d, 0x38c9, 0x35ee, 0x2bcd
    };

static const uint16_t ref_cos[23] = {
    0x3c00, 0x39a8, 0x0, 0xb9a8, 0xbc00, 0xb9a8, 0x8000, 0x3c00,
    0x39a8, 0x0, 0xb9a8, 0xbc00, 0xb9a8, 0x8000, 0x3c00, 0x3c00,
    0x39a8, 0x0, 0xb9a8, 0xbc00, 0xb9a8, 0x8000, 0x3c00
    };

static const uint16_t ref_sin[23] = {
    0x0, 0x39a8, 0x3c00, 0x39a8, 0x0, 0xb9a8, 0xbc00, 0x8011,
    0xb9a8, 0xbc00, 0xb9a8, 0x8000, 0x39a8, 0x3c00, 0x8011, 0x8000,
    0x39a8, 0x3c00, 0x39a8, 0x0, 0xb9a8, 0xbc00, 0x8011
    };

static const uint16_t ref_sqrt[8] = {
    0x0, 0x0, 0x350f, 0x3c00, 0x3da8, 0x3eee, 0x3f7c, 0x3f97
    };

static const uint16_t ref_log[25] = {
    0xc09b, 0xbcd1, 0xb98c, 0x0, 0x398c, 0xc109, 0x0, 0xc5e9,
    0xbd62, 0xbb64, 0xc40c, 0xc10f, 0xb9cb, 0xbdbf, 0xbd4f, 0xbef7,
    0xac45, 0xb8ee, 0xba94, 0xbe51, 0xbd56, 0xbae2, 0xbc52, 0xbfe9,
    0xbf83
    };

static const uint16_t ref_exp[52] = {
    0x3c00, 0x4170, 0x395d, 0x3973, 0x398a, 0x39a2, 0x39b9, 0x39d2,
    0x39ea, 0x3a03, 0x3a1c, 0x3a36, 0x3a50, 0x3a6b, 0x3a86, 0x3aa1,
    0x3abd, 0x3ada, 0x3af7, 0x3b14, 0x3b32, 0x3b50, 0x3b6f, 0x3b8e,
    0x3bae, 0x3bce, 0x3bef, 0x3c08, 0x3c19, 0x3c2b, 0x3c3c, 0x3c4e,
    0x3c60, 0x3c73, 0x3c85, 0x3c98, 0x3cac, 0x3cbf, 0x3cd3, 0x3ce8,
    0x3cfd, 0x3d12, 0x3d27, 0x3d3d, 0x3d53, 0x3d69, 0x3d80, 0x3d97,
    0x3daf, 0x3dc7, 0x3ddf, 0x3df8
    };

static const uint16_t ref_vinverse[256] = {
    0x4aa4, 0x54ad, 0x4489, 0x437e, 0x40e1, 0x462e, 0x4401, 0x49a4,
    0x3f64, 0x458d, 0x3e25, 0x4f80, 0x4fde, 0x4c63, 0x40d7, 0x445a,
    0x44d7, 0x480d, 0x47c7, 0x497b, 0x3fbe, 0x4b6c, 0x4114, 0x40a8,
    0x3cc0, 0x48bb, 0x4688, 0x4f07, 0x418d, 0x3e71, 0x444c, 0x4840,
    0x466f, 0x3e94, 0x4506, 0x51d6, 0x47ec, 0x3ff2, 0x4a22, 0x4521,
    0x430e, 0x4233, 0x49a4, 0x45b1, 0x4e72, 0x4fcb, 0x4568, 0x3c04,
    0x40f3, 0x4542, 0x46d5, 0x404b, 0x4413, 0x46c1, 0x4299, 0x426c,
    0x58d4, 0x40ef, 0x4aad, 0x41cb, 0x4999, 0x4031, 0x45f3, 0x5fd9,
    0x48e5, 0x4e2c, 0x4892, 0x44d8, 0x409d, 0x411c, 0x4688, 0x4a4f,
    0x4915, 0x44be, 0x4220, 0x4b89, 0x4cdc, 0x5cc2, 0x4365, 0x3ccd,
    0x4a05, 0x4649, 0x513e, 0x4b2f, 0x41b0, 0x40de, 0x4cb3, 0x432e,
    0x51bd, 0x4c30, 0x48c2, 0x5c2c, 0x5870, 0x3d18, 0x4411, 0x421e,
    0x4221, 0x4a23, 0x4c43, 0x3d0a, 0x41a4, 0x46db, 0x4774, 0x3e70,
    0x49cc, 0x4819, 0x41e7, 0x40a0, 0x48d5, 0x3e0e, 0x55df, 0x55bc,
    0x41df, 0x509f, 0x3ebb, 0x43ac, 0x4405, 0x4858, 0x43aa, 0x45a7,
    0x5938, 0x4950, 0x4014, 0x4257, 0x579b, 0x3fd9, 0x432d, 0x468d,
    0x408c, 0x4635, 0x3d0a, 0x3d51, 0x4731, 0x4513, 0x4419, 0x4b52,
    0x483c, 0x507b, 0x4e7a, 0x4824, 0x4694, 0x425e, 0x4251, 0x4fbf,
    0x44f6, 0x4f14, 0x42b9, 0x4aae, 0x479e, 0x4a46, 0x426a, 0x4e2f,
    0x41c4, 0x44bd, 0x49cd, 0x48c5, 0x4c2a, 0x4179, 0x46a2, 0x49b4,
    0x3f6f, 0x498e, 0x404a, 0x42f1, 0x4732, 0x4080, 0x455b, 0x405a,
    0x46fa, 0x496a, 0x440a, 0x4cd3, 0x4b49, 0x3f0b, 0x4458, 0x3fa6,
    0x57dd, 0x4626, 0x42a5, 0x586c, 0x40db, 0x450f, 0x4c5e, 0x457d,
    0x4363, 0x45b9, 0x41a2, 0x4c6f, 0x58e6, 0x48d0, 0x432a, 0x471f,
    0x439a, 0x4d44, 0x4701, 0x3eba, 0x4e8f, 0x4065, 0x421d, 0x517f,
    0x44df, 0x5356, 0x3fbe, 0x5246, 0x4b0a, 0x408e, 0x4ba6, 0x4370,
    0x43ae, 0x430e, 0x40dc, 0x4988, 0x45c7, 0x41ce, 0x449d, 0x41b1,
    0x483c, 0x4587, 0x4412, 0x4450, 0x40d2, 0x44cb, 0x3fcf, 0x40b4,
    0x407b, 0x45f4, 0x461f, 0x46a6, 0x4c3e, 0x3c00, 0x4506, 0x4592,
    0x481b, 0x40fa, 0x3fde, 0x42be, 0x4f67, 0x4265, 0x3de2, 0x4876,
    0x4203, 0x420d, 0x4457, 0x3f94, 0x4320, 0x4277, 0x3e84, 0x4195,
    0x481e, 0x4868, 0x5080, 0x4a62, 0x45f7, 0x3eb0, 0x4166, 0x4c1a
    };
