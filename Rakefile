require 'bundler'
require "bundler/gem_tasks"
require 'rake/testtask'
require 'fileutils'

Bundler.require

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

task :vcr do
  FileUtils.rm_rf('test/fixtures/vcr_cassettes')
end

task :watch do
  AllSeeingPi.watch
end
