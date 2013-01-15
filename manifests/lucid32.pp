include jenkins

package{"git-core":
    ensure=>"installed"
}

jenkins::plugin {
  "git" : ;
}

jenkins::plugin{
  "gradle" : ;
}

