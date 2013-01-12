require 'formula'

class Curl < Formula
  homepage 'http://curl.haxx.se/'
  url 'http://curl.haxx.se/download/curl-7.28.1.tar.gz'
  sha256 '78dce7cfff51ec5725442b92c00550b4e0ca2f45ad242223850a312cd9160509'


  #depends_on 'pkg-config' => :build

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --with-ssl
      --prefix=#{prefix}
    ]

    system "./configure", *args
    system "make install"
  end
end
