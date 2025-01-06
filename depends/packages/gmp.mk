package=gmp
$(package)_version=6.3.0
$(package)_download_path=https://gmplib.org/download/gmp
$(package)_file_name=gmp-$($(package)_version).tar.bz2
$(package)_sha256_hash=3e3b88be773e4e726831688966861b89736e339b7cb22495810417271c1bf24b

define $(package)_fetch_cmds
    ( test -f $$($(package)_source_dir)/$(4) || \
        ( 
            (
                mkdir -p $$($(1)_download_dir) && \
                echo "Fetching $(3) from $(2)" && \
                $(build_DOWNLOAD) "$$($(1)_download_dir)/$(4).temp" "$(2)/$(3)" && \
                echo "$(5)  $$($(1)_download_dir)/$(4).temp" > $$($(1)_download_dir)/.$(4).hash && \
                $(build_SHA256SUM) -c $$($(1)_download_dir)/.$(4).hash && \
                mv $$($(1)_download_dir)/$(4).temp $$($(1)_source_dir)/$(4) && \
                rm -rf $$($(1)_download_dir)
            ) || \
            (
                sleep 5 && \
                (
                    mkdir -p $$($(1)_download_dir) && \
                    echo "Fetching $(3) from $(2)" && \
                    $(build_DOWNLOAD) "$$($(1)_download_dir)/$(4).temp" "$(2)/$(3)" && \
                    echo "$(5)  $$($(1)_download_dir)/$(4).temp" > $$($(1)_download_dir)/.$(4).hash && \
                    $(build_SHA256SUM) -c $$($(1)_download_dir)/.$(4).hash && \
                    mv $$($(1)_download_dir)/$(4).temp $$($(1)_source_dir)/$(4) && \
                    rm -rf $$($(1)_download_dir)
                )
            ) || \
            (
                sleep 10 && \
                (
                    mkdir -p $$($(1)_download_dir) && \
                    echo "Fetching $(3) from $(2)" && \
                    $(build_DOWNLOAD) "$$($(1)_download_dir)/$(4).temp" "$(2)/$(3)" && \
                    echo "$(5)  $$($(1)_download_dir)/$(4).temp" > $$($(1)_download_dir)/.$(4).hash && \
                    $(build_SHA256SUM) -c $$($(1)_download_dir)/.$(4).hash && \
                    mv $$($(1)_download_dir)/$(4).temp $$($(1)_source_dir)/$(4) && \
                    rm -rf $$($(1)_download_dir)
                )
            )
        )
    )
endef

define $(package)_set_vars
$(package)_config_opts+=--enable-cxx --enable-fat --with-pic --disable-shared
$(package)_cflags_armv7l_linux+=-march=armv7-a
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
