#!/bin/bash
#
# Copyright 2013 Dean Okamura
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# file_cache_path
if [ ! -d /tmp/vagrant-chef-1/chef-solo-1 ] ; then
    mkdir -p /tmp/vagrant-chef-1/chef-solo-1
fi
# cookbook_path
if [ ! -d /tmp/vagrant-chef-1/chef-solo-1/cookbooks -a \
     ! -L /tmp/vagrant-chef-1/chef-solo-1/cookbooks -a \
     -d $HOME/apmaas/endpoint/cookbooks ] ; then
   ln -sf $HOME/cookbooks /tmp/vagrant-chef-1/chef-solo-1/cookbooks
fi
if [ ! -d /tmp/vagrant-chef-1/chef-solo-2/cookbooks -a \
     ! -L /tmp/vagrant-chef-1/chef-solo-1/cookbooks -a \
     -d $HOME/cookbooks ] ; then
   ln -sf $HOME/cookbooks /tmp/vagrant-chef-1/chef-solo-2/cookbooks
fi

# Vagrant usually runs Chef as root
# Note: RECIPE is an experimental environment variable
if [ ! "$1" = "" ] ; then
    RECIPE=$1
fi
case "$RECIPE" in
bare|dev ) sudo chef-solo -j $RECIPE.json -c solo.rb ;;
* ) if [ -f /usr/local/bin/rvm ] ; then
        rvmsudo chef-solo -j default.json -c solo.rb
    else
        sudo chef-solo -j default.json -c solo.rb
    fi ;;
esac

#
