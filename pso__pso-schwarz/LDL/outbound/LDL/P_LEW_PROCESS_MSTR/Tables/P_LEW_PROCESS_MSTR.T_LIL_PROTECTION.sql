CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_protection (
prot_fg BIGNUMERIC(38,0) NOT NULL,
description STRING(800),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created TIMESTAMP NOT NULL,
dwh_updated TIMESTAMP NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);