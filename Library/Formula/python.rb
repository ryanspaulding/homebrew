require 'formula'

class Python <Formula
  url 'http://www.python.org/ftp/python/2.7.3/Python-2.7.3.tgz'
  md5 '2cf641732ac23b18d139be077bd906cd'

  def install
    system "./configure", 
                          "--prefix=#{prefix}",
			  "--enable-unicode=ucs4", 
			  "--enable-ipv6"
    system "make install"
  end

  def caveats
        <<-EOS.undent
	Add this to your bashrc file if you want to use it!
        	export LD_LIBRARY_PATH=homebrew/lib

	Setup pip, run the following:
        export LD_LIBRARY_PATH=homebrew/lib ; curl http://python-distribute.org/distribute_setup.py | #{HOMEBREW_PREFIX}/bin/python
	curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | #{HOMEBREW_PREFIX}/bin/python
	EOS
  end
end
