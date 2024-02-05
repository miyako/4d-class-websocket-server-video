Class extends _WSS_Connection

property remoteAddress : Text
property url : Text

Class constructor($connection : cs:C1710._Connection)
	
	Super:C1705()
	
	This:C1470.remoteAddress:=$connection.request.remoteAddress
	This:C1470.url:=$connection.request.url
	This:C1470.room:=$connection.request.query.room
	
	This:C1470.ORDA:={}
	This:C1470.ORDA.room:=ds:C1482.Room.select(This:C1470.room)
	
Function onMessage($socket : 4D:C1709.WebSocketConnection; $message : cs:C1710._Message)
	
	$remoteAddress:=$socket.handler.remoteAddress
	
	BLOB TO PICTURE:C682($message.data; $frame; ".jpg")
	$socket.handler.instance.frame:=$frame
	
	$socket.handler.instance.stream:=$message
	$socket.handler.instance.connection:=This:C1470
	
Function onOpen($socket : 4D:C1709.WebSocketConnection; $open : cs:C1710._Open)
	
	$remoteAddress:=$socket.handler.remoteAddress
	
	$socket.handler.instance.stream:=$open
	$socket.handler.instance.connection:=This:C1470
	
Function onTerminate($socket : 4D:C1709.WebSocketConnection; $terminate : cs:C1710._Terminate)
	
	$remoteAddress:=$socket.handler.remoteAddress
	
	$socket.handler.instance.stream:=$terminate
	$socket.handler.instance.connection:=This:C1470
	
Function onError($socket : 4D:C1709.WebSocketConnection; $error : cs:C1710._Error)
	
	$socket.handler.instance.stream:=$error
	$socket.handler.instance.connection:=This:C1470
	