program ReadWriteAlbum;

type
	Track = record
		name: String;
		artist: String;
        location: String;
	end;
	Album = record
		name: String;
		yearReleased: Integer;
		numberOfTracks: Integer;
		tracks: array of Track; // What kind of array is "tracks"?
	end;


// The following code shows how to write a track from file
function ReadTrack(var myFile: TextFile): Track;
var myTrack: Track;
begin
	ReadLn(myFile, myTrack.name); // To read "name" of myTrack
	ReadLn(myFile, myTrack.artist);
	ReadLn(myFile, myTrack.location);
	result := myTrack;
end;





// This procedure to print myFile
function ReadAlbum (fileName: String): Album;
var myAlbum: Album;
	myFile: TextFile;
	i: Integer;
begin
	AssignFile(myFile, fileName); // To link file in hard-drive with memory managed by Pascal program
	Reset(myFile);  // To open a file for reading
	ReadLn(myFile, myAlbum.name); // To read "name" of myAlbum
	ReadLn(myFile, myAlbum.yearReleased);
	ReadLn(myFile, myAlbum.numberOfTracks);
	SetLength(myAlbum.tracks, myAlbum.numberOfTracks); // Do you remember the purpose of SetLength procedure?
	for i:= 0 to myAlbum.numberOfTracks-1 do
		myAlbum.tracks[i] := ReadTrack(myFile); //
	Close(myFile); // We need to close the file and re-open it, as Pascal
	result := myAlbum;
end;


// This procedure takes one Track record and prints it to the terminal
procedure PrintTrack(myTrack: Track);
begin
WriteLn('Track Name: ', myTrack.name);
WriteLn('Artist Name: ', myTrack.artist);
WriteLn('Track location: ', myTrack.location);
end;

// This procedure to print myAlbum to Terminal
procedure PrintAlbum (myAlbum: album);
var
	i: Integer;
begin
	WriteLn('Name of album: ', myAlbum.name); // To print "name" of myAlbum
	WriteLn('year released: ', myAlbum.yearReleased);
	WriteLn('Number of tracks: ', myAlbum.numberOfTracks);
	for i:= 0 to myAlbum.numberOfTracks-1 do
	begin
		PrintTrack(myAlbum.tracks[i]);
		end;
end;


// This procedure to change myAlbum
function ChangeAlbum (myAlbum: Album): Album;
var
newAlbum: Album;
	i: Integer;
begin
	newAlbum.name := myAlbum.name;
	newAlbum.yearReleased := myAlbum.yearReleased;
	newAlbum.numberOfTracks := myAlbum.numberOfTracks-1;
	SetLength(newAlbum.tracks, newAlbum.numberOfTracks);
	for i:= 0 to newAlbum.numberOfTracks-1 do
	begin
		newAlbum.tracks[i] := myAlbum.tracks[i];
	  newAlbum.tracks[i].location := 'your-new-file-name.mp3';
	end;
	result := newAlbum;
end;



// This procedure takes one Track record and write only "name" and "artist" to file
procedure WriteTrackSimply(var myFile: TextFile; myTrack: Track);
begin
	WriteLn(myFile, myTrack.name);
	WriteLn(myFile, myTrack.artist);
end;



// This procedure to write myAlbum to file
procedure WriteAlbum (myAlbum: Album; fileName: String);
var
myFile: TextFile;
i: Integer;
begin
AssignFile(myFile, fileName); // To link file in hard-drive with memory managed by Pascal program
ReWrite(myFile);  // To open a file for reading
WriteLn(myFile, myAlbum.name); // To read "name" of myAlbum
WriteLn(myFile, myAlbum.yearReleased);
WriteLn(myFile, myAlbum.numberOfTracks);
SetLength(myAlbum.tracks, myAlbum.numberOfTracks);
for i:= 0 to myAlbum.numberOfTracks-1 do
WriteTrackSimply(myFile,myAlbum.tracks[i]);
Close(myFile); // We need to close the file and re-op
end;


procedure Main();
var myAlbum : Album;
begin
	myAlbum := ReadAlbum ('billboard2018.dat');
	WriteLn('Original Album:');
	PrintAlbum(myAlbum);
 myAlbum := ChangeAlbum(myAlbum);
	WriteLn('Modified Album:');
	PrintAlbum(myAlbum);
	WriteAlbum (myAlbum, 'billboardsimple.dat');
end;


begin
	Main();
end.
