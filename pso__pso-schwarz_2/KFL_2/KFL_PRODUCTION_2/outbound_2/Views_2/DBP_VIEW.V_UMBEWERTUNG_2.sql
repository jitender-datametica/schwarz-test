CREATE OR REPLACE VIEW kfl_production_dbp_view.v_umbewertung_2 AS SELECT mandant_id,
 pae_beleg_id,
 kj,
 dat_beleg,
 dat_erfasst,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_erfasst AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_erfasst,
 beleg_user_name
FROM kfl_production_dbp_data.umbewertung_2;