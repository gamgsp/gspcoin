package=gmp
$(package)_version=6.3.0
$(package)_download_path=https://gmplib.org/download/gmp
$(package)_file_name=gmp-$($(package)_version).tar.bz2
$(package)_sha256_hash=3e3b88be773e4e726831688966861b89736e339b7cb22495810417271c1bf24b

define $(package)_set_vars
$(package)_config_opts+=--enable-cxx --enable-fat --with-pic --disable-shared
$(package)_cflags_armv7l_linux+=-march=armv7-a
$(package)_cflags_aarch64_darwin+=-march=armv8-a
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef

define $(package)_postprocess_cmds
  rm lib/*.la
endef
