CREATE OR REPLACE VIEW kfl_production_dbp_view.v_banf_det_2 AS SELECT mandant_id,
 banf_beleg_id,
 banf_beleg_pos_id,
 art_id,
 wup_id,
 nb_id,
 banf_menge,
 banf_menge_einh_id,
 dat_banf_beleg,
 dat_lief_soll,
 dat_freigabe,
 banf_preis
FROM kfl_production_dbp_data.banf_det_2;