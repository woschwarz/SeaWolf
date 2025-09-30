#tag Class
Protected Class Ship
	#tag Property, Flags = &h0
		destroyed As Boolean = false
	#tag EndProperty

	#tag Property, Flags = &h0
		imagename As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		points As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		speed As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		width As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		xpos As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ypos As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="destroyed"
			Group="Behavior"
			InitialValue="false"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="imagename"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="points"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="speed"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="width"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="xpos"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ypos"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
