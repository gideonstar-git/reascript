projectFilename = reaper.GetProjectName()
project, pathWithProjectFilename = reaper.EnumProjects(-1)
projectPath = string.gsub(pathWithProjectFilename, projectFilename, "")
lockFile = projectPath .. ".lock"

function createLock()
  file = io.open(lockFile, "w")
  io.close(file)
end

function deleteLock()
  os.remove(lockFile)
end

if reaper.file_exists(lockFile) then
  reaper.ShowMessageBox("Someone's working in the project!", "Warning", 0)
  reaper.Main_OnCommand( 40004, 0 )
else
  createLock()
end
