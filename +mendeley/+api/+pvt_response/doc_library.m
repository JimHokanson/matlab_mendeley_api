classdef doc_library < mendeley.api.pvt_response
    %
    %   Class:
    %   mendeley.api.pvt_response.doc_library
    %
    %   The library object specifies which entries the user has in their
    %   library. 
    %
    %   EXAMPLE:
    %   ===============================================================
    %      total_results: 2865
    %    total_pages: 144
    %   current_page: 0
    % items_per_page: 20
    %   document_ids: {1x20 cell}
    %      documents: {1x20 cell}
    %
    %   See Also:
    %   mendeley.api.private_service.doc_libraryAll
    
    properties
       total_results    %numeric
       total_pages      %numeric
       current_page     %numeric
       items_per_page   %numeric
       doc_ids          %string
       doc_versions     %numeric, time of last update (I believe)
    end
    
    methods
        function obj = doc_library(raw)
           obj.total_results  = raw.total_results;
           obj.total_pages    = raw.total_pages;
           obj.current_page   = raw.current_page;
           obj.items_per_page = raw.items_per_page;
           
           %TODO: Check this, might be slow ...
           temp = [raw.documents{:}];
           
           obj.doc_ids      = {temp.id};
           obj.doc_versions = sl.datetime.unixToMatlab([temp.version]); 
        end
        function sort(obj)
           [obj.doc_versions,I] = sort(obj.doc_versions);
           obj.doc_ids = obj.doc_ids(I);
        end
    end
    
end

