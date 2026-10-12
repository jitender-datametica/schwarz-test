CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_lagerbew_1 AS SELECT mandant_id,
 lagerbew_beleg_id,
 kj,
 vorgangsart_id,
 dat_beleg,
 dat_buch,
 dat_erfasst,
 ref_lagerbew_beleg_id,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_erfasst AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_erfasst,
 belegkopftext,
 system_id
FROM kfl_production_dbp_data.flw_lagerbew_1;