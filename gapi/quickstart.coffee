#!/usr/bin/env coffee

fs = require 'fs'
readline = require 'readline'
google = require 'googleapis'
googleAuth = require 'google-auth-library'

# If modifying these scopes, delete your previously saved credentials
# at ~/.credentials/drive-nodejs-quickstart.json
SCOPES = ['https://www.googleapis.com/auth/drive.metadata.readonly']
TOKEN_DIR = '/usr/src/app/.credentials/'
TOKEN_PATH = TOKEN_DIR + 'drive-nodejs-quickstart.json'

processClientSecrets = (err, content) ->
  if (err)
    console.log "Error loading client secret file: #{err}"

  # Authorize a client with the loaded credentials, then call the
  # Drive API.
  authorize JSON.parse(content), listFiles

# Load client secrets from a local file.
fs.readFile 'client_secret.json', processClientSecrets

###*
# Create an OAuth2 client with the given credentials, and then execute the
# given callback function.
#
# @param {Object} credentials The authorization client credentials.
# @param {function} callback The callback to call with the authorized client.
###

authorize = (credentials, callback) ->
  clientSecret = credentials.installed.client_secret
  clientId = credentials.installed.client_id
  redirectUrl = credentials.installed.redirect_uris[0]
  auth = new googleAuth
  oauth2Client = new (auth.OAuth2)(clientId, clientSecret, redirectUrl)
  # Check if we have previously stored a token.
  fs.readFile TOKEN_PATH, (err, token) ->
    if err
      getNewToken oauth2Client, callback
    else
      oauth2Client.credentials = JSON.parse(token)
      callback oauth2Client
    return
  return

###*
# Get and store new token after prompting for user authorization, and then
# execute the given callback with the authorized OAuth2 client.
#
# @param {google.auth.OAuth2} oauth2Client The OAuth2 client to get token for.
# @param {getEventsCallback} callback The callback to call with the authorized
#     client.
###

getNewToken = (oauth2Client, callback) ->
  authUrl = oauth2Client.generateAuthUrl(
    access_type: 'offline'
    scope: SCOPES)
  console.log 'Authorize this app by visiting this url: ', authUrl
  rl = readline.createInterface(
    input: process.stdin
    output: process.stdout)
  rl.question 'Enter the code from that page here: ', (code) ->
    rl.close()
    oauth2Client.getToken code, (err, token) ->
      if err
        console.log 'Error while trying to retrieve access token', err
        return
      oauth2Client.credentials = token
      storeToken token
      callback oauth2Client
      return
    return
  return

###*
# Store token to disk be used in later program executions.
#
# @param {Object} token The token to store to disk.
###

storeToken = (token) ->
  try
    fs.mkdirSync TOKEN_DIR
  catch err
    if err.code != 'EEXIST'
      throw err
  fs.writeFile TOKEN_PATH, JSON.stringify(token)
  console.log 'Token stored to ' + TOKEN_PATH
  return

###*
# Lists the names and IDs of up to 10 files.
#
# @param {google.auth.OAuth2} auth An authorized OAuth2 client.
###

listFiles = (auth) ->
  service = google.drive('v3')
  service.files.list {
    auth: auth
    pageSize: 10
    fields: 'nextPageToken, files(id, name)'
  }, (err, response) ->
    if err
      console.log 'The API returned an error: ' + err
      return
    files = response.files
    if files.length == 0
      console.log 'No files found.'
    else
      console.log 'Files:'
      i = 0
      while i < files.length
        file = files[i]
        console.log '%s (%s)', file.name, file.id
        i++
    return
  return
