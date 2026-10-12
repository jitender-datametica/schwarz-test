CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_backzeit_2 AS SELECT ofen_typ_id,
 back_programm_id,
 gp_backen_bez,
 mandant_id,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(back_dauer AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS back_dauer
FROM kfl_production_dbp_data.l_backzeit_2;