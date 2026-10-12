CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_lief_einteilung_1 AS SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 einteil_id,
 charge_id,
 dat_lief_wunsch,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_lief_wunsch AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_lief_wunsch,
 datzeit_lief_wunsch,
 system_id,
 datzeit_lief_wunsch_az
FROM kfl_production_dbp_data.flw_lief_einteilung_1;