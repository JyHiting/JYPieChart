Pod::Spec.new do |s|
s.name         = 'JYPieChart'
s.version      = '1.0.0'
s.summary      = 'ios JYPieChart install by cocoapods'
s.homepage     = 'https://github.com/CodingEverydayForFuture/JYPieChart'
s.license      = 'MIT'
s.authors      = {'CodingEverydayForFuture' => '15238033727@163.com'}
s.platform     = :ios, '7.0'
s.source       = {:git => 'https://github.com/CodingEverydayForFuture/JYPieChart.git', :tag => s.version}
s.source_files = 'YQPieChart/JYPieChart/*.{h,m}'
s.requires_arc = true
end

s.subspec 'JYPieChart' do |ss|
ss.source_files = 'YQPieChart/JYPieChart/tool/*.{h,m}'
end
