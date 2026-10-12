CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_org_wh_merge_bges_1 (client_id, wh_id, wh_desc, wh_desc_short) AS
SELECT client_id,
 wh_id,
 wh_desc,
 wh_desc_short
FROM ldl_p_lew_mart_msi_ac.v_org_wh_merge_1
WHERE aspect_id = 1;