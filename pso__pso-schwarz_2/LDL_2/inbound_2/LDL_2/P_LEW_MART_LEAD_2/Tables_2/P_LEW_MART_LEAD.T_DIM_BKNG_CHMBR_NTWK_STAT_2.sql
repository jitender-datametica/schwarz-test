CREATE TABLE p_lew_mart_lead.t_dim_bkng_chmbr_ntwk_stat_2 (
	client_id NUMBER(38,0) NOT NULL,
	loc_sid_store NUMBER(38,0) NOT NULL,
	oven_id NUMBER(38,0),
	oven_brand VARCHAR(20) COLLATE 'en-ci',
	dwh_valid_from DATE NOT NULL,
	dwh_valid_to DATE,
	connected_fg NUMBER(38,0)
)
;