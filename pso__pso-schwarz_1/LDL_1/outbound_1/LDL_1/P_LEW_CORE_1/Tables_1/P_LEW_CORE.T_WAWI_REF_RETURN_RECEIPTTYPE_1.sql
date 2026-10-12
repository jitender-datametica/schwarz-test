CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_return_receipttype_1 (
return_receipttype_id BIGNUMERIC(38,0),
return_receipttype_desc STRING(100) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);