CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_etl_process_dwh_wg_erfass_artikel_2 (art_id, mandant_id, wg_id,
arthiertyp_id, td_update, td_insert) AS SELECT art_id,
 mandant_id,
 wg_id,
 arthiertyp_id,
 td_update,
 td_insert
FROM kfl_production_dbp_etl_process.dwh_wg_erfass_artikel_2;