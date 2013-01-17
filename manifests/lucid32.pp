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
  "git" : ;
}

jenkins::plugin{
  "gradle" : ;
}

include jenkins
include gradle