classdef PMFlowJoXYData
    %PMFLOWJOXYDATA Generate XYData objects from matrix files exported by FlowJo;
    % this allows simple extraction of data for flow-jo exported csv files that contain multiple groups;
    % also it allows pooling from multiple experiment files
    % defining how to process the data is done by three helper text files that the user must create;
    % the paths of these text files are arguments when intializing objects;
    

    properties (Access =private)

        FolderWithExportedData
        FileNameWithFilenameInfo
        FileNameWithGroupIndices
        FileNameWithRowTitles
        MatchMeans = true

    end

    
    properties (Access = private)

        % Specify data that should be read:
        SelectedExperimentKey
        SelectedParameterName
        
        


    end

    
        properties (Access = private) % STATISTICS
        
            CenterType = 'Median';
            %CenterType = 'Mean';

            StatisticsTest = 'Student''s t-test';
          %  StatisticsTest = 'Mann-Whitney test';

        
        end
    
        
    
    methods % INITIALIZE:
        
         function obj =     PMFlowJoXYData(varargin)
            %PMFLOWJOXYDATA Construct an instance of this class
            %   takes 5 arguments:
            % 1: folder path: this must contain all the FlowJo exported csv-files that will be used;
            % 2: complete path for file containing "keys" for separate data-groups (see PMFlowJoFileIDCodes for requirements of this text-file);
            % 3: complete path for file containing 
            % 4:
            % 5: match means: logical scalar: this is only relevant when pooling data from multiple experiments, if yes: the total mean of all data in the second experiment will be matched to the total mean of all data to the first experiment;
           switch length(varargin)
               
               case 3
                   error('Use 5 arguments.')

                    obj.FolderWithExportedData =        [ varargin{1}.getFlowJoNumberFolder, '/FlowJoExports'];            
                    obj.FileNameWithFilenameInfo =      [varargin{1}.getFlowJoNumberFolder, '/', varargin{3} ];
                    obj.FileNameWithGroupIndices =      varargin{4};
                    obj.FlowJoGroupCodesFileName   =      varargin{2};           
                    name =                      obj.FileManagerObject.getFloJoGroupFolder;


               case 4
                   error('Use 5 arguments.')

                    obj.FolderWithExportedData =      [ varargin{1}.getFlowJoNumberFolder, '/FlowJoExports'];  
                    obj.FileNameWithFilenameInfo =      [varargin{1}.getFlowJoNumberFolder, '/',varargin{3} ];      
                    obj.FlowJoGroupCodesFileName             =      varargin{2};           
                    obj.MatchMeans =                                varargin{4};

               case 5

                    obj.FolderWithExportedData =        varargin{1};
                    obj.FileNameWithFilenameInfo =      varargin{2};
                    obj.FileNameWithRowTitles =         varargin{3};
                    obj.FileNameWithGroupIndices =      varargin{4};
                    obj.MatchMeans =                    varargin{5};

                   
           end
           
           
                
           
        end
     
   
  
        
        
    end
    
        
     methods % GETTERS
        
        function XYData_CD3 = getXYData(obj, varargin)
            % GETXYDATA returns a specified PMXVsYDataContainer object from CXCR4_InVitroInhibition_OTI_EL4_CD3 experiments;
            % takes 4 to 5 arguments arguments:
            % 1: name of wanted experiment-key;
            % 2: name of wanted parameter;
            % 3: type:  'IndividualValues', 'PercentageInRange'
            % 4: range (for percentage in range)
           
            
            switch length(varargin)

                case {3}
                    obj.SelectedExperimentKey =       varargin{1};
                    obj.SelectedParameterName =       varargin{2};
<<<<<<< Updated upstream
                    %   obj.ParameterNamesFileName =      varargin{3};
                 
                    try
                        XYData_CD3 =                      obj.getXYDataCommon(varargin{3});
                    catch ME
                        rethrow(ME)
                    end
=======
                 %   obj.ParameterNamesFileName =      varargin{3};
                    obj.SelectedGroups =              varargin{3}; 

                  
                   
                      XYData_CD3 =                      obj.getXYDataCommon(varargin{4});
