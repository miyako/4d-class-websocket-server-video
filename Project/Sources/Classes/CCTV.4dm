Class extends _WSS

property stream : Object

Class constructor($controller : cs:C1710._WSS_Controller)
	
	$path:="/cctv"
	
	Case of 
		: (OB Instance of:C1731($controller; OB Class:C1730(cs:C1710._WSS_Controller)))
			Super:C1705($path; $controller; "blob")
		Else 
			Super:C1705($path; cs:C1710.CCTV_WSS_Controller; "blob")
	End case 
	
	This:C1470.stream:={}
	This:C1470.path:=$path
	