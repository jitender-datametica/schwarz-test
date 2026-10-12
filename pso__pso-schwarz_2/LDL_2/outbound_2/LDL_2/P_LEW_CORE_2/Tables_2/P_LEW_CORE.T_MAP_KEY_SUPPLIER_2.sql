CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_key_supplier_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0) NOT NULL,
dwh_sup_id STRING(20) COLLATE 'und:ci',
dwh_orig_supplier_nr BIGNUMERIC(38,0),
elwis_dwh_ec_cd BIGNUMERIC(38,0),
elwis_dwh_sup_sid BIGNUMERIC(38,0),
elwis_dwh_sup_id STRING(20) COLLATE 'und:ci',
wawi_dwh_client_id BIGNUMERIC(38,0),
wawi_dwh_supplier_id BIGNUMERIC(38,0),
wawi_dwh_orig_supplier_nr BIGNUMERIC(38,0),
active_fg BIGNUMERIC(38,0),
source_system STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (sup_sid) NOT ENFORCED
) CLUSTER BY client_id;