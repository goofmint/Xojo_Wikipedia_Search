#tag Class
Protected Class Wikipedia
	#tag Method, Flags = &h0
		Function generateUrl(keyword as String) As String
		  // パラメータの生成
		  Dim parameters as JSONItem = new JSONItem
		  parameters.Value("format") = "json"
		  parameters.Value("action") = "query"
		  parameters.Value("rvparse") = "1"
		  parameters.Value("rvprop") = "content"
		  parameters.Value("prop") = "revisions"
		  parameters.Value("titles") = keyword
		  
		  // URLとして連結
		  Dim url as String = Me.searchUrl
		  url = url + "?"
		  Dim key as String
		  For Each key in parameters.Names
		    url = url + key + "=" + EncodeURLComponent(parameters.Value(key)) + "&"
		  Next
		  
		  // URLを返す
		  return url
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getContent(keyword as String) As String
		  // URL生成
		  Dim url as String = generateUrl(keyword)
		  
		  // 検索実行
		  Dim https as HTTPSecureSocket = new HTTPSecureSocket
		  Dim page as String = https.Get(url, 10)
		  
		  // パースした結果をそのまま返す
		  return parseJSON(page)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function parseJSON(content as String) As String
		  Dim json as JSONItem = new JSONItem(content)
		  
		  Dim queryJson as JSONItem = json.Value("query")
		  Dim pagesJson as JSONItem = queryJson.Value("pages")
		  
		  Dim pages() as String = pagesJson.Names
		  Dim pageJson as JSONItem = pagesJson.Value(pages(0))
		  
		  
		  Dim revisionJson as JSONItem = pageJson.Value("revisions")
		  Dim contentJson as JSONItem = revisionJson(0)
		  
		  return contentJson.Value("*")
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		searchUrl As String = "https://ja.wikipedia.org/w/api.php"
	#tag EndProperty


	#tag ViewBehavior
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
			Name="searchUrl"
			Group="Behavior"
			InitialValue="https://ja.wikipedia.org/w/api.php"
			Type="String"
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
	#tag EndViewBehavior
End Class
#tag EndClass
