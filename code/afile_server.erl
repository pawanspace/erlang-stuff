-module(afile_server).
-export([start/1, loop/1]).

%% spawn will start a new process on file_server call loop method passing dir as one argument
start(Dir) -> spawn(afile_server, loop, [Dir]).

%% Dir contains current working directory of file server.
loop(Dir) ->
		receive 
				{Client, list_dir} -> %% receive a message from client for list_dir
						Client ! {self(), file:list_dir(Dir)}; %% send a message to Client 
				 {Client, {get_file, File}} ->
						Full = filename:join(Dir, File),
						Client ! {self(), file:read_file(Full)}
		end,
		loop(Dir).
