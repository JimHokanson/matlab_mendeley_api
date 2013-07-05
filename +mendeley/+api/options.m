classdef options < handle_light
    %
    %   Class:
    %   mendeley.api.options
    
    properties
        throw_error     = true
        return_type     = 'object'
        %
        %   OPTIONS
        %   =======================================
        %   'object' :
        %   'json'   : NYI 
        %   'raw'    : NYI
        
        http_method     = 'GET'
        oauth_options   %Class: oauth.options
        response_value  = 200 
        
        object_fh %Optional property to set by calling methods. If not 
        %specified then the class of the same name of the calling function
        %is called.
        %
        %   For example:
        %   1) call made to: 
        %       mendeley.api.private_service.doc_library() 
        %
        %   2) private_service calls: 
        %       mendeley.api.pvt_response.createObject
        %   
        %   3) createObject calls a subclass with name doc_library
        %   per the name of the function call above
        %
        %If this property IS SET:
        %   Then the method will be called with the input:
        %       oauth.urlread_response
        %   
        %This property is set by the calling methods ...
    end
    
    methods
        function obj = options()
            temp = oauth.options;
            temp.allow_empty_oauth_params = false;
            temp.cast_numbers_to_strings  = true;
            obj.oauth_options = temp;
        end
    end
    
end

