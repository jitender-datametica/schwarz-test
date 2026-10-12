CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vaus_wup_oeffnung_zu_per_2 AS SELECT mandant_id,
 wup_id,
 wup_oeffnungs_typ_id,
 dat_von,
 dat_bis,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_von AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_von,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_bis AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000'
    ))) AS zeit_bis
FROM kfl_production_dbp_data.vaus_wup_oeffnung_zu_per_2;