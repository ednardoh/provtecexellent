object IWServerController: TIWServerController
  OldCreateOrder = False
  AuthBeforeNewSession = False
  AppName = 'SisPedido'
  CacheDir = 'C:\Users\ednar\AppData\Local\Temp'
  ComInitialization = ciNone
  Compression.Enabled = True
  Compression.Level = 6
  Description = 'Prova Tecnica'
  DebugHTML = False
  DisplayName = 'Sistema de Pedido - Prova Tecnica'
  Log = loFile
  EnableImageToolbar = False
  ExceptionDisplayMode = smAlert
  HistoryEnabled = False
  JavascriptDebug = False
  HTMLHeaders.Strings = (
    '<meta charset="utf-8">'
    
      '<meta name="viewport" content="width=device-width, initial-scale' +
      '=1">'
    ''
    
      '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/boo' +
      'tstrap/3.3.7/css/bootstrap.min.css">'
    
      '<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/' +
      'jquery.min.js"></script>'
    
      '<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/' +
      'bootstrap.min.js"></script>')
  MasterTemplate = 'IWMasterPage.html'
  PageTransitions = False
  Port = 8888
  RedirectMsgDelay = 0
  ServerResizeTimeout = 0
  ShowLoadingAnimation = True
  SessionTimeout = 10
  SSLOptions.NonSSLRequest = nsAccept
  SSLOptions.Port = 0
  SSLOptions.SSLVersion = sslv3
  Version = '14.0.0'
  AllowMultipleSessionsPerUser = False
  IECompatibilityMode = 'IE=8'
  OnNewSession = IWServerControllerBaseNewSession
  Height = 380
  Width = 319
end
