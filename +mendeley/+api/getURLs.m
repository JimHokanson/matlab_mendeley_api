function urls = getURLs()

REQUEST_URL = 'http://www.mendeley.com/oauth/request_token/';
AUTH_URL    = 'http://www.mendeley.com/oauth/authorize/';
ACCESS_URL  = 'http://www.mendeley.com/oauth/access_token/';

urls = struct('REQUEST_URL',REQUEST_URL,...
    'AUTH_URL',AUTH_URL,...
    'ACCESS_URL',ACCESS_URL);


end