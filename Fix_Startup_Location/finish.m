execute_finish_tasks();

function execute_finish_tasks()
    % Get the current directory
    currentDir = pwd;
    
    % Determine the MATLAB version
    matlabVersion = version('-release');
    
    % Define the path to the file where the directory will be saved
    userDir = userpath;
    if userDir(end) == ';'
        userDir(end) = [];
    end
    saveFilePath = fullfile(userDir, ['lastDir_' matlabVersion '.mat']);
    
    % Save the current directory to the file
    save(saveFilePath, 'currentDir');
end