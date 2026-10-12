CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_ref_paymenttype (
paymenttype_id BIGNUMERIC(38,0) NOT NULL,
cnt_payment_ejr NUMERIC(18,4),
paymenttype_desc STRING(100) COLLATE 'und:ci' NOT NULL,
paymenttype_short_desc STRING(35) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0)
);