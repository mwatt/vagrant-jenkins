class { 'gradle':
  version => '1.6',
  timeout => 1500, 
}

package{"unzip":
    ensure=>"installed",
    before=> Class['gradle'],
    require=>Exec['apt-get update'],
}
 
package{"git-core":
    ensure=>"installed"
}

user { "jenkins":
   ensure => 'present',
   managehome=>true,
}

file { "gradle-jenkins":
  path	   => "/var/lib/jenkins/hudson.plugins.gradle.Gradle.xml",
  source   => '/vagrant/hudson.plugins.gradle.Gradle.xml',
  ensure   => "present",
  owner	   => 'jenkins',
  group    => 'jenkins',
  require => [Class['gradle'],Jenkins::Plugin['gradle']],
  notify   => Service['jenkins'],
}

file { "git-jenkins":
  path	   => "/var/lib/jenkins/hudson.plugins.git.GitSCM.xml",
  source   => '/vagrant/hudson.plugins.git.GitSCM.xml',
  ensure   => "present",
  owner	   => 'jenkins',
  group    => 'jenkins',
  require => [Package['git-core'],Jenkins::Plugin['git']],
  notify   => Service['jenkins'],
}

file { "jenkins-jobs":
  path	   => "/var/lib/jenkins/jobs",
  ensure   => "directory",
  owner	   => 'jenkins',
  group    => 'jenkins',
  require => [File['git-jenkins'],File['gradle-jenkins']],
  notify   => Service['jenkins'],
}

file { "jenkins-project":
  path	   => "/var/lib/jenkins/jobs/prueba",
  ensure   => "directory",
  owner	   => 'jenkins',
  group    => 'jenkins',
  require => File['jenkins-jobs'],
  notify   => Service['jenkins'],
}

file { "jenkins-project-config":
  path	   => "/var/lib/jenkins/jobs/prueba/config.xml",
  source   => '/vagrant/build/config.xml',
  ensure   => "present",
  owner	   => 'jenkins',
  group    => 'jenkins',
  require => File['jenkins-project'],
  notify   => Service['jenkins'],
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

class{'java':
  require=> Exec['apt-get update']
}

exec{'apt-get update':
  command=>"/usr/bin/apt-get update"
}

include java
