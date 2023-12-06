release_tag_name = 'peer2peer-v0.0.1' # generated; do not edit

# We cannot distribute the XCFramework alongside the library directly,
# so we have to fetch the correct version here.
framework_name = 'Peer2Peer.xcframework'
remote_zip_name = "#{framework_name}.zip"
url = "https://github.com/kushalmahapatro/peer2peer/releases/download/#{release_tag_name}/#{remote_zip_name}"
local_zip_name = "#{release_tag_name}.zip"

`
cd Frameworks
rm -rf #{framework_name}

if [ ! -f #{remote_zip_name} ]; then
  if [ -f #{local_zip_name} ]; then
    curl -L #{url} -o #{local_zip_name}
  fi
fi

if [ -f #{remote_zip_name} ]; then
  unzip #{remote_zip_name}
else
  unzip #{local_zip_name}
fi

cd -
`

Pod::Spec.new do |spec|
  spec.name          = 'flutter_peer2peer'
  spec.version       = '0.0.1'
  spec.license       = { :file => '../LICENSE' }
  spec.homepage      = 'https://github.com/kushalmahapatro/peer2peer'
  spec.authors       = { 'Kushal Mahapatro' => 'kushalmahapatro@gmail.com' }
  spec.summary       = 'iOS/macOS Flutter bindings for library_name'

  spec.source              = { :path => '.' }
  spec.source_files        = 'Classes/**/*'
  spec.public_header_files = 'Classes/**/*.h'
  spec.vendored_frameworks = "Frameworks/#{framework_name}"

  spec.ios.deployment_target = '11.0'
  spec.osx.deployment_target = '10.13'
end
