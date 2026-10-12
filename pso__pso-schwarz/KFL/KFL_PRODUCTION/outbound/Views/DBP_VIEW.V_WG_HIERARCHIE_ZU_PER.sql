CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wg_hierarchie_zu_per AS SELECT mandant_id,
 arthiertyp_id,
 wg_hierarchie_ebene_id,
 wg_hierarchie_id,
 wg_hierarchie_mutter_id,
 dat_von,
 dat_bis,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wg_hierarchie_zu_per;