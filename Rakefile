#!/usr/bin/env rake
require 'bundler'
require "bundler/gem_tasks"


Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :test => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new

task :default => :spec