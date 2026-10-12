CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_rpt_liam_avlbl_cats_nw (client_id, liam_clnt_cat_id,
liam_chld_cat_desc, liam_chld_cat_desc_en, liam_clnt_parnt_cat_id, liam_parnt_cat_desc, liam_parnt_cat_desc_en, prom_id
, per_id, per_text, per_text_en, valid_data_flg, valid_data_flg_cd, exp_delivered_nopromo, exp_delivered_promo,
exp_total_uwg, exp_promo_uwg, bnc_prom_total, bnc_prom_brand_pl, exp_delivered_nopromo_uwg, exp_delivered_promo_uwg,
exp_delivered, expected_uwg, data_expected, exp_delivered_uwg, delivered_uwg) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_rpt_liam_avlbl_cats_nw;