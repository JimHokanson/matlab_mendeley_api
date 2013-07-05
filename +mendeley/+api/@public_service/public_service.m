classdef public_service < sl.obj.handle_light
    %
    %   Class:
    %   mendeley.api.public_service
    %
    %   This class is for making public API calls to the Mendeley API.
    %
    %   See Also:
    %   mendeley.api.private_service
    
    %MLINT
    %#ok<*PROP>
    
    properties
       oauth  %Class: oauth.request.public
    end
    
    methods
        function obj = public_service(consumer_auth)
           %
           %
           %    obj = public_service(consumer_auth)
           %
           %    INPUTS
           %    ==========================================================
           %    consumer_auth : Classes 
           %            - oauth.creds.public
           %            - oauth.creds.private
           
           obj.oauth = oauth.request.public(consumer_auth);
        end
        function r = search_authored(obj,name,varargin)
            %
            %
            %   OPTIONAL INPUTS
            %   =======================================================================
            %   page  : (string or integer) page # in the search request
            %   items : (string or integer) # items per page
            %   year  : (string or integer) year filter
            
            %TODO: Translate this to form of private_service
            
            in.page  = '';
            in.items = '';
            in.year  = '';
            in = sl.obj.processVarargin(in,varargin);
            
            url = ['http://api.mendeley.com/oapi/documents/authored/' ...
                    oauth.percentEncodeString(name) '/']; 
            
            params = {'page' in.page 'items' in.items 'year' in.year};
            
            options = mendeley.api.getOptions;
            
            r = obj.oauth.makeRequest(url,'GET',params,options);
            
        end
    end
    
end

