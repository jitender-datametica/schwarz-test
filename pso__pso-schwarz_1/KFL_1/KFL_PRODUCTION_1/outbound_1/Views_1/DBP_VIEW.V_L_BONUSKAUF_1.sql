CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bonuskauf_1 AS SELECT mandant_id,
 bonuskauf_id,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_von AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_von,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_bis AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000'
    ))) AS zeit_bis,
 konditionsart_id,
 geschaeftsvorfall_id,
 dat_von,
 dat_bis,
 aktion_id
FROM kfl_production_dbp_data.l_bonuskauf_1;