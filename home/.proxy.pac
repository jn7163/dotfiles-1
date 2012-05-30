function FindProxyForURL(url, host){
var NoProxy = "DIRECT";
var GoProxy = "PROXY 127.0.0.1:8087";

var WHITELIST = new Array(
".ip138.com",
".google.com",
".googlemail.com",
".gstatic.com",
".googleusercontent.com",
".googleapis.com",
".blogspot.com",
".blogger.com",
".appspot.com",
".twimg.com",
".youtube.com",
".ytimg.com",
".facebook.com",
".fbcdn.net",
"s-ssl.wordpress.com",
".wp.com",
".wordpress.com",
"friendfeed.com",
"twitter.com",
".8535.org",
".5i01.com",
".opera.com",
".archlinux.org",
".gravatar.com",
".chinagfw.org");

for (i in WHITELIST) {
	if(shExpMatch(url.toLowerCase(),"*" + WHITELIST[i].toLowerCase() + "*")){return GoProxy;};
	};

return "DIRECT";
};
