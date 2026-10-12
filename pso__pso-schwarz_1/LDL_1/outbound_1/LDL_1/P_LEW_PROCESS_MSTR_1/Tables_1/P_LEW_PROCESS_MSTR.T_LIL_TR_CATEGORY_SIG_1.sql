CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_lil_tr_category_sig_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
sub_item_grp_sid BIGNUMERIC(38,0) NOT NULL,
active_fg BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (sub_item_grp_sid) NOT ENFORCED
) CLUSTER BY client_id;