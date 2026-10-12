CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_vk_per AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 wrg_id,
 vk_brutto,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_wup_vk_per;