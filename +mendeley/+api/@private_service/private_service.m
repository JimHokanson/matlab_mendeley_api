classdef private_service < sl.obj.handle_light
    %
    %   Class:
    %   mendeley.api.private_service
    %
    %   Usage:
    %   1) Instantiate the object using the proper creds
    %   2) Use object methods to call API
    %
    %   Documentation of API:
    %   http://apidocs.mendeley.com/home/user-specific-methods
    %
    %   See Also:
    %   mendeley.api.public_service
    %   mendeley.api.options
    
    
    %CODE PROTOTYPE DESCRIPTION
    %======================================================================
    %
    %   Optional inputs to a function can be either:
    %   -------------------------------------------------------------------
    %   1) Property/Value pairs that are optional to the function being
    %   called. For example (TODO: FInish this)
    %
    %
    %
    %   2) 'options', with the value of the type:
    %           mendeley.api.options
    %
    %
    %
    
    
    % %Example code for a function
    % %------------------------------------------------------------------
    %
    % %OPTIONAL INPUTS
    % %1) prop/value pairs for params
    % %2)options => 'options',mendeley.api.options
    %
    %
    % params = {'page' 'items'};
    % url    = 'http://api.mendeley.com/oapi/library/';
    %
    % %varargin => see options
    % [params,options]  = processInputOptions(obj,params,varargin);
    %
    %
    %
    % [output,success]  = obj.makeRequest(url,params,options);
    
    
    properties
        oauth  %Class: oauth.request.public
    end
    
    %Constructor and Generic Code Function Handling -----------------------
    methods
        function obj = private_service(private_oauth_creds)
            %
            %    INPUTS
            %    ===========================================================
            %    private_oauth_creds : Class: oauth.creds.private
            %
            %
            obj.oauth = oauth.request.private(private_oauth_creds); %#ok<PROP>
        end
        function [output,success] = makeRequest(obj,url,params,options)
            %makeRequest
            %
            %    [output,success] = makeRequest(obj,url,params,*options)
            %
            %    OUTPUTS
            %    ===========================================================
            %    output  : Depends on 'return_type' property of options
            %    success :
            %
            %    INPUTS
            %    ===========================================================
            %    url     :
            %    params  : cell array of property/value pairs
            %    options : mendeley.api.options
            %
            %   See Also:
            %   mendeley.api.pvt_response
            %   oauth.urlread_response
            %   mendeley.api.pvt_response.createObject
            
            %???? - why doesn't this  ('raw') get handled in the method????
            %oauth.request.private.makeRequest
            if strcmp(options.return_type,'raw')
                options.oauth_options.populate_raw       = true;
                options.oauth_options.parse_content_type = false;
                r = obj.oauth.makeRequest(url,options.http_method,params,options.oauth_options);
            else
                r = obj.oauth.makeRequest(url,options.http_method,params,options.oauth_options);
            end
            %r : Class: oauth.urlread_response
            
            success = r.status_value == options.response_value;
            if options.throw_error && ~success
                error('Error: %s',r.raw)
            end
            
            %Processing the output ...
            switch options.return_type
                case 'object'
                    fh = options.object_fh;
                    if isempty(fh)
                        %TODO: Document this and method naming requirements ...
                        %--------------------------------------------------------------
                        %i.e. this is basically getting the name of the caller
                        %and creating a class with the same name as the caller
                        %length('private_service.') = 16
                        %
                        %   private_service.doc_library -> doc_library
                        s      = dbstack;
                        type   = s(2).name(17:end);
                        output = mendeley.api.pvt_response.createObject(type,r);
                    else
                        output = feval(fh,r.response);
                    end
                case 'json'
                    output = r.response;
                case 'raw'
                    output = r.raw;
                otherwise
                    error('Unrecognized return type')
            end
            
        end
        function [params,options,p_struct] = processInputOptions(~,default_params,varargin_input)
            %
            %
            %   [params,options,p_struct] = processInputOptions(obj,params,varargin_input)
            %
            %   INPUTS
            %   ===========================================================
            %   default_params: (cell of prop/value pairs)
            %   varargin_input: the varargin input argument from the
            %       function calling this function
            %
            %   OUTPUTS
            %   ===========================================================
            %
            %
            %
            %   TODO: Document this code ...
            
            input_options = cell2struct(repmat({''},length(default_params)+1,1),[default_params(:); {'options'}]);
            
            input_options = sl.in.processVarargin(input_options,varargin_input);
            
            %TODO: Run numeric processing ...
            %use structfun
            
            options = input_options.options;
            
            if isempty(options)
                options = mendeley.api.options;
            end
            
            p_struct = rmfield(input_options,'options');
            
            params = [fieldnames(p_struct) struct2cell(p_struct)]';
            
            %reshape and make row vector
            params = params(:)';
            
        end
    end
    
    %Document Methods -----------------------------------------------------
    methods
        function [output,success] = doc_library(obj,varargin)
            %doc_library
            %
            %   [output,success] = doc_library(obj,varargin)
            %
            %   #doc_page: http://apidocs.mendeley.com/home/user-specific-methods/user-library
            %
            %   OPTIONAL INPUTS (prop/value pairs)
            %   ===========================================================
            %   page  : 0 based page
            %   items : # of items to request per page
            %
            %   Status: DONE
            
            params = {'page' 'items'};
            url    = 'http://api.mendeley.com/oapi/library/';
            
            [params,options]  = processInputOptions(obj,params,varargin);
            
            [output,success]  = obj.makeRequest(url,params,options);
        end
        function [output,success] = doc_libraryAll(obj)
            %??? - how to handle merging options from user?
            temp             = obj.doc_library();
            [output,success] = obj.doc_library('items',temp.total_results);
        end
        
        function [output,success] = doc_authored(obj,varargin)
            %DONE
            %
            %    #doc_page: http://apidocs.mendeley.com/home/user-specific-methods/user-authored
            %
            %   OPTIONAL INPUTS
            %   ===========================================================
            %   page           : 0 based page
            
            params = {'page'};
            url = 'http://api.mendeley.com/oapi/library/documents/authored/';
            
            [params,options]  = processInputOptions(obj,params,varargin);
            
            [output,success]  = obj.makeRequest(url,params,options);
        end
        function doc_createEntry(obj,newEntry)
            %
            %
            %   #doc_page: http://apidocs.mendeley.com/home/user-specific-methods/user-library-create-document
            
            %TODO: Entry should be a class
            
            
        end
        function r = doc_deleteEntry(obj,id)
            %
            %
            %
            
            %NOT YET FINISHED
            %- needs to use new options instead of passing in method
            %to the function ...
            
