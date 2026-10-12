CREATE TABLE p_lew_load.t_sec_security_role_l_0
(
change_type VARCHAR(128) COLLATE 'en-ci',
security_role_desc VARCHAR(128) COLLATE 'en-ci',
dashboard_name VARCHAR(128) COLLATE 'en-ci',
authorized BYTEINT DEFAULT NULL ,
change_dat DATE,
load_id INTEGER,
approval_user VARCHAR(128) COLLATE 'en-ci',
entry_user VARCHAR(128) COLLATE 'en-ci');