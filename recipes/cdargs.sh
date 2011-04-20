
local URL="http://www.skamphausen.de/downloads/cdargs/cdargs-1.35.tar.gz"
local tb_file=`basename $URL`
local type="tar.gz"
local seed_name=$(extract_tool_name $tb_file $type)
local install_files=(bin/cdargs)

do_install()
{
  cd $TB_DIR
  download $URL $tb_file
  decompress_tool $tb_file $type
  cd $seed_name
  configure_tool $seed_name
  make_tool $seed_name
  install_tool $seed_name
  cp contrib/cdargs-bash.sh $LOCAL_DIR/bin
  link_from_stage $seed_name ${install_files[@]}
}

do_remove()
{
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
  rm -f $LOCAL_DIR/bin/cdargs-bash.sh
}

source "$MAIN_DIR/lib/case.sh"
