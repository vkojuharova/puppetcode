class  users {
  user { 'deck':
 ensure       => present,
  gid         => 'users',
   home       => '/home/deck', 
   shell      => '/bin/bash',
   managehome => true,
}
}
  
