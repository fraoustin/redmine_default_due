# Wiki Notes plugin for Redmine
# Copyright (C) 2010 Daniel Seifert
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'redmine'
begin
  require 'config/initializers/session_store.rb'
  rescue LoadError
end

def init_default_due
  Dir::foreach(File.join(File.dirname(__FILE__), 'lib')) do |file|
    next unless /\.rb$/ =~ file
    require_dependency file
  end
end

if Rails::VERSION::MAJOR >= 6
  # Dynamically load all Hooks & Patches
  Dir::foreach(File.join(File.dirname(__FILE__), 'lib')) do |file|
    next unless file.end_with?('.rb')
    require_relative "lib/#{file.delete_suffix(".rb") }"
  end
elsif Rails::VERSION::MAJOR >= 5
  ActiveSupport::Reloader.to_prepare do
    init_default_due
  end
elsif Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    init_default_due
  end
else
  Dispatcher.to_prepare :redmine_default_due do
    init_default_due
  end
end

Redmine::Plugin.register :redmine_default_due do
  name 'Redmine Default Due'
  author 'Frederic AOUSTIN'
  description 'add "now" as default value for due when create issue'
  url "http://www.github.com/fraoustin/redmine_default_due" if respond_to?(:url)
  version '0.2.0'
  requires_redmine :version_or_higher => '2.3.0'
end
