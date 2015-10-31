VERSION = "r24.3.4"
SDK_PACKAGES = "platform-tools,build-tools-23.0.2,android-23,sys-img-x86-android-23,extra-android-m2repository,extra-google-m2repository"

execute "install 32bit libraries" do
  command <<-EOM
    dpkg --add-architecture i386
    apt-get update
    apt-get install libncurses5:i386 libstdc++6:i386 zlib1g:i386
  EOM
end

package "openjdk-8-jdk"

directory "/opt/src"

execute "download sdk" do
  cwd "/opt/src"
  command <<-EOM
    wget -N http://dl.google.com/android/android-sdk_#{VERSION}-linux.tgz
    tar xf android-sdk_#{VERSION}-linux.tgz
    mv android-sdk-linux android-sdk_#{VERSION}
    ln -s /opt/src/android-sdk_#{VERSION} /opt/android-sdk
  EOM
  not_if "test -e /opt/src/android-sdk_#{VERSION}"
end

execute "update android sdk" do
  command <<-EOM
    export ANDROID_HOME=/opt/android-sdk
    export ANDROID_SDK=/opt/android-sdk
    export PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
    echo y | android update sdk --no-ui --all --filter #{SDK_PACKAGES}
  EOM
  not_if "test -e /opt/android-sdk/platform-tools"
end
