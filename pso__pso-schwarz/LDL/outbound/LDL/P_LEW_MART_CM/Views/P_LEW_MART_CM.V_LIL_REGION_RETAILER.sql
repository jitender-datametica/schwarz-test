CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_region_retailer (client_id, rtl_id, region_rtl_desc, region_rtl_desc_en,
rtl_lvl) AS SELECT REG.region_id AS client_id,
 RTL.rtl_id,
 RTL.region_rtl_desc_de AS region_rtl_desc,
 RTL.region_rtl_desc_en,
 RTL.rtl_lvl
FROM ldl_p_lew_process_mstr_ac.v_lil_region_retailer AS RTL
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_region AS REG ON RTL.region_sid = REG.region_sid;