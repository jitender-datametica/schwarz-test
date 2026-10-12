CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_advert_week_related_2 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
adv_week_id BIGNUMERIC(38,0) DEFAULT 888853 NOT NULL,
adv_week_rltd_type_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
rltd_adv_week_id BIGNUMERIC(38,0) DEFAULT 888853 NOT NULL,
PRIMARY KEY (client_id, adv_week_id, adv_week_rltd_type_id) NOT ENFORCED
);