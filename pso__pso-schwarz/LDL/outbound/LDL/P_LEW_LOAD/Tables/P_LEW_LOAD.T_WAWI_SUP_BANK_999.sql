CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_sup_bank_999 (
client_id BIGNUMERIC(38) NOT NULL,
sup_sid BIGNUMERIC(38) NOT NULL,
bank_id BIGNUMERIC(38),
account_nr STRING(20) COLLATE 'und:ci',
dat_rec_end DATE,
dat_rec_start DATE,
iban STRING(35) COLLATE 'und:ci',
charge_key_cd STRING(5) COLLATE 'und:ci',
check_key_cd STRING(5) COLLATE 'und:ci',
alt_payee STRING(10) COLLATE 'und:ci',
block_payment_fg BIGNUMERIC(38),
avis_fax STRING(50) COLLATE 'und:ci',
avis_email STRING(245) COLLATE 'und:ci',
load_id BIGNUMERIC(38) NOT NULL
);