CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_client_country_2 (client_id, country_id, load_id) AS SELECT client_id
 ,
 country_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_client_country_2;