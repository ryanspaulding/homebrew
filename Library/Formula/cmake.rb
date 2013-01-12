require 'formula'

class Cmake < Formula
  homepage 'http://www.cmake.org/'
  url 'http://www.cmake.org/files/v2.8/cmake-2.8.10.1.tar.gz'
  sha1 'ff536d0592a0433ef3610f1861886712b99979a5'

  depends_on 'curl'
  depends_on 'expat'

  def install
    args = %W[
      --prefix=#{prefix}
      --no-system-libs
      --datadir=/share/cmake
      --docdir=/share/doc/cmake
      --mandir=/share/man
    ]

    system "./bootstrap", *args
    system "make"
    system "make install"
  end

  def test
    system "#{bin}/cmake", "-E", "echo", "testing"
  end
end
