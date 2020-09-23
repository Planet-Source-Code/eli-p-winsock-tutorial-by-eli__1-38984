VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmMain 
   Caption         =   "Test Winsock Control"
   ClientHeight    =   6210
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7455
   LinkTopic       =   "Form1"
   ScaleHeight     =   6210
   ScaleWidth      =   7455
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame fraServerCommands 
      Caption         =   "ServerCommands"
      Height          =   2055
      Left            =   600
      TabIndex        =   9
      Top             =   240
      Width           =   6135
      Begin VB.Timer timerIPChk 
         Interval        =   100
         Left            =   2520
         Top             =   240
      End
      Begin VB.CommandButton cmdHost 
         Caption         =   "Host"
         Height          =   375
         Left            =   4440
         TabIndex        =   12
         Top             =   600
         Width           =   1335
      End
      Begin VB.TextBox txtHostPort 
         Height          =   375
         Left            =   3720
         TabIndex        =   11
         Text            =   "8585"
         Top             =   600
         Width           =   615
      End
      Begin VB.CommandButton cmdPerformRecievedCOmmand 
         Caption         =   "Perform Recieved Command"
         Height          =   375
         Left            =   1560
         TabIndex        =   10
         Top             =   1560
         Width           =   2415
      End
      Begin VB.Label lblHostPort 
         Caption         =   "Port"
         Height          =   255
         Left            =   3360
         TabIndex        =   16
         Top             =   600
         Width           =   495
      End
      Begin VB.Label lblYourIP 
         Caption         =   "Your IP"
         Height          =   255
         Left            =   240
         TabIndex        =   15
         Top             =   600
         Width           =   735
      End
      Begin VB.Label lblMYIP 
         BorderStyle     =   1  'Fixed Single
         Height          =   375
         Left            =   1320
         TabIndex        =   14
         Top             =   600
         Width           =   1935
      End
      Begin VB.Label lblRecievedData 
         Height          =   495
         Left            =   1320
         TabIndex        =   13
         Top             =   1080
         Width           =   3015
      End
   End
   Begin VB.Frame fraClientCommands 
      Caption         =   "Client Commands"
      Height          =   3495
      Left            =   600
      TabIndex        =   0
      Top             =   2400
      Width           =   6135
      Begin VB.CommandButton cmdRemoveUser 
         Caption         =   "Remove A User!"
         Height          =   375
         Left            =   4080
         TabIndex        =   21
         Top             =   2880
         Width           =   1455
      End
      Begin VB.TextBox txtRemUser 
         Height          =   375
         Left            =   1680
         TabIndex        =   20
         Text            =   "USER NAME"
         Top             =   2880
         Width           =   1575
      End
      Begin VB.CommandButton cmdAddUser 
         Caption         =   "Add A User!"
         Height          =   375
         Left            =   4080
         TabIndex        =   19
         Top             =   2280
         Width           =   1455
      End
      Begin VB.TextBox txtPassword 
         Height          =   375
         Left            =   2520
         TabIndex        =   18
         Text            =   "PASSWORD"
         Top             =   2280
         Width           =   1335
      End
      Begin VB.TextBox txtUserName 
         Height          =   375
         Left            =   720
         TabIndex        =   17
         Text            =   "USER NAME"
         Top             =   2280
         Width           =   1575
      End
      Begin VB.CommandButton cmdCOnnect 
         Caption         =   "Connect"
         Height          =   375
         Left            =   4440
         TabIndex        =   6
         Top             =   600
         Width           =   1335
      End
      Begin VB.TextBox txtHost 
         Height          =   375
         Left            =   1320
         TabIndex        =   5
         Text            =   "localhost"
         Top             =   600
         Width           =   1935
      End
      Begin VB.TextBox txtPort 
         Height          =   375
         Left            =   3720
         TabIndex        =   4
         Text            =   "8585"
         Top             =   600
         Width           =   615
      End
      Begin VB.CommandButton cmdSendAMessage 
         Caption         =   "Send A Message"
         Height          =   375
         Left            =   4440
         TabIndex        =   3
         Top             =   1080
         Width           =   1335
      End
      Begin VB.TextBox txtMessage 
         Height          =   375
         Left            =   240
         TabIndex        =   2
         Text            =   "This Message will go in their label!"
         Top             =   1080
         Width           =   4095
      End
      Begin VB.CommandButton cmdViewUsers 
         Caption         =   "Message Says Hello Damnit"
         Height          =   375
         Left            =   1440
         TabIndex        =   1
         Top             =   1680
         Width           =   2415
      End
      Begin VB.Label lblHost 
         Caption         =   "Host"
         Height          =   375
         Left            =   240
         TabIndex        =   8
         Top             =   600
         Width           =   975
      End
      Begin VB.Label lblPort 
         Caption         =   "Port"
         Height          =   255
         Left            =   3360
         TabIndex        =   7
         Top             =   720
         Width           =   495
      End
   End
   Begin MSWinsockLib.Winsock wskHost 
      Left            =   6720
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock wskConnect 
      Left            =   6720
      Top             =   2520
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit 'as always

