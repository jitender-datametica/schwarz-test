CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_rel_partner_client_2 (partner_name, client_id, client_long_desc,
client_long_desc_en) AS SELECT partner_name,
 client_id,
 client_long_desc,
 client_long_desc_en
FROM ldl_p_lew_mart_cm.t_lil_rel_partner_client_2;