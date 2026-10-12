CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_qual_meldung AS SELECT mandant_id,
 qual_meldung_id,
 meldungsart_id,
 flw_lief_id,
 best_beleg_id,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_pforte AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_pforte,
 dat_erfasst,
 system_id
FROM kfl_production_dbp_data.flw_qual_meldung;