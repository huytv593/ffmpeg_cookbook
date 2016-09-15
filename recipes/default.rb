#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe "ffmpeg::#{node[:ffmpeg][:dependencies]}"
include_recipe "ffmpeg::#{node[:ffmpeg][:install_method]}"