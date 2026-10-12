CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_unit_of_measurement (client_id, uom_sid, src_msehi, uom_sid_family, uom_name
, uom_iso_cd, uom_cd_family, numerator_conv_si, denominator_conv_si, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 uom_sid,
 src_msehi,
 uom_sid_family,
 uom_name,
 uom_iso_cd,
 uom_cd_family,
 numerator_conv_si,
 denominator_conv_si,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_unit_of_measurement;