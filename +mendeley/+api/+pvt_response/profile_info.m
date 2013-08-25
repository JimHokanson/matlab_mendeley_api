classdef profile_info < mendeley.api.pvt_response
    %
    %   Class:
    %   mendeley.api.pvt_response.profile_info
    %
    %   See:
    %   http://apidocs.mendeley.com/home/user-specific-methods/profile-information
    %
    %   Status:
    %   This object is not fully implemented ...
    %
    %   IMPROVEMENTS
    %   ===================================================================
    %   1) sections awards, cv, and contact are not implemented ...
    %   2) It is not clear when fields will or will not be present ...
    %
    %   NOTES:
    %   ===================================================================
    %   1) The email is not the email associated with the account but is a
    %   "contact" email that the user must specify in their profile ...
    
    %main poperties
    properties
        name
        academic_status
        discipline_name
        bio
        location    %'Pittsburgh, Pennsylvania, United States'
        research_interests %'Sensory Neurobiology and Neural Prosthetics'
        joined
        last_synced
    end
    
    properties (Hidden)
        %Enumerated Values ...
        profile_id          %exposed via .getUniqueID()
        discipline_id
        academic_status_id
        photo_link
    end
    
    methods 
        function value = getUniqueID(obj)
           %I think this is a unique ID ...
           value = obj.profile_id; 
        end
    end
    
    methods
        function o = profile_info(raw)
%        main: [1x1 struct]
%      awards: {0x1 cell}
%          cv: [1x1 struct]
%     contact: [1x1 struct]
    
        m = raw.main;
        o.name            = m.name;
        o.academic_status = m.academic_status;
        o.discipline_name = m.discipline_name;
        o.bio             = m.bio;
        o.location        = m.location;
        o.research_interests = m.research_interests;
        o.joined          = datestr(sl.datetime.unixToMatlab(m.joined),2);
        o.last_synced     = datestr(sl.datetime.unixToMatlab(m.last_synced));
        o.profile_id      = m.profile_id;
        o.discipline_id   = m.discipline_id;
        o.academic_status_id = m.academic_status_id;
        o.photo_link      = m.photo;
        
        %cv
%      consulting: {''}
%     employment: {0x1 cell}
%      education: {[1x1 struct]  [1x1 struct]  [1x1 struct]}
            
           %Contact

        end
    end
    
end

