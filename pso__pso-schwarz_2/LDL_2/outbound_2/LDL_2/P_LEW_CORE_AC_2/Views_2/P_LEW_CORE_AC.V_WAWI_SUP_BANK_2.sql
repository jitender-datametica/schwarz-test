CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_sup_bank_2 (client_id, sup_sid, bank_id, account_nr, dat_rec_end,
dat_rec_start, iban, charge_key_cd, check_key_cd, alt_payee, block_payment_fg, avis_fax, avis_email, load_id) AS SELECT
 client_id,
 sup_sid,
 bank_id,
 account_nr,
 dat_rec_end,
 dat_rec_start,
 iban,
 charge_key_cd,
 check_key_cd,
 alt_payee,
 block_payment_fg,
 avis_fax,
 avis_email,
 load_id
FROM ldl_p_lew_core.t_wawi_sup_bank_2;