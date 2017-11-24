INSERT INTO oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove) VALUES
('implicitclient', 'marketplace', '$2a$10$mWAbi9UrOGaYK8mWNexZ7OfNM8BBaoO.eLGAn/PYnRyXdm/HHt8AW', 'demo', 'password', 'http://example.com', 'APLIKASI_CLIENT_OAUTH2', 1800, 18000, '{}', 'demo');

-- secret : userpassword001
INSERT INTO oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove) VALUES
('userpassword', 'marketplace', '$2a$10$Ooz4dGCLqrjyDViXrsCWEuvdsUSw6KyWN6Z5RvwXAr.Sujkhx3ouG', 'demo', 'password', 'http://example.com', 'APLIKASI_CLIENT_OAUTH2', 1800, 18000, '{}', 'demo');

-- secret : authcode321
INSERT INTO oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove) VALUES
('authcodeclient', 'marketplace', '$2a$10$RF2g3Q299hwYKT2fHqa7sORgi86FK5fdVtLSr7Ult9arTSfhcLf6O', 'demo', 'authorization_code,refresh_token', 'http://example.com', 'APLIKASI_CLIENT_OAUTH2', 300, 3000, '{}', '');

-- secret : clientapp999
INSERT INTO oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove) VALUES
('clientapp', 'marketplace', '$2a$10$tHHn7lRIEEIj4S/cdo8IjukTgKImCUlZceNOeyxqCr51sITqr3AYG', 'demo', 'client_credentials', 'http://example.com', 'APLIKASI_CLIENT_OAUTH2', NULL, NULL, '{}', 'demo');
