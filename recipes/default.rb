#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

ruby_version = node['ruby']['version']
gem_version = node['ruby']['gem_version']
bundler_version = ['ruby']['bundler_version']

package 'readline-devel'

include_recipe 'ruby-build'

ruby_build_ruby ruby_version do
  prefix_path '/usr/local'
  environment ({
    'CFLAGS' => '-g O2',
    'TMPDIR' => '/opt/ruby-build'
  })
  action node['ruby']['install_action']
end

bash "gem update --system #{gem_version}" do
  code "/usr/local/bin/gem update --system #{gem_version}"
  not_if "/usr/local/bin/gem -v | grep ^#{gem_version}"
end

gem_package 'bundler' do
  gem_binary '/usr/local/bin/gem'
  version bundler_version
end