>>>>>>> Stashed changes

                case { 5}
                    obj.SelectedExperimentKey =       varargin{1};
                    obj.SelectedParameterName =       varargin{2};
                    XYData_CD3 =                      obj.getXYDataCommon(varargin{3}, varargin{4});

               
                case 6

                    error('Not supported. Use 5 inputs instead.')
                    obj.SelectedExperimentKey =       varargin{1};
                    obj.SelectedParameterName =       varargin{2};
                 %  obj.ParameterNamesFileName =      varargin{3};
                 %   obj.SelectedGroups =              varargin{4}; 
                    XYData_CD3 =                      obj.getXYDataCommon(varargin{5}, varargin{6});
                    
                case 7
                      error('Not supported. Use 5 inputs instead.')
                   
                otherwise
                    error('Wrong input.')
                
                
            end

        end
        
        function dataSource = getFlowJoDataSource(obj, varargin)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            switch length(varargin)
               
                case 0
                    
                case 2
                    obj.SelectedExperimentKey =         varargin{1};
                    obj.ParameterNamesFileName =        varargin{2};
                    
                otherwise
                    error('Wrong input.')
                
            end
  
            try
                dataSource = PMFlowJoDataSource(...
                    obj.getGroupIndicesObject, ...
                    obj.getParameterObject ...
                    );
                
                    dataSource = dataSource.setMatchMeansOfDifferentExperiments(obj.MatchMeans);

            catch ME
                rethrow(ME)


            end
                   
           end
                
    end
    
    
   
    
    methods (Access = private) % GETTERS DATA
        
        function XYDataList = getXYDataCommon(obj, Type, varargin)
            % getXYDataCommon returns PMXVsYDataContainer 
            switch Type
               
                case 'IndividualValues'
<<<<<<< Updated upstream
                    MyFlowJoDataSource =        obj.getFlowJoDataSource;
                    MyGroupStatisticsLists =    MyFlowJoDataSource.getGroupStatisticsLists;
                    
                    groupStatistics =               arrayfun(@(x) x.getGroupStatisticsWithParameterName(obj.SelectedParameterName), MyGroupStatisticsLists);
                  XYDataList =                      arrayfun(@(x) x.getXYData, groupStatistics);

=======

                   XYData =                obj.getGroupStatistics.getXYData(obj.SelectedGroups);
>>>>>>> Stashed changes
                case 'PercentageInRange'
                    assert(length(varargin) == 1, 'Wrong input.')
                    Range = varargin{1};
                    assert(PMNumbers(Range).isNumericVector, 'Wrong input.')
                    
                    MyFlowJoDataSource =        obj.getFlowJoDataSource;
                    MyGroupStatisticsLists =    MyFlowJoDataSource.getGroupStatisticsLists;
                    groupStatistics =           arrayfun(@(x) x.getGroupStatisticsWithParameterName(obj.SelectedParameterName), MyGroupStatisticsLists);

                    XYDataList =                arrayfun(@(x) x.getXYData, groupStatistics);
                    XYDataList =                XYDataList.getPercentagesPerBin(varargin{1});
                    
                otherwise
                    error('Wrong input.')
                
            end
            
                XYDataList =                arrayfun(@(x)x.setName(obj.SelectedExperimentKey), XYDataList);
                XYDataList =                 arrayfun(@(x)x.setYParameter(obj.SelectedParameterName), XYDataList);
                XYDataList =                 arrayfun(@(x)x.setCenterType(obj.CenterType), XYDataList);
                XYDataList =                 arrayfun(@(x)x.setPValueType(obj.StatisticsTest), XYDataList);
                
        end
        
    end
    

<<<<<<< Updated upstream
=======
        
      
        
        
    end
    
    methods (Access = private) % GETTERS FLOW-JO DATA
        
        function groupStatistics = getGroupStatistics(obj)

            groupStatistics =          ...
                   obj.getFlowJoDataSource.getGroupStatisticsListsForIndices(1).getGroupStatisticsWithParameterName(obj.SelectedParameterName);
               
            
        end
        
   
    
        
        
        
    end
    
>>>>>>> Stashed changes
    methods (Access = private) % GETTERS FUNDAMENTAL OBJECTS
        
        function MyGroupRows = getGroupIndicesObject(obj)

                [MyFolder, Name, Extension ] =      fileparts( obj.FileNameWithGroupIndices);
                MyGroupRows =                       PMFlowJoGroupIndices(...
                                                            MyFolder, ...
                                                            [ Name, Extension ],  ...
                                                            obj.getFileIDCodesObject...
                                                    );

            
        end
        
        function myFileIDCodes = getFileIDCodesObject(obj)

                [MyFolder, Name, Extension] =              fileparts( obj.FileNameWithFilenameInfo);
                myFileIDCodes =                             PMFlowJoFileIDCodes(...
                                                                MyFolder,  ...
                                                                obj.SelectedExperimentKey, ...
                                                                [ Name, Extension], ...
                                                                obj.FolderWithExportedData...
                                                            );

        end
        
        function myRowTitles = getParameterObject(obj)

            [MyFolder, Name, Extension ] =      fileparts(   obj.FileNameWithRowTitles);
            myRowTitles =                       PMRowTitles(...
                                                    MyFolder, ...
                                                    [Name, Extension] ...
                                                    );
                          
        end
  
    end
    
end