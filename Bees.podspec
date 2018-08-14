

Pod::Spec.new do |s|

  s.name         = "Bees"
  s.version      = "1.0"
  s.summary      = "简单易用的Swift布局库"

  s.description  = <<-DESC
                    "Bees 是一个简单易用的布局库，支持链式调用。减少了使用代码自动布局时的代码量。"
                   DESC

  s.homepage     = "https://github.com/hongcaiyu/Bees"


  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author       = { "Caiyu Hong" => "hongcaiyu@live.com" }

  s.ios.deployment_target  = "8.0"
  s.osx.deployment_target  = "10.10"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/hongcaiyu/Bees.git", :tag => s.version }
  s.source_files = "Bees/*.swift"

end
