require 'formula'

class GitManuals < Formula
  url 'http://git-core.googlecode.com/files/git-manpages-1.8.1.tar.gz'
  sha1 'a9ab9de3fa1781bb5009f5a215374dfc694feb30'
end

class GitHtmldocs < Formula
  url 'http://git-core.googlecode.com/files/git-htmldocs-1.8.1.tar.gz'
  sha1 'a256fc56c89dc3c8d58b81a2c02dc89299f1f29b'
end

class Git < Formula
  url 'http://git-core.googlecode.com/files/git-1.8.1.tar.gz'
  sha1 'ac8dced9c3232c0ec6a88d04600a4d0eaf2ba4e3'
  homepage 'http://git-scm.com'
  depends_on 'expat'

  head 'https://github.com/git/git.git'
  
  depends_on 'pcre' 

  def install
    # if these things are installed, tell git build system to not use them
    ENV['NO_FINK']='1'
    ENV['NO_DARWIN_PORTS']='1'
    # If local::lib is used you get a 'Only one of PREFIX or INSTALL_BASE can be given' error
    ENV['PERL_MM_OPT']='';
    # build verbosely so we can debug better
    ENV['V']='1'
    ENV['NO_GETTEXT'] = '1'

    ENV['BLK_SHA1'] = '1' 
    ENV['NO_PERL_MAKEMAKER'] = '1'

    ENV['USE_LIBPCRE'] = '1'
    ENV['LIBPCREDIR'] = HOMEBREW_PREFIX

    system "make", "prefix=#{prefix}",
                   "CC=#{ENV.cc}",
                   "CFLAGS=#{ENV.cflags}",
                   "LDFLAGS=#{ENV.ldflags}",
                   "install"
    # Install git-subtree
    cd 'contrib/subtree' do
      system "make", "CC=#{ENV.cc}",
                     "CFLAGS=#{ENV.cflags}",
                     "LDFLAGS=#{ENV.ldflags}"
      bin.install 'git-subtree'
    end

    # install the completion script first because it is inside 'contrib'
    (prefix+'etc/bash_completion.d').install 'contrib/completion/git-completion.bash'
    (prefix+'etc/bash_completion.d').install 'contrib/completion/git-prompt.sh'
    (share+'git-core').install 'contrib'

    # We could build the manpages ourselves, but the build process depends
    # on many other packages, and is somewhat crazy, this way is easier.
    GitManuals.new.brew { man.install Dir['*'] }
    GitHtmldocs.new.brew { (share+'doc/git-doc').install Dir['*'] }

  end

  def test
    HOMEBREW_REPOSITORY.cd do
      `#{bin}/git ls-files -- bin`.chomp == 'bin/brew'
    end
  end
end
