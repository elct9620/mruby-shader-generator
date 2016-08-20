task :default do
  sh "./mruby/build/host/bin/mirb ./test/app.rb"
end

task :build do
  ENV["MRUBY_CONFIG"] = File.expand_path("build_config.rb")
  sh "cd ./mruby && ./minirake"
end
