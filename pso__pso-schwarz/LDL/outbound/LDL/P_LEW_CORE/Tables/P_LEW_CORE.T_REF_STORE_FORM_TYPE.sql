CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_store_form_type (
client_id BIGNUMERIC(38,0) NOT NULL,
sfo_type_id BIGNUMERIC(38,0) NOT NULL,
sfo_type_descr STRING(100) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id;