# update package database
#execute "yum update -y"

# install packages
package ["autoconf", "automake", "cmake", "freetype-devel", "gcc", "gcc-c++", "git", "libtool", "make", "mercurial", "nasm", "pkgconfig", "zlib-devel"]

directory "${Chef::Config[:ffmpeg][:source_path]}" do
	owner "root"
  group "root"
  mode "0755"
  action :create
end