classdef (Hidden) pvt_response < sl.obj.handle_light
    %
    %   Class:
    %   mendeley.api.pvt_response
    %
    %   Generic class for creating a response object to a private_service
    %   response.
    %
    %   See Also:
    %   mendeley.api.private_service.makeRequest
    %
    %
    %   Known subclasses:
    %   mendeley.api.pvt_response.doc_library
    
    properties (Hidden)
        raw_json
        raw_response
    end
    
    methods (Static)
        function obj = createObject(type,response_obj)
            %
            %   mendeley.api.pvt_response.createObject(type,response_obj)
            %
            %    INPUTS
            %    =============================================
            %    type : method name
            %    response_obj : oauth.urlread_response
            %
            %   See Also:
            %   mendeley.api.private_service
            
            
            raw_json = response_obj.response; %#ok<*PROP>
            
            obj = mendeley.api.pvt_response.(type)(raw_json);
            
            obj.raw_json     = raw_json;
            obj.raw_response = response_obj.raw;
            
            
        end
    end
end

