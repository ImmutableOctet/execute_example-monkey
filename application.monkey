Strict

Public

' Preprocessor related:

' If enabled, this will use the system-defined first
' application-argument to try to restart this application.
'#EXECUTE_EXAMPLE_USE_FIRST_ARG = True

' This is used to toggle use of the 'os' module.
'#EXECUTE_EXAMPLE_OS = True

' Imports:
Import brl.process

#If EXECUTE_EXAMPLE_OS
	Import os
#End

' Functions:
#If Not EXECUTE_EXAMPLE_OS
	Function HostOS:String()
		#If HOST = "winnt"
			Return "winnt"
		#Elseif HOST = "linux"
			Return "linux"
		#Elseif HOST = "macos"
			Return "macos"
		#Else
			Return ""
		#Endif
	End
#End

Function Main:Int()
	Local Arguments:= AppArgs()
	
	' The first argument is already system-reserved.
	' This is usually a path pointing to the running application.
	' In our specific case, we're checking if we have any other arguments.
	' By default, Monkey doesn't pass anything to the application, so we
	' can use this to check if we're running for the first time:
	If (Arguments.Length <= 1) Then
		Print("Application started for the first time.")
		
		Print("Starting this application again:")
		
		#If Not EXECUTE_EXAMPLE_USE_FIRST_ARG
			Execute("main_" + HostOS() + " -test")
		#Else
			Execute(Arguments[0] + " -test")
		#End
		
		Print("Original application finished.")
	Else
		Print("New instance:")
		
		For Local I:= 1 Until Arguments.Length
			Print(Arguments[I])
		Next
		
		Print("")
		
		Print("Hello world.")
		
		Print("New application finished.")
	Endif
	
	Return 0
End