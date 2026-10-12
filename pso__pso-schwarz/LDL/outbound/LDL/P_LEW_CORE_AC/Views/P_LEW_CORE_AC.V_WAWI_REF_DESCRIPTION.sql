CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_description (client_id, description_id, code, description,
buyer_link, read_only, desc_type, language_id, dat_dayend, load_id) AS SELECT client_id,
 description_id,
 code,
 description,
 buyer_link,
 read_only,
 desc_type,
 language_id,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_description;