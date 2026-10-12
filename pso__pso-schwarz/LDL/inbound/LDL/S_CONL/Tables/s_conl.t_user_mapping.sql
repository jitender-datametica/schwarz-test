CREATE TABLE s_conl.t_user_mapping (
user_name VARCHAR(100) COLLATE 'en-ci',
client_id INTEGER,
UNIQUE ( user_name, client_id)
);


