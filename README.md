# screenit
This script creates a contact sheet with screenshots from a video file.

![alt text](https://raw.githubusercontent.com/domenicbrosh/screenit/main/file_explorer_Big_Buck_Bunny.jpg)

# Usage
	.\screenit -{InputFile | InputDirectory} [-Width] [-Height]

Screenshot specific file

```powershell
.\screenit.ps1 -InputFile C:\temp\movies\Big_Buck_Bunny.mp4
```

Screenshot all files in a given folder
```powershell
.\screenit.ps1 -InputDirectory C:\temp\movies -Width 3 -Height 3
```

# Prerequisites
The following binarys must exist in the Path environment variable:

* ffmpeg.exe
* ffprobe.exe
