CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagerbew_1 AS SELECT mandant_id,
 lagerbew_beleg_id,
 kj,
 vorgangsart_id,
 dat_buch,
 beleg_user_name,
 ref_lagerbew_beleg_id,
 dat_beleg,
 dat_erfasst,
 belegart_id,
 belegkopftext,
 waren_begl_schein_id,
 system_id,
 ref_lagerbew_beleg_id_num,
 lief_gp_id,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_erfasst AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_erfasst,
 transaktion_code
FROM kfl_production_dbp_data.lagerbew_1;