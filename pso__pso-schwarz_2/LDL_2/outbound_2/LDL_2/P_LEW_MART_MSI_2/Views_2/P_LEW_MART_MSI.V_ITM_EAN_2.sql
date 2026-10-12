CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_ean_2 AS SELECT EAN0.client_id,
 EAN0.item_sid AS item_id,
 EAN0.ean_2,
 EAN0.ean_item_desc,
 EAN0.language_id
FROM ldl_p_lew_core_ac.v_wawi_itm_ean_2 AS EAN0
 INNER JOIN ldl_p_lew_mart_msi.v_ref_user_language_2 AS LG ON LOWER(SESSION_USER()) = LOWER(LG.db_user) AND EAN0.language_id
    = LG.language_id
WHERE CURRENT_DATE BETWEEN EAN0.dat_rec_start AND EAN0.dat_rec_end;