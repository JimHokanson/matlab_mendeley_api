classdef doc < sl.obj.handle_light
    %
    %
    %   STATUS:
    %   ====================================================
    %   This class has not really been started
    %
    %   Class:
    %   mendeley.doc
    
    %dateAccessed ????
    %
    
    %Ignored:
    %---------------------------------------------
    %discipline
    %subdiscipline
    
    
    properties
       raw_json 
        
       is_read
       is_starred
       is_author
       
       tags
       notes
       
       mendeley_url
       canonical_id
       files
       folder_ids
       
       %unixTimeToMatlabTime
       added
       modified
       version
       
    end
    
    methods (Static)
        function obj = createFromURLresponse(oauth_url_response)
            %
            %
            %    mendeley.doc.createFromJSON 
            
            %TODO: We'll update this eventually ...
            obj = oauth_url_response;
        end
    end
 
%                   abstract: [1x2047 char]
%                authors: {[1x1 struct]  [1x1 struct]  [1x1 struct]  [1x1 struct]}
%                   cast: {0x1 cell}
%           dateAccessed: '11/10/11'
%                    day: '16'
%                    doi: '10.1088/1741-2560/8/5/056009'
%        deletionPending: '0'
%                editors: {0x1 cell}
%                   issn: '1741-2552'
%                  issue: '5'
%                 isRead: '1'
%              isStarred: '0'
%               isAuthor: '1'
%               keywords: {0x1 cell}
%                  month: '10'
%                  pages: '056009'
%                   pmid: '21844639'
%              producers: {0x1 cell}
%           published_in: 'Journal of neural engineering'
%                   tags: {0x1 cell}
%                  title: [1x130 char]
%            translators: {0x1 cell}
%                 volume: '8'
%                    url: [1x144 char]
%                   year: '2011'
%                     id: '4219256773'
%                   type: 'Journal Article'
%     publication_outlet: 'Journal of neural engineering'
%            identifiers: [1x1 struct]
%           mendeley_url: [1x146 char]
%           canonical_id: 'dddafdc0-cadb-11e0-83ce-0024e8453de6'
%                  files: {[1x1 struct]}
%            folders_ids: {'12712083'  '27462133'}
%               modified: 1.3529e+09
%                version: 1.3529e+09
%                  added: 1.3184e+09
%                  notes: ''
%             discipline: 'Biological Sciences'
%          subdiscipline: 'Neurobiology'
    
end

