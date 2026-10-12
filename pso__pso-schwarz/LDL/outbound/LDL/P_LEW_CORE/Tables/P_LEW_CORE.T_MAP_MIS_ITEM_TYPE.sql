CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_mis_item_type (
client_id BIGNUMERIC(38,0) NOT NULL,
brand_type_mark STRING(20) NOT NULL,
brand_type_label STRING(100) COLLATE 'und:ci',
list_type_mark STRING(20) NOT NULL,
list_type_label STRING(100) COLLATE 'und:ci',
mis_buying_list_type_id BIGNUMERIC(38,0),
mis_buying_list_type_descr STRING(300) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, brand_type_mark, list_type_mark) NOT ENFORCED
) CLUSTER BY client_id;