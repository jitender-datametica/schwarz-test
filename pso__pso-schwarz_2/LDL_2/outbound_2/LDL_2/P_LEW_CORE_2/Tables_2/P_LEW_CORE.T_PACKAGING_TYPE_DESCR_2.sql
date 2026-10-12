CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_packaging_type_descr_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
pack_type_sid BIGNUMERIC(38,0) NOT NULL,
lang_sid BIGNUMERIC(38,0) NOT NULL,
lang_cd STRING(20),
pack_type_descr STRING(300) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (pack_type_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id;