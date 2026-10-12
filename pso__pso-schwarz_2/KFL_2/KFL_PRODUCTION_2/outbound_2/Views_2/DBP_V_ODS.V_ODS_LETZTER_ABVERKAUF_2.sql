CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_letzter_abverkauf_2 AS SELECT kl_art_id,
 mandant_id,
 wup_id,
 datzeit,
 dat,
 td_insert,
 td_update
FROM kfl_production_dbp_ods.ods_letzter_abverkauf_2;