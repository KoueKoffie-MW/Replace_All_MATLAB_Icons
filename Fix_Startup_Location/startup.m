function startup()
    % Define the path to the file where the directory was saved
    userDir = userpath;
    if userDir(end) == ';'
        userDir(end) = [];
    end
    saveFilePath = fullfile(userDir, 'lastDir.mat');
    
    % Check if the file exists
    if isfile(saveFilePath)
        % Load the last directory
        load(saveFilePath, 'currentDir');
        
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