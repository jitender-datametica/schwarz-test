CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_ref_till_discount_1 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
discount_sid BIGNUMERIC(38,0) NOT NULL,
PRIMARY KEY (client_id, discount_sid) NOT ENFORCED
);