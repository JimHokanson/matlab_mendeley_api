classdef doc_authored < mendeley.api.pvt_response.doc_library
    %
    %   Class:
    %   mendeley.api.pvt_response.doc_authored
    %
    %   This is currently the same behavior as it's super class
    %   although it indicates documents that the user has authored
    
    properties
    end
    
    methods
        function obj = doc_authored(raw)
           obj@mendeley.api.pvt_response.doc_library(raw); 
        end
    end
    
end

