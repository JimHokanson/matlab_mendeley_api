function [access_token,secret] = getAccessToken(consumer_key,consumer_secret)
%
%
%   [access_token,secret] = mendeley.api.getAccessToken(consumer_key,consumer_secret)


REQUEST_URL = 'http://api.mendeley.com/oauth/request_token/';
ACCESS_URL  = 'http://api.mendeley.com/oauth/access_token/';
AUTH_URL_BASE    = 'http://api.mendeley.com/oauth/authorize/';


%Get request token
%------------------------------------------------------------
a = oauth.creds.request(consumer_key,consumer_secret);
r = oauth.getRequestToken(a,REQUEST_URL);
r.checkStatus(200);
r2 = r.response;


%Retrieve user authorization of client
%-----------------------------------------------------------------
auth_url = oauth.getAuthorizationURL(AUTH_URL_BASE,r2.oauth_token);
v = getVerifier(auth_url);


%Retrieve access token
%-------------------------------------------------------------------
a = oauth.creds.access(consumer_key,consumer_secret,r2.oauth_token,r2.oauth_token_secret);

r = oauth.getAccessToken(a,ACCESS_URL,v);

r.checkStatus(200);

r2 = r.response;

access_token = r2.oauth_token;
secret       = r2.oauth_token_secret;

end

function v = getVerifier(auth_url)
%
%
%

%GUI NOTES
%==========================================================================
%TAGS
%=============================================
%s_url      
%b_copy
%b_cancel
%b_ok
%e_verify

%DATA
%=============================================
%auth_url
%is_ok
%verifier

fig_path = fullfile(sl.dir.getMyBasePath,'getAccessTokenGUI.fig');
g = sl.gui.simple_prompt(fig_path,{'auth_url' auth_url 'is_ok' false 'verifier' ''});

set(g.h.s_url,'String',auth_url);

g.setCallback('b_copy','Callback',@copy_to_clipboard)
g.setCallback('b_cancel','Callback',@cancel)
g.setCallback('b_ok','Callback',@ok)
g.data.setGetMethodSimple('verifier','e_verify','String');

g.runGUI;

d = g.data;

if ~d.is_ok
   error('GUI canceled or closed')
end

v = strtrim(d.verifier);

if isempty(v)
    error('Verifier must be specified')
end
end


function copy_to_clipboard(obj)
clipboard('copy',obj.data.auth_url);
end

function cancel(obj)
obj.finish();
end

function ok(obj)
obj.data.is_ok = true;
%Add verifier empty check ...
obj.finish();
end