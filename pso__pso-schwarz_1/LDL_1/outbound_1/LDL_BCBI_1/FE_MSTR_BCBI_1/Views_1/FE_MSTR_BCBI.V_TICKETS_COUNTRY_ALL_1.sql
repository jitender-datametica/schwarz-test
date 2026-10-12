CREATE OR REPLACE VIEW ldl_bcbi_fe_mstr_bcbi.v_tickets_country_all_1 AS SELECT v_tickets_country.country_ticket_id,
 t_country.client_id,
 t_country.country_iso,
 t_country.country_name,
 t_country.country_cluster_id,
 t_country.country_cluster_name,
 v_tickets_country.opened_by_group,
 v_tickets_country.country_flag_img,
 v_tickets_country.country_flag_img_name
FROM ldl_bcbi_fe_mstr_bcbi.v_tickets_country_1
 LEFT JOIN ldl_bcbi_fe_mstr_bcbi.t_country_1 ON v_tickets_country.country_name = t_country.country_name;