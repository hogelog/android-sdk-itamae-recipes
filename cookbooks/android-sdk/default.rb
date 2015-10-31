VERSION = "r24.3.4"

directory "/opt/src"

execute "download sdk" do
  cwd "/opt/src"
  command <<-EOM
    wget -N http://dl.google.com/android/android-sdk_#{VERSION}-linux.tgz
    tar xf android-sdk_#{VERSION}-linux.tgz
    mv android-sdk-linux android-sdk_#{VERSION}
    ln -s /opt/src/android-sdk_#{VERSION} /opt/android-sdk
  EOM
  not_if "/opt/src/android-sdk_#{VERSION}"
end
