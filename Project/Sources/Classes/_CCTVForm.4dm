Class extends _Form

Class constructor($channels : Collection)
	
	Super:C1705()
	
	$window:=Open form window:C675("CCTV")
	DIALOG:C40("CCTV"; This:C1470; *)
	
Function onLoad()
	
	If (Not:C34(cs:C1710._WSS.new().isRunning("/cctv")))
		
		Form:C1466.CCTV:=cs:C1710.CCTV.new(cs:C1710.CCTVUI_WSS_Controller)
		
		Form:C1466.pages:={}
		Form:C1466.pages.values:=["Video"; "Developer"]
		Form:C1466.pages.index:=0
		
		Form:C1466.rooms:=ds:C1482.Room.all().orderBy("name asc")
		
		Form:C1466.frames:={}
		
		Form:C1466.info:={error: Null:C1517; teminate: Null:C1517}
		
		Form:C1466.update()
		
	Else 
		Form:C1466.deactivate()
	End if 
	
Function onUnload()
	
	Form:C1466.terminate()
	
Function onPageChange()
	
	GOTO OBJECT:C206(*; "rooms")
	
Function terminate()
	
	If (Form:C1466.CCTV.socket#Null:C1517)
		Form:C1466.CCTV.terminate()
	End if 
	
	return Form:C1466
	
Function restart()
	
	If (Form:C1466.CCTV.socket=Null:C1517 || Form:C1466.CCTV.socket.terminated)
		Form:C1466.CCTV:=cs:C1710.CCTV.new(cs:C1710.CCTVUI_WSS_Controller)
		Form:C1466.info.error:=Null:C1517
		Form:C1466.info.terminate:=Null:C1517
	End if 
	
	return Form:C1466
	
Function deactivate()
	
	OBJECT SET ENABLED:C1123(*; "terminate"; False:C215)
	OBJECT SET ENABLED:C1123(*; "restart"; False:C215)
	OBJECT SET VISIBLE:C603(*; "CCTV.stream"; False:C215)
	
	OBJECT SET VISIBLE:C603(*; "frame"; False:C215)
	
	OBJECT SET VISIBLE:C603(*; "rooms"; False:C215)
	OBJECT SET VISIBLE:C603(*; "pages"; False:C215)
	OBJECT SET VISIBLE:C603(*; "terminate.other"; True:C214)
	OBJECT SET VISIBLE:C603(*; "warning"; True:C214)
	
Function requestTerminate($path : Text)
	
	cs:C1710._WSS.new().requestTerminate($path)
	
Function update()
	
	OBJECT SET ENABLED:C1123(*; "terminate"; Form:C1466.CCTV.socket#Null:C1517 && (Form:C1466.CCTV.socket.terminated=False:C215))
	OBJECT SET ENABLED:C1123(*; "restart"; Form:C1466.CCTV.socket=Null:C1517 || Form:C1466.CCTV.socket.terminated)
	
Function displayRoom()
	
	var $room : cs:C1710.RoomEntity
	
	$room:=Form:C1466.currentRoom
	
	If ($room#Null:C1517)
		OPEN URL:C673("http://127.0.0.1/cctv.shtml?room="+$room.name)
	Else 
		OPEN URL:C673("http://127.0.0.1/cctv.shtml?room="+ds:C1482.Room.next())
	End if 
	
Function onOpen($socket : 4D:C1709.WebSocketConnection; $open : cs:C1710._Open)
	
	If (Form:C1466.currentRoom#Null:C1517)
		Form:C1466.currentRoom.reload()
	Else 
		Form:C1466.rooms:=ds:C1482.Room.all().orderBy("name asc")
	End if 
	
Function onMessage($socket : 4D:C1709.WebSocketConnection; $message : cs:C1710._Message)
	
	Form:C1466.frames[Form:C1466.CCTV.connection.room]:=Form:C1466.CCTV.frame
	
Function onTerminate($socket : 4D:C1709.WebSocketConnection; $terminate : cs:C1710._Terminate)