% % %             if isnumeric(id)
% % %                 id = int2str(id);
% % %             end
% % %             url = ['http://api.mendeley.com/oapi/library/documents/' id '/'];
% % %             
% % %             r = obj.makeRequest(url,{},'http_method','DELETE');
            
        end
        function [output,success] = doc_details(obj,id,varargin)
            %Document Details
            %
            %   [output,success] = doc_details(obj,id,varargin)
            %
            %    Returns details for a specific document entry.
            %
            %    #doc_page: http://apidocs.mendeley.com/home/user-specific-methods/user-library-document-details
            
            if isnumeric(id)
                id = int2str(id);
            end
            
            url = ['http://api.mendeley.com/oapi/library/documents/' id '/'];
            
            [params,options]  = processInputOptions(obj,{},varargin);
            
            options.object_fh = @mendeley.doc.createFromURLresponse;
            
            [output,success]  = obj.makeRequest(url,params,options);
            
        end
        function r = doc_downloadFile(obj,id,file_hash,group_id)
            %
            %
            %   #doc_page: http://apidocs.mendeley.com/home/user-specific-methods/download-file
            
            if isnumeric(id)
                id = sprintf('%ld',id);
            end
            
        end
        function [output,success] = doc_uploadFile(obj,id,file_path,varargin)
            %
            %
            %    #doc_page: http://apidocs.mendeley.com/home/user-specific-methods/file-upload
            %
            %   INPUTS
            %   -------------------------
            %   file_path : (char or java.io.File)
            %
            %    IMPROVEMENTS:
            %    -----------------------------------------------------------
            %    1) - reading the file twice - see comment below
            %    2) - reading the file at once vs in chunks ... - urlread
            %    modificaiton would be needed
            
            if isnumeric(id)
                id = sprintf('%ld',id);
            end
            
            %NOTE: This will read the file twice
            %We can eventually pass in the data itself with a flag
            %indicating this to be the case ...
            hash = sl.crypt.getSHA1(file_path,'is_file',true);
            
            params = {};
            
            url = ['http://api.mendeley.com/oapi/library/documents/' id '/'];
            
            [params,options] = obj.processInputOptions(params,varargin);
            
            options.oauth_options.extra_oauth_params = {'oauth_body_hash' hash};
            
            options.return_type    = 'raw'; %There's nothing of interest returned
            options.http_method    = 'PUT';
            options.response_value = 201;
            uopts = options.oauth_options.urlread_options;
            uopts.body = sl.io.fileRead(file_path,'*uint8');
            
            uopts.headers(1).name  = 'Content-Disposition';
            file_name = sl.dir.getFileName(file_path);
            uopts.headers(1).value = sprintf('attachment; filename="%s"',file_name);
            uopts.headers(2).name  = 'Content-Type';
            uopts.headers(2).value = 'application/pdf';
            
            [output,success]  = obj.makeRequest(url,params,options);
            
            %r = obj.makeRequest(url,{},'http_method','DELETE');
            
            
            
        end
        function doc_updateEntry(obj,varargin)
            
        end
    end
    
    %Profile Info ---------------------------------------------------------
    methods
        function [output,success] = profile_info(obj,id,varargin)
            %
            %
            %   profile_info(obj,*id)
            %
            %   #doc_page: http://apidocs.mendeley.com/home/user-specific-methods/profile-information
            %
            %   INPUTS
            %   ===========================================================
            %   id : (default 'me'), If not specified the id returns info
            %          about the user. Of mpt
            
            if ~exist('id','var')
                id = 'me';
            elseif isnumeric(id)
                id = sprintf('%ld',id);
            end
            
            params = {};
            url    = ['http://api.mendeley.com/oapi/profiles/info/' id '/'];
            
            [params,options]  = processInputOptions(obj,params,varargin);
            
            [output,success]  = obj.makeRequest(url,params,options);
        end
    end
    
end

