dep 'AppleKeyboardUIMode', :template => 'defaults' do
  type 'int'
  value '3'
  global? true
end

dep 'NSNavPanelExpandedStateForSaveMode', :template => 'defaults' do
  type 'int'
  value '1'
  global? true
end

dep 'PMPrintingExpandedStateForPrint', :template => 'defaults' do
  type 'int'
  value '1'
  global? true
end

dep 'DSDontWriteNetworkStores', :template => 'defaults' do
  domain 'com.apple.desktopservices'
  type 'int'
  value '1'
end

dep '_FXShowPosixPathInTitle', :template => 'defaults' do
  domain 'com.apple.finder'
  type 'int'
  value '1'
  after { shell 'killall Finder' }
end

dep 'mineffect', :template => 'defaults' do
  domain 'com.apple.dock'
  type 'string'
  value 'SCALE'
  after { shell 'killall Dock' }
end

dep 'TMShowUnsupportedNetworkVolumes', :template => 'defaults' do
  domain 'com.apple.systempreferences'
  type 'int'
  value '1'
end

dep 'com.apple.swipescrolldirection', :template => 'defaults' do
  type 'int'
  value '0'
  global? true
end

dep 'autohide', :template => 'defaults' do
  domain 'com.apple.dock'
  type 'int'
  value '1'
  after { shell 'killall Dock' }
end

dep 'OS X Defaults' do
  requires 'AppleKeyboardUIMode', 'NSNavPanelExpandedStateForSaveMode', 'PMPrintingExpandedStateForPrint',
  'DSDontWriteNetworkStores', '_FXShowPosixPathInTitle', 'mineffect', 'TMShowUnsupportedNetworkVolumes',
  'com.apple.swipescrolldirection'
end