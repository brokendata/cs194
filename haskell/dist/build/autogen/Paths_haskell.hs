module Paths_haskell (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\nmrw48\\AppData\\Roaming\\cabal\\bin"
libdir     = "C:\\Users\\nmrw48\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-7.8.3\\haskell-0.1.0.0"
datadir    = "C:\\Users\\nmrw48\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-7.8.3\\haskell-0.1.0.0"
libexecdir = "C:\\Users\\nmrw48\\AppData\\Roaming\\cabal\\haskell-0.1.0.0"
sysconfdir = "C:\\Users\\nmrw48\\AppData\\Roaming\\cabal\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "haskell_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "haskell_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "haskell_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "haskell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "haskell_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
