CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_unit_of_measurement_descr_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
uom_sid BIGNUMERIC(38,0) NOT NULL,
lang_sid BIGNUMERIC(38,0) NOT NULL,
uom_cd STRING(20),
lang_cd STRING(20),
uom_descr_short STRING(100) COLLATE 'und:ci',
uom_descr_long STRING(300) COLLATE 'und:ci',
uom_descr_ext_3ch STRING(100) COLLATE 'und:ci',
uom_descr_ext_6ch STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (uom_sid, lang_sid) NOT ENFORCED
) CLUSTER BY client_id;