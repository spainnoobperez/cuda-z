@rem	\file vcproj.bat
@rem	\brief Runs qmake and starts Visual Studio.
@rem	\author AG

@echo Starting Visual Studio...
@qmake && start cuda-z.sln
