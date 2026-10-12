CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_cust_prog_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
customer_sid BIGNUMERIC(38,0) NOT NULL,
prog_sid BIGNUMERIC(38,0) NOT NULL,
registration_tmsp DATETIME NOT NULL,
deregistration_tmsp DATETIME NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id;