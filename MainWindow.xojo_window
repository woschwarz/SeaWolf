#tag Window
Begin Window MainWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   "SeaWolf [C64 Retro Game with Xojo]"
   Visible         =   True
   Width           =   640
   Begin Canvas GameCanvas
      AcceptFocus     =   True
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   400
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   640
   End
   Begin Timer KeyboardTimer
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockedInPosition=   False
      Mode            =   2
      Period          =   150
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   0
      Width           =   32
   End
   Begin Timer UpdateTimer
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockedInPosition=   False
      Mode            =   0
      Period          =   50
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   20
      Width           =   32
   End
   Begin Timer AddShipTimer
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   40
      LockedInPosition=   False
      Mode            =   0
      Period          =   2000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   40
      Width           =   32
   End
   Begin Timer GameTimer
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   60
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   60
      Width           =   32
   End
   Begin Timer Player1Timer
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   80
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   80
      Width           =   32
   End
   Begin Timer Player2Timer
      Height          =   32
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   100
      LockedInPosition=   False
      Mode            =   0
      Period          =   1000
      Scope           =   0
      TabPanelIndex   =   0
      Top             =   100
      Width           =   32
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Close()
		  quit
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  'StartGame
		  
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddShip(Optional shipNo As Integer)
		  Dim xShip As New Ship
		  Dim r As New Random
		  
		  If shipNo < 1 Then shipNo = r.InRange(1,3)
		  
		  Select Case shipNo
		  Case 1
		    xShip.imagename = ship50
		    xShip.xpos = 0
		    xShip.ypos = r.InRange(60*scaleHeight,200*scaleHeight)
		    xShip.points = 50
		    xShip.speed = 3
		    xShip.width = 70
		    
		    mShip.Append xShip
		    
		  Case 2
		    
		    xShip.imagename = ship100
		    xShip.xpos = 0
		    xShip.ypos = r.InRange(60*scaleHeight,200*scaleHeight)
		    xShip.points = 100
		    xShip.speed = 6
		    xShip.width = 50
		    
		    mShip.Append xShip
		    
		  Case 3
		    
		    xShip.imagename = ship200
		    xShip.xpos = 0
		    xShip.ypos = r.InRange(60*scaleHeight,200*scaleHeight)
		    xShip.points = 200
		    xShip.speed = 10
		    xShip.width = 30
		    
		    mShip.Append xShip
		    
		    beeper.Play
		    
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckCollision()
		  Dim i, ii As Integer
		  
		  For ii = 0 to UBound(mTorpedo)
		    
		    For i = 0 to UBound(mShip)
		      
		      If mTorpedo(ii).ypos >= mShip(i).ypos And mTorpedo(ii).ypos <= mShip(i).ypos+mShip(i).imagename.Height And mTorpedo(ii).xpos >= mShip(i).xpos And mTorpedo(ii).xpos <= mShip(i).xpos+mShip(i).imagename.width*scaleWidth Then
		        grenade.Play
		        
		        mShip(i).imagename = explosion1
		        mShip(i).destroyed = True
		        
		        If mTorpedo(ii).player = 1 Then
		          scorePlayer1 = scorePlayer1 + mShip(i).points
		        Else
		          scorePlayer2 = scorePlayer2 + mShip(i).points
		        End If
		        
		        mTorpedo.Remove ii
		        
		        Exit
		        
		      End If
		      
		    Next
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckKeys()
		  #pragma BackgroundTasks false
		  
		  // Press Space Bar to start the Game
		  If Keyboard.AsyncKeyDown(&h31) And GameTimer.Mode = Timer.ModeOff Then StartGame
		  
		  // Resize Window bigger
		  If Keyboard.AsyncKeyDown(&h2B) Then
		    scaleWidth = scaleWidth + 0.3
		    scaleHeight = scaleHeight + 0.3
		    ScaleWIndow
		  End If
		  
		  // Resize Window smaller
		  If Keyboard.AsyncKeyDown(&h2F) Then
		    If scaleWidth > 1 Then scaleWidth = scaleWidth - 0.3
		    If scaleHeight > 1 Then scaleHeight = scaleHeight - 0.3
		    ScaleWindow
		  End If
		  
		  // Player1 Keys
		  If Keyboard.AsyncKeyDown(&h02) Then
		    If uboot1xpos < GameCanvas.Width-30 Then
		      uboot1xpos = uboot1xpos + 12
		    End If
		  End If
		  
		  If Keyboard.AsyncKeyDown(&h00) Then
		    If uboot1xpos > 0 Then
		      uboot1xpos = uboot1xpos - 12
		    End If
		  End If
		  
		  If keyboard.AsyncKeyDown(&h01) then
		    
		    If uboot1torpedos > 0 Then
		      uboot1torpedos = uboot1torpedos -1
		      
		      rocket.play
		      
		      Dim xTorpedo As New Torp
		      
		      xTorpedo.player = 1
		      xTorpedo.xpos = uboot1xpos + uboot1.Width/2
		      xTorpedo.ypos = uboot1ypos
		      mTorpedo.Append xTorpedo
		    End If
		  End If
		  
		  
		  // Player2 Keys
		  If Keyboard.AsyncKeyDown(&h7C) Then
		    If uboot2xpos < GameCanvas.Width-30 Then
		      uboot2xpos = uboot2xpos + 12
		    End If
		  End If
		  
		  If Keyboard.AsyncKeyDown(&h7B) Then
		    If uboot2xpos > 0 Then
		      uboot2xpos = uboot2xpos - 12
		    End If
		  End If
		  
		  If Keyboard.AsyncKeyDown(&h7D) then
		    If uboot2torpedos > 0 Then
		      uboot2torpedos = uboot2torpedos -1
		      
		      rocket.play
		      
		      Dim xTorpedo As New Torp
		      
		      xTorpedo.player = 2
		      xTorpedo.xpos = uboot2xpos + uboot2.Width/2
		      xTorpedo.ypos = uboot2ypos
		      mTorpedo.Append xTorpedo
		    End If
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GameOver()
		  // Stop Timers
		  UpdateTimer.Mode = Timer.ModeOff
		  GameTimer.Mode = Timer.ModeOff
		  AddShipTimer.Mode = Timer.ModeOff
		  
		  // Redraw Start Screen
		  GameCanvas.Refresh(true)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScaleWindow()
		  MainWindow.Width = 640*scaleWidth
		  MainWindow.Height = 400*scaleHeight
		  
		  uboot1ypos = MainWindow.Height-60*scaleHeight
		  uboot2ypos = MainWindow.Height-50*scaleHeight
		  
		  MainWindow.Refresh
		  
		  'GameCanvas.Refresh(true)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartGame()
		  // Reset Score
		  scorePlayer1 = 0
		  scorePlayer2 = 0
		  
		  // Set Uboot Position
		  uboot1xpos = 0
		  uboot1ypos = GameCanvas.Height-60
		  uboot2xpos = GameCanvas.Width-60
		  uboot2ypos = GameCanvas.Height-50
		  
		  // Set Time Left 
		  timeCounter = 120 
		  
		  // Init Timers
		  KeyboardTimer.Mode = Timer.ModeMultiple
		  UpdateTimer.Mode = Timer.ModeMultiple
		  AddShipTimer.Mode = Timer.ModeMultiple
		  GameTimer.Mode = Timer.ModeMultiple
		  
		  // Add the first Ship
		  AddShip(1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Update()
		  Dim i, ii As Integer
		  
		  // Move Ships
		  For i = 0 To UBound(mShip)
		    If mShip(i).destroyed = False Then
		      mShip(i).xpos = mShip(i).xpos + mShip(i).speed
		    ElseIf mShip(i).destroyed = True And mShip(i).imagename = explosion1 Then 
		      mShip(i).imagename = explosion2
		    ElseIf mShip(i).destroyed = True And mShip(i).imagename = explosion2 Then 
		      mShip(i).imagename = explosion3
		    ElseIf mShip(i).destroyed = True And mShip(i).imagename = explosion3 Then 
		      mShip.Remove i
		    End If
		  Next
		  
		  // Move Torpedos
		  For ii = 0 to uBound(mTorpedo)
		    If mTorpedo(ii).ypos < 70*scaleHeight Then
		      mTorpedo.Remove ii
		    Else
		      mTorpedo(ii).ypos = mTorpedo(ii).ypos - 5
		    End If
		    
		  Next
		  
		  // Check Collision
		  CheckCollision
		  
		  // Update HighScore
		  If scorePlayer1 > highscore Then highScore = scorePlayer1
		  If scorePlayer2 > highscore Then highScore = scorePlayer2
		  
		  // Check Torpodo Reload Player1
		  If uboot1Torpedos = 0 And Player1Timer.Mode = Timer.ModeOff Then
		    Player1Timer.Mode = Timer.ModeMultiple
		  End If
		  
		  // Check Torpodo Reload Player2
		  If uboot2Torpedos = 0 And Player2Timer.Mode = Timer.ModeOff Then
		    Player2Timer.Mode = Timer.ModeMultiple
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private highScore As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mShip(-1) As Ship
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTorpedo(-1) As Torp
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scaleHeight As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scaleWidth As Double = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scorePlayer1 As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scorePlayer2 As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private timeCounter As Integer = 60
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uboot1Timer As Integer = 3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uboot1Torpedos As Integer = 4
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uboot1xpos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uboot1ypos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uboot2Timer As Integer = 3
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uboot2torpedos As Integer = 4
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uboot2xpos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private uboot2ypos As Integer
	#tag EndProperty


	#tag Constant, Name = kPlayer1Keys, Type = String, Dynamic = False, Default = \"Player 1 Keys: [a] LEFT\x2C [d] RIGHT\x2C [s] FIRE", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPlayer2Keys, Type = String, Dynamic = False, Default = \"Player 2 Keys: [left] LEFT\x2C [right] RIGHT\x2C [down] FIRE", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kWelcome, Type = String, Dynamic = False, Default = \"YOUR MISSION IS TO DESTROY AS MANY ENEMY SHIPS AS POSSIBLE BEFORE TIME RUNS OUT. FIRE TORPEDOS BY PRESSING KEY. IT TAKES 3 SECONDS TO RELOAD TORPEDOES.", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events GameCanvas
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  Dim i, ii, iii As Integer
		  Dim tm, ts As Integer
		  
		  #If TargetWin32 Then
		    Me.DoubleBuffer = True
		  #Else
		    Me.DoubleBuffer = False
		  #Endif
		  
		  // Background
		  g.DrawPicture(background, 0, 0, 640*scaleWidth,400*scaleHeight,0,0,3,226)
		  
		  // Score
		  g.TextUnit=FontUnits.Point
		  g.TextSize=18
		  g.ForeColor = &cFFFFFF00
		  g.DrawString("Player 1: " + Str(scorePlayer1), 50,30)
		  g.DrawString("Player 2: " + Str(scorePlayer2), 470*scaleWidth,30)
		  g.DrawString("Highscore: " + Str(highScore), 250*scaleWidth,30)
		  
		  // Start Screen
		  If GameTimer.Mode = Timer.ModeOff Then
		    g.TextUnit=FontUnits.Pixel
		    g.TextSize=16
		    g.DrawString(kWelcome, 50,90*scaleHeight,520*scaleWidth)
		    g.DrawString(kPlayer1keys, 50,160*scaleHeight)
		    g.DrawString(kPlayer2keys, 50,180*scaleHeight)
		    g.DrawString("Press SPACE BAR to Start", 250*scaleWidth,380*scaleHeight)
		    
		    g.DrawString("FREIGHTER:     50 POINTS", 150*scaleWidth,230*scaleHeight)  
		    g.DrawString("CRUISER    :   100 POINTS", 150*scaleWidth,270*scaleHeight)
		    g.DrawString("P.I. BOAT   :   200 POINTS", 150*scaleWidth,310*scaleHeight)
		    
		    g.DrawPicture(Ship50,50,210*scaleHeight, Ship50.width*scaleWidth, Ship50.height*scaleHeight,0,0,Ship50.width, Ship50.height)
		    g.DrawPicture(Ship100,50,260*scaleHeight, Ship100.width*scaleWidth, Ship100.height*scaleHeight,0,0,Ship100.width, Ship100.height)
		    g.DrawPicture(Ship200,50,300*scaleHeight, Ship200.width*scaleWidth, Ship200.height*scaleHeight,0,0,Ship200.width, Ship200.height)
		    
		    
		  Else // Game
		    
		    // Time
		    g.ForeColor = &cFFFFFF00
		    g.TextSize=16
		    tm = (TimeCounter/60) mod 60
		    ts = TimeCounter - (tm*60)
		    g.DrawString("Time Left: " + Str(tm) + ":" + Format(ts, "00"), 260*scaleWidth, GameCanvas.Height-15)
		    
		    // Available Torpedos
		    'g.DrawString("Player 1 Torpedos: " + Str(uboot1Torpedos), 5, GameCanvas.Height-30)
		    For iii = 1 To uboot1Torpedos
		      g.DrawPicture(torpedo1, 10 + (40*iii), GameCanvas.Height-20)
		    Next
		    If Player1Timer.Mode <> Timer.ModeOff Then g.DrawString("Wait: " + Str(uboot1Timer) + " Seconds", 10, GameCanvas.Height-15)
		    
		    'g.DrawString("Player 2 Torpedos:" , 450, GameCanvas.Height-30)
		    For iii = 1 To uboot2Torpedos
		      g.DrawPicture(torpedo2, 400*scaleWidth + (40*iii), GameCanvas.Height-20)
		    Next
		    If Player2Timer.Mode <> Timer.ModeOff Then g.DrawString("Wait: " + Str(uboot2Timer) + " Seconds", 430*scaleWidth, GameCanvas.Height-15)
		    
		    // UBoot
		    g.DrawPicture(uboot1, uboot1xpos, uboot1ypos, uboot1.width*scaleWidth, uboot1.height*scaleHeight,0,0,uboot1.width, uboot1.height)
		    g.DrawPicture(uboot2, uboot2xpos, uboot2ypos, uboot2.width*scaleWidth, uboot2.height*scaleHeight,0,0,uboot2.width, uboot2.height)
		    
		    // Ships & Booats
		    If UBound(mShip) >= 0 Then
		      For i = 0 To UBound(mShip)
		        g.DrawPicture(mShip(i).imagename, mShip(i).xpos, mShip(i).ypos, mShip(i).imagename.width*scaleWidth, mShip(i).imagename.height*scaleHeight,0,0,mShip(i).imagename.width, mShip(i).imagename.height)
		        'g.DrawString(str(i), mShip(i).xpos, mShip(i).ypos)  // For Debug
		        
		        // Delete Ship on Screen Edge
		        If mShip(i).xpos >= GameCanvas.Width Then mShip.Remove i
		        
		      Next
		    End If
		    
		    // Torpedos
		    For ii = 0 to UBound(mTorpedo)
		      If mTorpedo(ii).player = 1 Then 
		        g.DrawPicture(bomb1,mTorpedo(ii).xpos,mTorpedo(ii).ypos, bomb1.width*scaleWidth, bomb1.height*scaleHeight,0,0,bomb1.width, bomb1.height)
		      Else
		        g.DrawPicture(bomb2,mTorpedo(ii).xpos,mTorpedo(ii).ypos, bomb2.width*scaleWidth, bomb2.height*scaleHeight,0,0,bomb2.width, bomb2.height)
		      End If
		      'g.DrawString(str(ii), mTorpedo(ii).xpos,mTorpedo(ii).ypos) // For Debug
		    Next
		    
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  #pragma unused Key
		  return true
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events KeyboardTimer
	#tag Event
		Sub Action()
		  CheckKeys
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UpdateTimer
	#tag Event
		Sub Action()
		  Update
		  
		  GameCanvas.Refresh(true)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AddShipTimer
	#tag Event
		Sub Action()
		  AddShip
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events GameTimer
	#tag Event
		Sub Action()
		  TimeCounter = TimeCounter -1
		  
		  If TimeCounter = 0 Then GameOver
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Player1Timer
	#tag Event
		Sub Action()
		  uboot1Timer = uboot1Timer -1
		  
		  If uboot1Timer = 0 Then 
		    Player1Timer.Mode = Timer.ModeOff
		    uboot1torpedos = 4
		    uboot1Timer = 3
		  End If
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Player2Timer
	#tag Event
		Sub Action()
		  uboot2Timer = uboot2Timer -1
		  
		  If uboot2Timer = 0 Then
		    Player2Timer.Mode = Timer.ModeOff
		    uboot2torpedos = 4
		    uboot2Timer = 3
		  End If
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Appearance"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"10 - Drawer Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
