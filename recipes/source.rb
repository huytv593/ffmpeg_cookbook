# Install yasm
git "#{node[:ffmpeg][:source_path]}/yasm" do
	repository 'git://github.com/yasm/yasm.git'
  revision 'master'
  action :sync
end

bash "install_yasm" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	cd yasm
	autoreconf -fiv
	./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
	make
	make install
	make distclean
	EOH
end

# Install x264
git "#{node[:ffmpeg][:source_path]}/x264" do
	repository 'git://git.videolan.org/x264'
  revision 'master'
  action :sync
end

bash "install_x264" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	cd x264
	export PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" 
	./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
	make
	make install
	make distclean
	EOH
end

# Install x265
bash "install_x265" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	hg clone https://bitbucket.org/multicoreware/x265
	cd x265/build/linux
	cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
	make
	make install
	EOH
end

# Install libfdk_aac
git "#{node[:ffmpeg][:source_path]}/fdk_aac" do
	repository 'git://git.code.sf.net/p/opencore-amr/fdk-aac'
  revision 'master'
  action :sync
end

bash "install_libfdk_aac" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	cd fdk_aac
	autoreconf -fiv
	./configure --prefix="$HOME/ffmpeg_build" --disable-shared
	make
	make install
	make distclean
	EOH
end

# Install libmp3lame
bash "install_libmp3lame" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
	tar xzvf lame-3.99.5.tar.gz
	cd lame-3.99.5
	./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm
	make
	make install
	make distclean
	EOH
end

# Install libopus
git "#{node[:ffmpeg][:source_path]}/opus" do
	repository 'http://git.opus-codec.org/opus.git'
  revision 'master'
  action :sync
end

bash "install_libfdk_aac" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	cd opus
	autoreconf -fiv
	export PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
	./configure --prefix="$HOME/ffmpeg_build" --disable-shared
	make
	make install
	make distclean
	EOH
end

# Install libogg
bash "install_libogg" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz
	tar xzvf libvorbis-1.3.4.tar.gz
	cd libvorbis-1.3.4
	LDFLAGS="-L$HOME/ffmeg_build/lib" 
	CPPFLAGS="-I$HOME/ffmpeg_build/include" 
	./configure --prefix="$HOME/ffmpeg_build" --with-ogg="$HOME/ffmpeg_build" --disable-shared
	make
	make install
	make distclean
	EOH
end

# Install libvpx
git "#{node[:ffmpeg][:source_path]}/libvpx" do
	repository 'https://chromium.googlesource.com/webm/libvpx.git'
  revision 'master'
  action :sync
end

bash "install_libvpx" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	cd libvpx
	./configure --prefix="$HOME/ffmpeg_build" --disable-examples
	make
	make install
	make distclean
	EOH
end

# Install FFmpeg
git "#{node[:ffmpeg][:source_path]}/ffmpeg" do
	repository 'https://git.ffmpeg.org/ffmpeg.git'
  revision 'master'
  action :sync
end

bash "install_libvpx" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" 
	./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265
	make
	make install
	make distclean
	EOH
end
