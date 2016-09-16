# update package database
#execute "yum update -y"

# install packages
package "autoconf"
package "automake"
package "cmake"
package "freetype-devel"
package "gcc"
package "gcc-c++"
package "git"
package "libtool"
package "make"
package "mercurial"
package "nasm"
package "pkgconfig"
package "zlib-devel"
package "bzip2"

directory "#{node[:ffmpeg][:source_path]}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end