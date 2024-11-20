function finish()
    % Get the current directory
    currentDir = pwd;
    
    % Define the path to the file where the directory will be saved
    userDir = userpath;
    if userDir(end) == ';'
        userDir(end) = [];
    end
    saveFilePath = fullfile(userDir, 'lastDir.mat');
    
    % Save the current directory to the file
    save(saveFilePath, 'currentDir');
end