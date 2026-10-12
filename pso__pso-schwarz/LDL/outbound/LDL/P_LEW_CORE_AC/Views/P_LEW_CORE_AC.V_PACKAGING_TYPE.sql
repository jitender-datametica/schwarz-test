CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_packaging_type (client_id, pack_type_sid, src_zz_pack_type, pack_type_name,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 pack_type_sid,
 src_zz_pack_type,
 pack_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_packaging_type;