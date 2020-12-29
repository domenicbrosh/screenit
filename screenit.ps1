<#
Info

	Released under public domain license by Domenic Brosh

	This script creates a contact sheet with screenshots
	from a video file. It is not very efficiant and there
	may be better commands. But I just needed a quick and 
  	dirty script.

Prerequisites
	The following binarys must exist in the Path environment variable:
		- ffmpeg.exe
		- ffprobe.exe

Usage
	.\screenit -{InputFile | InputDirectory} [-Width] [-Height]

Screenshot specific file
	.\screenit.ps1 -InputFile C:\temp\movies\Big_Buck_Bunny.mp4

Screenshot all files in a given folder
	.\screenit.ps1 -InputDirectory C:\temp\movies -Width 3 -Height 3 #>


param(
[Parameter()]
	# directory of the video file(s). For now just make sure that
	# there are only video files in the folder. There is no error
	# handling in this script.
	[string]$InputDirectory,

	
	[Parameter()]
	# specific file in a folder
	[string]$InputFile,

	[Parameter()]
	# Number of horizontal images
	[int]$Width = 2,

	[Parameter()]
	# Number of vertical images
    [int]$Height = 3
 )

if ($InputFile -ne $null -and $InputFile -ne "") {

		# Split file into equal intervals based on length
		$videolength = ffprobe.exe -i $InputFile -show_entries format=duration -v quiet -of csv=p=0
		# Divide by the number of desired screenshots
		$interval = $videolength / ($Width * $Height)

		# Video file name and path
		$outfile = (Get-Item $InputFile).BaseName
		$directory = (Get-Item $InputFile).DirectoryName

		# JPG is used to keep the resulting file size low.
		# You can set this to PNG if desired.
		ffmpeg.exe -i $InputFile -frames 1 -vf "fps=fps=1/$interval, tile=`"$Width`"x`"$Height`"" $directory\$outfile.jpg -hide_banner -loglevel warning
} 

else {
	$files = Get-ChildItem -path $InputDirectory
	
	foreach ($f in $files) {

		# Split file into equal intervals based on length
		$videolength = ffprobe.exe -i $InputDirectory\$f -show_entries format=duration -v quiet -of csv=p=0
		# Divide by the number of desired screenshots
		$interval = $videolength / ($Width * $Height)

		# Video file name without extension
		$outfile = $f.BaseName

		# JPG is used to keep the resulting file size low.
		# You can set this to PNG if desired.
		ffmpeg.exe -i $InputDirectory\$f -frames 1 -vf "fps=fps=1/$interval, tile=`"$Width`"x`"$Height`"" $InputDirectory\$outfile.jpg -hide_banner -loglevel warning
	}
}
