Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "MeshPipe"
  s.version      = "0.1.3"
  s.summary      = "IPC library for iOS"

  s.description  = <<-DESC
                    MeshPipe is an IPC (inter-process communication) library for iOS using UDP networking.
                    It allows multiple running applications on a single iOS device to send arbitrary data to each other.
                    It:

                    * Automatically connects to all other MeshPipe apps that are configured with the same port
                    * Detects when other apps disconnect or disappear, giving you a list of available peers

                    Since it is based on UDP, there are some hard-wired limitations:

                    * Message must fit within a single UDP datagram. The current UDP datagram max size on iOS is 9216 bytes.
                    * Delivery is not guaranteed. Messages may or may not get through, may arrive from seemingly unavailable peers, or arrive out of order.
                    * You may receive malicious or unexpected data, as any app on the phone could craft a message and send it to your app.
                    * Communication is insecure, and any app on the device might listen in or even change messages.
                    DESC

  s.homepage     = "https://github.com/nevyn/MeshPipe"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "Simplified BSD", :file => "LICENSE" }
  s.author             = { "Nevyn Bengtsson" => "nevyn.jpg@gmail.com" }
  s.social_media_url   = "http://twitter.com/nevyn"
  s.source       = { :git => "https://github.com/nevyn/MeshPipe.git", :tag => s.version }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'

  # ――― Subspecs with code ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.subspec "Core" do |core|
    core.source_files  = "MeshPipe/*.{h,m}"
    core.exclude_files = "MeshPipe/main.m"
    #core.public_header_files = "MeshPipe/MeshPipe.h"
    core.header_mappings_dir = 'Cerfing'
    core.dependency "CocoaAsyncSocket", '~> 7.4'
    core.dependency "GZIP", '~> 1.1'
  end

  s.subspec "CerfingMeshPipe" do |cerf|
    cerf.source_files        = "MeshPipe/CerfingMeshPipeTransport/*.{h,m}"
    #cerf.public_header_files = "MeshPipe/CerfingMeshPipeTransport/*.h"
    cerf.exclude_files       = "MeshPipe/CerfingMeshPipeTransport/main.m"
    cerf.dependency "Cerfing"
    cerf.dependency "MeshPipe/Core"
    cerf.header_mappings_dir = 'Cerfing'
  end

  s.default_subspecs = "Core"

end
