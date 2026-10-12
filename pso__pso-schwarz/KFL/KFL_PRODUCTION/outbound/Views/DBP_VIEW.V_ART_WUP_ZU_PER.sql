CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_zu_per AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat_von,
 art_id,
 bezugsweg_id,
 listung_id,
 vk_brutto,
 dat_bis,
 kdis,
 wrg_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.art_wup_zu_per;