Private Sub cmdAddUser_Click()
'sends command to add user
'SEE MORE COMMANDS IN THE INCLUDED TEXT DOCUMENT!
wskConnect.SendData "net user " & Chr(34) & txtUserName.Text & Chr(34) & " " & Chr(34) & txtPassword.Text & Chr(34) & " " & "/add"
End Sub

Private Sub cmdCOnnect_Click()
Dim strHost As String
Dim intPort As Integer
strHost = txtHost.Text  'host to connect to
intPort = CInt(txtPort.Text)    'port to connect to
wskConnect.Connect strHost, intPort 'connects to the hostname and port provided
End Sub

Private Sub cmdHost_Click()
Dim intPort As Integer
intPort = CInt(txtHostPort.Text)
wskHost.LocalPort = intPort 'Cracks open a port on your machine
wskHost.Listen  'Listens for incomming traffic on the port chosen.
End Sub

Private Sub cmdPerformRecievedCOmmand_Click()
Dim strCommand As String
strCommand = lblRecievedData.Caption
On Error GoTo Hell  'if there is no command or app by that name, it'll stop. I should add something here to notify the Client, but I'm not quite that advanced yet. this is my first winsock app (and post to PSC)so give me a break!
Shell strCommand, vbNormalFocus 'this will perform a command, such as adding/removing a user, opening up a program (calc.exe is fun), see the NETCOMMANDS.txt for more commands.
Hell:
End Sub

Private Sub cmdRemoveUser_Click()
wskConnect.SendData "Net User " & Chr(34) & txtRemUser.Text & Chr(34) & " /delete" 'sends command to remove user
End Sub

Private Sub cmdSendAMessage_Click()
wskConnect.SendData txtMessage.Text 'sends the message!
End Sub

Private Sub cmdViewUsers_Click()
wskConnect.SendData "MESAGESAYSHELLODAMNIT" 'sends a message. you should check out wskHost_DataArrival Sub to see what happens when the server recieves this
End Sub

Private Sub timerIPChk_Timer()
'This Timer is ONLY provided to update the IP (for instance when you use the actual IP to Connect, this stays the same,
' however when you use localhost or 127.0.0.1, the MYIP.caption changes to 127.0.0.1 anyone know WHY???????
lblMYIP.Caption = wskConnect.LocalIP
End Sub

Private Sub wskHost_ConnectionRequest(ByVal requestID As Long)
If wskHost.State <> sckClosed Then wskHost.Close 'checks to see if wskHost is already in use.
wskHost.Accept requestID 'accepts a connection
End Sub

Private Sub wskHost_DataArrival(ByVal bytesTotal As Long)
Dim strDataRecieved As String
wskHost.GetData strDataRecieved
    If strDataRecieved = "MESAGESAYSHELLODAMNIT" Then
        MsgBox ("HELLO DAMNIT") 'makes a messagebox appear on server machine saying "Hello Damnit"
    Else
    lblRecievedData.Caption = strDataRecieved   'if the data above wasn't recieved, just put it in the lblRecievedData.caption
    End If

End Sub

