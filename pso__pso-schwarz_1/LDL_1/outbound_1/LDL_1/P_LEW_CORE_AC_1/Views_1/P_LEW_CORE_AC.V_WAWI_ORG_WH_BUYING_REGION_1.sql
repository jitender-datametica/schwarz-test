CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_org_wh_buying_region_1 (client_id, aspect_id, wh_loc_sid, buying_region,
region_sequence, language_id, load_id) AS SELECT client_id,
 aspect_id,
 wh_loc_sid,
 buying_region,
 region_sequence,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_org_wh_buying_region_1;