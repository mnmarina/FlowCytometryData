classdef PMFlowJoReadExportedData
    %PMFLOWJOREADEXPORTEDDATA to read and process data exported from FlowJo;
    %   Detailed explanation goes here
    
    properties (Access = private)
        FolderWithExportedData

        FileNameWithFilenameInfo % list of keys with filenames or filename-combinations to read different data combinations (see PMFlowJoFileIDCodes for format of this file);
        FileNameWithRowTitles % each row contains two descriptions for the parameters in this row, see PMRowTitles for more details;
        FileNameWithGroupIndices % contains list of indices per group; some exported flow-jo files contain entries from distinct groups, see PMFlowJoGroupIndices for more detail;

    end
    
    methods
        function obj = PMFlowJoReadExportedData(varargin)
            %PMFLOWJOREADEXPORTEDDATA Construct an instance of this class
            %   Detailed explanation goes here
            switch length(varargin)

                case 4



                otherwise
                    error('Wrong input.')


            end
        end
        
        function obj = setSelections(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

