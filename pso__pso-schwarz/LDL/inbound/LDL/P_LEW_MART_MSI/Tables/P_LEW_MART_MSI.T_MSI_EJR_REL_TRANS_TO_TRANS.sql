CREATE TABLE p_lew_mart_msi.t_msi_ejr_rel_trans_to_trans CLUSTER BY (p_client_id, p_st_loc_sid) (
	c_st_loc_sid NUMBER(38,0),
	c_client_id NUMBER(38,0),
	c_pos_terminal_id NUMBER(38,0),
	c_dat_formdate DATE,
	c_time_receipt_ejr TIME(0),
	c_orig_receipt_nr_ejr NUMBER(38,0),
	c_checker_id NUMBER(38,0),
	c_transaction_type_id VARCHAR(3) COLLATE 'en-ci',
	p_st_loc_sid NUMBER(38,0) NOT NULL,
	p_client_id NUMBER(38,0) NOT NULL,
	p_pos_terminal_id NUMBER(38,0) NOT NULL,
	p_dat_formdate DATE NOT NULL,
	p_time_receipt_ejr TIME(0) NOT NULL,
	p_proof_object_nr_ejr VARCHAR(13) NOT NULL COLLATE 'en-ci',
	p_checker_id NUMBER(38,0) NOT NULL,
	scenario_group_id NUMBER(38,0),
	resumed_trans_seqnr NUMBER(38,0),
	p_val_retail_ejr NUMBER(18,4)
)
;