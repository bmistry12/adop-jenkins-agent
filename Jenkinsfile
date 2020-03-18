def serviceUserCredentials = "AZURE_REGISTRY"

@Library('docker-ci@master') _;
def templateVars = [:]
    templateVars.put('agent','test')
    templateVars.put('imageName',"modernisation-build-slave:latest")
    templateVars.put('registry','appmodtools.azurecr.io')
    templateVars.put('registryOrg', "buildtools")
    templateVars.put('oneShotImage', 'modernisation-build-slave:latest')
    templateVars.put('credentialsId', serviceUserCredentials)

dockerci_pipeline(templateVars)