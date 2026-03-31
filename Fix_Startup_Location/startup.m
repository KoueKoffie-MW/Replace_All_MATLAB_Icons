execute_startup_tasks();

function execute_startup_tasks()
    % Determine the MATLAB version
    matlabVersion = version('-release');
    
    % Define the path to the file where the directory was saved
    userDir = userpath;
    if userDir(end) == ';'
        userDir(end) = [];
    end
    loadFilePath = fullfile(userDir, ['lastDir_' matlabVersion '.mat']);
    
    % Check if the file exists
    if isfile(loadFilePath)
        % Load the last directory
        load(loadFilePath, 'currentDir');
        
        % Change to the last directory
        if isfolder(currentDir)
            cd(currentDir);
        else
            disp('Previous directory no longer exists. Starting in default directory.');
        end
    else
        disp('No previous directory found. Starting in default directory.');
    end
end