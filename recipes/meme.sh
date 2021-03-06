local version="4.8.1"
local type="tar.gz"
local URL="http://meme.nbcr.net/downloads/meme_${version}.${type}"
local tb_file=`basename $URL`
local seed_name="meme_${version}"
local deps=(mpich2)

do_install()
{
  cd $TB_DIR
  download $URL $tb_file
  decompress_tool $tb_file $type
  mv $seed_name $STAGE_DIR
  cd $STAGE_DIR/$seed_name
  configure_tool $seed_name "--with-url=\"http://meme.ncbr.net/meme\" --enable-build-libxml2 --enable-build-libxslt --with-mpidir=/n/local/stage/mpich2/current/install --with-python=/usr/bin/python" "$STAGE_DIR/$seed_name/install"
  make_tool $seed_name $make_j
  install_tool $seed_name
}

do_activate()
{
  switch_current $seed_name
  ln -s $STAGE_DIR/current/install/bin $BIN_DIR/meme
  for_env "export PATH=\"$BIN_DIR/meme:\$PATH\""
  link_include $seed_name 'install/include'
  link_library $seed_name 'install/lib'
}

do_test()
{
  cd $STAGE_DIR/$seed_name
  make test
  log "test"
}

do_remove()
{
  remove_recipe $seed_name
  rm -f $BIN_DIR/meme
}

source "$MAIN_DIR/lib/case.sh"
