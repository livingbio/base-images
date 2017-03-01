
node('small') {
   checkout scm
   stage('Preparation') { // for display purposes
      sh 'cd django'
      sh 'docker build . -t django'
   }
//   sshagent (credentials: ['d4890042-20b5-42a9-a61e-4aea75e4badf']) {
//       stage('Build'){
//          sh 'pip install -r requirements.txt'
//       }
//    }
}

