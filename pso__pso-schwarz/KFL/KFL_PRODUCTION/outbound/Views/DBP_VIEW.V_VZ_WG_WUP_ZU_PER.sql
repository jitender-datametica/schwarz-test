CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vz_wg_wup_zu_per AS SELECT mandant_id,
 arthiertyp_id,
 wg_hierarchie_ebene_id,
 wg_hierarchie_id,
 wup_id,
 nb_id,
 vz_wup_id,
 dat_von,
 dat_bis,
 vz_prio_id,
 kreistyp_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.vz_wg_wup_zu_per;