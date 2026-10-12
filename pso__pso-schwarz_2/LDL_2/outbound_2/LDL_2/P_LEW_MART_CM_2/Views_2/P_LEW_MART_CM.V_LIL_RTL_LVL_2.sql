CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_rtl_lvl_2 (rtl_lvl, rtl_lvl_desc, rtl_tp_id) AS SELECT CAST(RLT.rtl_lvl AS BIGNUMERIC)
 AS rtl_lvl,
 CAST(LVL.rtl_lvl_desc AS STRING) AS rtl_lvl_desc,
 CAST(RLT.rtl_tp_id AS BIGNUMERIC) AS rtl_tp_id
FROM ldl_p_lew_process_mstr_ac.v_lil_rtl_lvl_tp_2 AS RLT
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_retailer_level_2 AS LVL ON RLT.rtl_lvl = LVL.rtl_lvl;