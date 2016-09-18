# Install yasm
bash "install_yasm" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
	tar xzvf yasm-1.3.0.tar.gz
	cd yasm-1.3.0
	autoreconf -fiv
	./configure --prefix="$HOME/ffmpeg_build" --bindir="/usr/local/bin"
	make -j 4
	sudo make install
	make distclean
	EOH
end

# Install x264
bash "install_x264" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O ftp://ftp.videolan.org/pub/x264/snapshots/x264-snapshot-20160915-2245.tar.bz2
	tar xjf x264-snapshot-20160915-2245.tar.bz2
	cd x264-snapshot-20160915-2245
	export PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" 
	./configure --prefix="$HOME/ffmpeg_build" --bindir="/usr/local/bin" --enable-static
	make
	make install
	make distclean
	EOH
end

# Install x265
bash "install_x265" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O http://ftp.videolan.org/pub/videolan/x265/x265_2.0.tar.gz
	tar xzvf x265_2.0.tar.gz
	cd x265_2.0/build/linux
	cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
	make
	make install
	EOH
end

# Install libogg
bash "install_libvorbis" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz
	tar xzvf libogg-1.3.2.tar.gz
	cd libogg-1.3.2
	./configure --prefix="$HOME/ffmpeg_build" --disable-shared
	make
	make install
	make distclean
	EOH
end

# Install libfdk_aac
bash "install_libfdk_aac" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O http://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-0.1.4.tar.gz
	tar xzvf fdk-aac-0.1.4.tar.gz
	cd fdk-aac-0.1.4
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
	./configure --prefix="$HOME/ffmpeg_build" --disable-shared --enable-nasm
	make
	make install
	make distclean
	EOH
end

# Install libopus
bash "install_libfdk_aac" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O https://archive.mozilla.org/pub/opus/opus-tools-0.1.9.tar.gz
	tar xzvf opus-tools-0.1.9.tar.gz
	cd opus-tools-0.1.9
	autoreconf -fiv
	export PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
	./configure --prefix="$HOME/ffmpeg_build" --disable-shared
	make
	make install
	make distclean
	EOH
end

# Install libvorbis
bash "install_libvorbis" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz
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
bash "install_libvpx" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.6.0.tar.bz2
	tar xjf libvpx-1.6.0.tar.bz2
	cd libvpx-1.6.0
	./configure --prefix="$HOME/ffmpeg_build" --disable-examples
	make
	make install
	make distclean
	EOH
end

# Install FFmpeg
bash "install_ffmpeg" do
	cwd "#{node[:ffmpeg][:source_path]}"
	code <<-EOH
	curl -L -O http://ffmpeg.org/releases/ffmpeg-3.1.3.tar.bz2
	tar xjf ffmpeg-3.1.3.tar.bz2
	cd ffmpeg-3.1.3
	PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" 
	./configure --prefix="$HOME/ffmpeg_build" --bindir="/usr/local/bin" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265
	make
	make install
	make distclean
	EOH
end
