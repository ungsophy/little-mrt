task default: [:test]

task :test do
  Dir.glob('./test/**/*_test.rb') { |file| require file }
end
