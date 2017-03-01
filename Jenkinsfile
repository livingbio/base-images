
node('small') {
   checkout scm
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      //sh 'virtualenv --no-site-package env'
      //sh 'source env/bin/activate'

      sh 'docker pull gliacloud/base_images:django'
      sh 'sudo apt-get update'
      sh 'sudo apt-get install python-pip -y'
      sh 'pip install -U pip'
      sshagent (credentials: ['github.ssh', 'github']) {
      // sh 'docker build .'
      sh 'pip download -r requirements.txt -d cache --exists-action i'
withDockerContainer(args: '-u root:root -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK -v $SSH_AUTH_SOCK:$SSH_AUTH_SOCK',image: 'gliacloud/base_images:django') {
          sh 'pip install -U pip'
          sh 'pip install -r requirements.txt -f cache --exists-action i'
          sh 'pip list'
          
      // sh 'pip install -U pip'
     // sh 'pip install -r requirements.txt'
      // sh 'docker build .'
          // sh 'pip install -r requirements.txt'
      
      }
      }
   }
//   sshagent (credentials: ['d4890042-20b5-42a9-a61e-4aea75e4badf']) {
//       stage('Build'){
//          sh 'pip install -r requirements.txt'
//       }
//    }
}

