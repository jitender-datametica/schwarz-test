CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_channel_type (
channel_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Channel Type Code'),
channel_type_descr STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Channel Type Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);