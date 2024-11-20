function setupStartupAndFinishScripts()
    % Define the content for startup.m
    startupContent = [
    "function startup()"
    "% Determine the MATLAB version"
    "matlabVersion = version('-release');"
    ""
    "% Define the path to the file where the directory was saved"
    "userDir = userpath;"
    "if userDir(end) == ';'"
    "    userDir(end) = [];"
    "end"
    "loadFilePath = fullfile(userDir, ['lastDir_' matlabVersion '.mat']);"
    ""
    "% Check if the file exists"
    "if isfile(loadFilePath)"
    "    % Load the last directory"
    "    load(loadFilePath, 'currentDir');"
        ""
        "% Change to the last directory"
        "if isfolder(currentDir)"
            "cd(currentDir);"
        "else"
         "   disp('Previous directory no longer exists. Starting in default directory.');"
        "end"
    "else"
        "disp('No previous directory found. Starting in default directory.');"
    "end"
"end"
    ];
    
    % Define the content for finish.m
    finishContent = [
        "function finish()"
    "% Get the current directory"
    "currentDir = pwd;"
    ""
    "% Determine the MATLAB version"
    "matlabVersion = version('-release');"
    ""
    "% Define the path to the file where the directory will be saved"
    "userDir = userpath;"
    "if userDir(end) == ';'"
        "userDir(end) = [];"
    "end"
    "saveFilePath = fullfile(userDir, ['lastDir_' matlabVersion '.mat']);"
    ""
    "% Save the current directory to the file"
    "save(saveFilePath, 'currentDir');"
"end"
    ];

    % Determine the user path directory
    userDir = userpath;
    if userDir(end) == ';'
        userDir(end) = [];
    end

    % Define the paths for the scripts
    startupPath = fullfile(userDir, 'startup.m');
    finishPath = fullfile(userDir, 'finish.m');

    % Write the content to startup.m
    fid = fopen(startupPath, 'w');
    fprintf(fid, '%s\n', startupContent);
    fclose(fid);

    % Write the content to finish.m
    fid = fopen(finishPath, 'w');
    fprintf(fid, '%s\n', finishContent);
    fclose(fid);

    % Display a message indicating success
    disp(['startup.m and finish.m have been set up in ', userDir]);
end

% % Run the setup function
% setupStartupAndFinishScripts();