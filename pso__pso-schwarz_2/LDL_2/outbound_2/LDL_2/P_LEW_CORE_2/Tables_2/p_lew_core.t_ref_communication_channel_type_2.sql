CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_communication_channel_type_2 (
comm_channel_type_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Communication_2 Channel Type Code'),
comm_channel_type_descr STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Communication_2 Channel Type Description'),
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);