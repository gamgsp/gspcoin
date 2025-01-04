package=gmp
$(package)_version=6.2.1
$(package)_download_path=https://ftp.gnu.org/gnu/gmp/
$(package)_file_name=gmp-$($(package)_version).tar.bz2
$(package)_sha256_hash=fd4829912b6c5bb4d6fbb0a2b6f7e4b0f567ef2d3a8e0d9fdb5c3d3c2e3d6e9a

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
