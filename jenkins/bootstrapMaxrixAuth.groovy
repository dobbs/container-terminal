import jenkins.model.Jenkins
import hudson.security.GlobalMatrixAuthorizationStrategy
import hudson.security.HudsonPrivateSecurityRealm
import hudson.security.Permission

basePermissions = [
  "hudson.model.Hudson.Administer",
  "hudson.model.Hudson.ConfigureUpdateCenter",
  "hudson.model.Hudson.Read",
  "hudson.model.Hudson.RunScripts",
  "hudson.model.Hudson.UploadPlugins",
  "hudson.model.Computer.Build",
  "hudson.model.Computer.Configure",
  "hudson.model.Computer.Connect",
  "hudson.model.Computer.Create",
  "hudson.model.Computer.Delete",
  "hudson.model.Computer.Disconnect",
  "hudson.model.Run.Delete",
  "hudson.model.Run.Update",
  "hudson.model.View.Configure",
  "hudson.model.View.Create",
  "hudson.model.View.Read",
  "hudson.model.View.Delete",
  "hudson.model.Item.Create",
  "hudson.model.Item.Delete",
  "hudson.model.Item.Configure",
  "hudson.model.Item.Read",
  "hudson.model.Item.Discover",
  "hudson.model.Item.Build",
  "hudson.model.Item.Workspace",
  "hudson.model.Item.Cancel"
]

credentialsPermissions = [
  "com.cloudbees.plugins.credentials.CredentialsProvider.Create",
  "com.cloudbees.plugins.credentials.CredentialsProvider.Delete",
  "com.cloudbees.plugins.credentials.CredentialsProvider.ManageDomains",
  "com.cloudbees.plugins.credentials.CredentialsProvider.Update",
  "com.cloudbees.plugins.credentials.CredentialsProvider.View"
]

def j = Jenkins.instance
j.securityRealm = new HudsonPrivateSecurityRealm(true, false, null)
j.securityRealm.createAccount('admin','password')
strategy = new GlobalMatrixAuthorizationStrategy()
basePermissions.each { strategy.add(Permission.fromId(it), "admin") }
credentialsPermissions.each { strategy.add(Permission.fromId(it), "admin") }
j.setAuthorizationStrategy(strategy)
