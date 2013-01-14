require 'formula'

class Apache < Formula
  url 'http://mirrors.gigenet.com/apache//httpd/httpd-2.0.64.tar.gz'
  md5 '59c987a31196bb9d025fdf62ec011b99'


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
