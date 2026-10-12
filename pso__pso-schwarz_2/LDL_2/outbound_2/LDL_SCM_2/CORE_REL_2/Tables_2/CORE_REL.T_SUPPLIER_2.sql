CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_supplier_2 (
client_id BIGNUMERIC(38,0),
country_cd STRING(160),
supplier_id BIGNUMERIC(38,0),
supplier_id_int STRING(100),
orig_supplier_nr STRING(20),
supplier_name STRING(100),
dwh_updated_tmsp DATETIME,
dwh_created_tmsp DATETIME
);