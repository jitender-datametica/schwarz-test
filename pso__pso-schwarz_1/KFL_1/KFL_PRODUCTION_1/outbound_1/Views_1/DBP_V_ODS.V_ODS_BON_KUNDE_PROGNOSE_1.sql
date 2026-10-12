CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_kunde_prognose_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat,
 zeit_stunde,
 zeit_minute,
 anz_kunden,
 anz_kunden_prognose,
 anz_kunden_prognose_dyn,
 anz_kassen_offen,
 anz_kassen_prognose,
 anz_kassen_prognose_dyn,
 datzeit_update
FROM kfl_production_dbp_ods.ods_bon_kunde_prognose_1;