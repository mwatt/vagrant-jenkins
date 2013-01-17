class { 'gradle':
  version => '1.3',
}

package{"unzip":
    ensure=>"installed",
    before=> Class['gradle'],
}
 
package{"git-core":
    ensure=>"installed"
}

jenkins::plugin {
  "git" :
    version => "1.1.26";
}

jenkins::plugin {
  "gradle" :
    version => "1.21";
}

include jenkins
include gradle
