Option Explicit

Sub ExportLastMeasurement()
	'Initialisierung
	Dim BASE_URL As String
	Dim LOCAL_DOWNLOAD_DIR As String
	Dim RequestObj As Object
	Dim fso As New FileSystemObject
	Dim measurement_fn As String
	Dim json_fn As String
	Dim download_fn As String
	Dim JsonInfo As Object
	Dim JsonDl As Object
	Dim oStream As Object

	BASE_URL = "http://192.168.0.114:3000"
	LOCAL_DOWNLOAD_DIR = "C:\tmp\"

	'Messungen abfragen
	Set RequestObj = CreateObject("MSXML2.XMLHTTP")
	RequestObj.Open "GET", BASE_URL & "/measurements/info/last", False
	RequestObj.Send
	'Debug.Print "Ergebnis von measurements/info: " & RequestObj.ResponseText

	'Dateiname extrahieren, Antwort parsen mit https://github.com/VBA-tools/VBA-JSON
	Set JsonInfo = JsonConverter.ParseJson(RequestObj.ResponseText)
	measurement_fn = JsonInfo("filename")
	json_fn = fso.GetBaseName(measurement_fn) & "." & fso.GetExtensionName(measurement_fn)
	Debug.Print "Dateiname der letzten Messung: " & json_fn

	'Download anstoßen
	RequestObj.Open "GET", BASE_URL & "/measurements/download/xlsx/" & json_fn & "/true/null/null", False
	RequestObj.Send
	Set JsonInfo = JsonConverter.ParseJson(RequestObj.ResponseText)
	download_fn = JsonInfo("filename")
	Debug.Print "Dateiname des Downloads: " & download_fn

	'Download herunterladen und unter C:\tmp\ speichern
	RequestObj.Open "GET", BASE_URL & "/measurements/temp_download/" & download_fn, False
	RequestObj.Send
	Set oStream = CreateObject("ADODB.Stream")
	oStream.Open
	oStream.Type = 1
	oStream.Write RequestObj.responseBody
	oStream.SaveToFile LOCAL_DOWNLOAD_DIR & download_fn, 2 ' 1 = no overwrite, 2 = overwrite
	oStream.Close
	Debug.Print "Datei gespeichert: " & LOCAL_DOWNLOAD_DIR & download_fn

	'Download in XLSX öffnen
	Workbooks.Open Filename:=LOCAL_DOWNLOAD_DIR & download_fn
End Sub
