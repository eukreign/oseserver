use `osewiki`;

-- user_password='a-very-long-password'
update wiki_user set user_password=0x3A70626B6466323A7368613235363A31303030303A3132383A4B6157483450435645763634714B434754384D4B63773D3D3A6F48624F777337675452775039486571666F4E574963682B643358666E447866645A5276774732546E4C457837613642484C564D72356349772F476469324865504C4D364261514D5538745853706339736932495A6D2B474A785650496166614F333148763365546476646B6C726A487879334B74773169614C5673316C47674A42763149726F31552B33682B576535784A6D4C34326C6A6F4E364D74556161594F7275484368564966453D;
update wiki_user set user_password_expires=null;
update wiki_user set user_newpass_time=null;
update wiki_user set user_newpassword='';
update wiki_user set user_email='hidden@ose.localhost';
update wiki_user set user_token='';
update wiki_user set user_email_token=null;
update wiki_user set user_email_token_expires=null;
update wiki_user set user_email_authenticated=null;
delete from wiki_user_openid; -- openid URLs
delete from wiki_user_properties; -- has some personal info/settings

-- includes session data, definitely should not be public
delete from wiki_objectcache;

-- tables from the registration approvals extension, too much personal info
delete from wiki_account_credentials;
delete from wiki_account_requests;

-- which pages people are watching, probably not needed
delete from wiki_watchlist;

-- do ipblocks need to be public? probably not
delete from wiki_ipblocks;

-- probably not needed, delete to reduce dump size
delete from wiki_log_search;
delete from wiki_logging;
