function str = urlread_net(url)

%Testing code ...

h1 = System.Net.WebRequest.CreateHttp(url);

%http://msdn.microsoft.com/en-us/library/system.net.httpwebresponse.aspx
h2 = h1.GetResponse;

h3 = h2.GetResponseStream;

%Encoding enc = System.Text.Encoding.GetEncoding(1252);

%h = System.Net.HttpWebRequest(h1);


wtf = System.IO.StreamReader(h3); %Optional encoding ...

str = char(wtf.ReadToEnd);

wtf.Close()
h2.Close()

end