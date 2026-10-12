CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_mis_move_type (
client_id BIGNUMERIC(38,0) NOT NULL,
move_type_cd STRING(20) NOT NULL,
move_type_descr STRING(300) COLLATE 'und:ci',
move_reason_cd STRING(20) NOT NULL,
wh_store_mark STRING(20) NOT NULL,
wh_store_label STRING(100) COLLATE 'und:ci',
mis_sfo_type_id BIGNUMERIC(38,0) NOT NULL,
mis_sfo_type_descr STRING(300) COLLATE 'und:ci',
map_use_id BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, move_type_cd, move_reason_cd, wh_store_mark) NOT ENFORCED
) CLUSTER BY client_id;