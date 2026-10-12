CREATE TABLE p_lew_mart_msi.t_msi_ejr_correlation (
	st_loc_sid NUMBER(38,0),
	client_id NUMBER(38,0),
	pos_terminal_id NUMBER(38,0),
	dat_formdate DATE,
	TIME_RECEIPT_EJR TIME(0),
	orig_receipt_nr_ejr NUMBER(38,0),
	checker_id NUMBER(38,0),
	authority_id VARCHAR(40) COLLATE 'en-ci',
	scenario_id VARCHAR(30) COLLATE 'en-ci',
	auth_type VARCHAR(40) COLLATE 'en-ci',
	val_authorised_retail_ejr NUMBER(18,4),
	cnt_authorised_receipt NUMBER(38,0)
)
;