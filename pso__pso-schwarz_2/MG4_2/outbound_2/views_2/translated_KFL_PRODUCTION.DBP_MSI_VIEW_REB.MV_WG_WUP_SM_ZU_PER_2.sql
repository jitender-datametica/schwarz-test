CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_wg_wup_sm_zu_per_2 (mandant_id, wup_id, wg_id, nb_id, dat_von,
arthiertyp_id, dat_bis, sm_id) AS SELECT mandant_id,
 wup_id,
 wg_id,
 nb_id,
 dat_von,
 arthiertyp_id,
 dat_bis,
 sm_id
FROM kfl_production_dbp_view.v_sm_wup_wg_zu_per_2
WHERE mandant_id = 1
 AND arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31'
 AND nb_id <> 99;