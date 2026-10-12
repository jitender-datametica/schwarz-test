CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kunde_auftrag_einteil AS SELECT mandant_id,
 verkaufs_beleg_id,
 verkaufs_beleg_pos_id,
 einteil_id,
 system_id,
 dat_einteilung,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_einteilung AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_einteilung
FROM kfl_production_dbp_data.flw_kunde_auftrag_einteil;