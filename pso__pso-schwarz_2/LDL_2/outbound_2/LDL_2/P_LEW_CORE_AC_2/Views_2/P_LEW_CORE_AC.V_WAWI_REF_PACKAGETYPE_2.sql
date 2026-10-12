CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_packagetype_2 (client_id, packagetype_desc, packagetype_desc_int_short
, language_id, load_id) AS SELECT client_id,
 packagetype_desc,
 packagetype_desc_int_short,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_packagetype_2;