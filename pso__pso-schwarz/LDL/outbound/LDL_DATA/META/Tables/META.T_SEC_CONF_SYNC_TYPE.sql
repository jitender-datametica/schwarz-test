CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_conf_sync_type (
sync_type_cd STRING(20) NOT NULL OPTIONS(description='The type of the synchronisation as revode or grant'),
sync_type_descr STRING(250) NOT NULL OPTIONS(description='The description of  the synchronisation type '),
PRIMARY KEY (sync_type_cd) NOT ENFORCED
) OPTIONS(description='The type of sync, if it is a grant or revoke is');