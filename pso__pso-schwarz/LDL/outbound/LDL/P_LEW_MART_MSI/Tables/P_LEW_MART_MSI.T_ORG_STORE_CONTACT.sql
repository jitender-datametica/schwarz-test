CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_org_store_contact (
client_id BIGNUMERIC(38,0),
store_id BIGNUMERIC(38,0),
zipcode STRING(20),
city STRING(100) COLLATE 'und:ci',
street STRING(100) COLLATE 'und:ci',
postbox STRING(100) COLLATE 'und:ci',
phone STRING(100) COLLATE 'und:ci',
fax STRING(100) COLLATE 'und:ci',
zipcode_postbox STRING(15) COLLATE 'und:ci',
modem STRING(50) COLLATE 'und:ci'
);