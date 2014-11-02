require 'rake/testtask'
require 'bundler'
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
