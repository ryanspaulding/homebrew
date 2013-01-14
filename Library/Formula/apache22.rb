require 'formula'

class Apache < Formula
  url 'http://mirror.quintex.com/apache/httpd/httpd-2.2.23.tar.gz'
  sha1 '966445d503ecb72e3eadf864cd21028d00d441a2'


  def install
    args = %W[
      --prefix=#{prefix}
      --mandir=#{man}
    ]

    system "./configure", *args
    system "make"
    system "make install"
  end

end
