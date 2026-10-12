CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_ref_paymenttype (paymenttype_id, cnt_payment_ejr, paymenttype_desc,
paymenttype_short_desc, language_id) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_ref_paymenttype;