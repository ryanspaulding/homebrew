require 'formula'

class ModPython< Formula
  url 'http://archive.apache.org/dist/httpd/modpython/mod_python-3.3.1.tgz'
  md5 'a3b0150176b726bd2833dac3a7837dc5'


  def install
    args = %W[
      --prefix=#{prefix}
      --with-apxs=#{HOMEBREW_PREFIX}/bin/apxs
    ]

    system "./configure", *args
    system "make"
    system "make install"
  end

end
