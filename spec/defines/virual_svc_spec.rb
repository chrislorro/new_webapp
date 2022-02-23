# frozen_string_literal: true

require 'spec_helper'

describe 'my_webapp::virtual_svc' do
  let(:title) { 'example.conf' }
  let(:params) do
    {
      :vhost_path  => '/etc/httpd/conf/example.conf',
      :listen_ip   => '192.168.254.2',
      :websvc_port => 8080,  
      :servicename => 'example',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "virtual_svc on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile } unless %r{windows}.match?(os)

      it { is_expected.to contain_file('example.conf')
        .with('path'    => '/etc/httpd/conf/example.conf')
        .with('ensure'  => 'present')
        .with('mode'    => '0640')
        .with('owner'   => 'root') unless %r{windows}.match?(os)
      }
      # it { is_expected.to contain_file('/etc/httpd/conf/example.conf')
      #   .with_content(%r{    ServerName www.example.com}) unless %r{windows}.match?(os) 
      # }
    end
  end
end