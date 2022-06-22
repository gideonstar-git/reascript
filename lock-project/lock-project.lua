--
-- Locks the project when someone else is editing it. Useful when multiple
-- people are using the same project via a cloud.
--
-- Needs the SWS extensions and can be installed there as a start script
-- for the respective project.
--

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

function firstUser()
  reaper.runloop(firstUser)
  reaper.atexit(deleteLock)
end

if reaper.file_exists(lockFile) then
  reaper.ShowMessageBox("Someone's working in the project!", "Warning", 0)
  reaper.Main_OnCommand( 40004, 0 )
else
  createLock()
  firstUser()
end
