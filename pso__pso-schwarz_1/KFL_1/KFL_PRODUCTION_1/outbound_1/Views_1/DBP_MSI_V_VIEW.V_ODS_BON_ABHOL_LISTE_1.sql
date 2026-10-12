CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ods_bon_abhol_liste_1 AS SELECT bon_id,
 mandant_id,
 wup_id,
 zeitstempel_druck
FROM kfl_production_dbp_msi_data.ods_bon_abhol_liste_1;