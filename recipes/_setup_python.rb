#
# Cookbook Name:: cfncluster
# Recipe:: _setup_python
#
# Copyright 2013-2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the
# License. A copy of the License is located at
#
# http://aws.amazon.com/apache2.0/
#
# or in the "LICENSE.txt" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
# OR CONDITIONS OF ANY KIND, express or implied. See the License for the specific language governing permissions and
# limitations under the License.

case node['platform_family']
when 'rhel', 'amazon'
  if node['platform_version'].to_i < 7
    package 'python-pip'
    package 'python-devel'
    bash 'update pip and setuptools' do
      code <<-PIP
        pip install --upgrade pip==7.1.2
        pip install --upgrade setuptools==18.8
      PIP
    end
  else
    edit_resource(:python_runtime, '2') do
      # FIXME: https://github.com/poise/poise-python/issues/133
      pip_version '18.0'
    end
    python_runtime '2' do
      version '2'
      provider :system
    end
  end
when 'debian'
  edit_resource(:python_runtime, '2') do
    # FIXME: https://github.com/poise/poise-python/issues/133
    pip_version '18.0'
  end
  python_runtime '2' do
    version '2'
    provider :system
  end
end
