name             'standard'
maintainer       'Shipwire Devops'
maintainer_email ''
license          'Proprietary - All Rights Reserved'
description      ''
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

supports 'centos'

depends 'yum-epel'
