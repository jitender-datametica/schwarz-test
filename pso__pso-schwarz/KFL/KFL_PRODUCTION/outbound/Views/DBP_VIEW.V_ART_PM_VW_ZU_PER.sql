CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_pm_vw_zu_per AS SELECT art_id,
 pm_id,
 vw_id,
 mandant_id,
 preistyp_id,
 dat_bis,
 wrg_id,
 dat_von,
 vk_brutto
FROM kfl_production_dbp_data.art_pm_vw_zu_per;