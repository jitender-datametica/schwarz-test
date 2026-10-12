
CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_vpe_of_retailers_liam (client_id, per_id, liam_clnt_cat_id,
liam_parnt_clnt_cat_id, valuepotential, vpe, islidl, rtl_id, rnk_id, rnk_desc, max_raw_buyer, rtl_tp_id, currency_iso_cd
) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_vpe_of_retailers_liam;
