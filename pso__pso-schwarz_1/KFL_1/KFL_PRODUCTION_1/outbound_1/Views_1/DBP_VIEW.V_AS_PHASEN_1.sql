CREATE OR REPLACE VIEW kfl_production_dbp_view.v_as_phasen_1 AS SELECT mandant_id,
 wg_id,
 posten_kz_sap,
 wtag_phasenbeginn
FROM kfl_production_dbp_data.as_phasen_1;