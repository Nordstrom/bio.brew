local URL="http://subversion.tigris.org/downloads/subversion-1.6.13.tar.gz"
local URL_2="http://subversion.tigris.org/downloads/subversion-deps-1.6.13.tar.gz"
local tb_file=`basename $URL`
local tb_file_2=`basename $URL_2`
local type="tar.gz"
local seed_name=$(extract_tool_name $tb_file $type)
local install_files=(bin/svn)
local deps=()
local external_deps=("openssl-devel")
do_install()
{
  cd $TB_DIR
  download $URL $tb_file
  decompress_tool $tb_file $type
  download $URL_2 $tb_file_2
  decompress_tool $tb_file_2 $type
  cd $seed_name
  configure_tool $seed_name "--with-ssl"
  make_tool $seed_name $make_j
  install_tool $seed_name
  link_from_stage $seed_name ${install_files[@]}
}

do_remove()
{
  remove_recipe $seed_name
  remove_from_stage $seed_name ${install_files[@]}
}

source "$MAIN_DIR/lib/case.sh"
