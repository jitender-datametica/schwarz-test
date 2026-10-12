CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lief_plantour_arbeitsvorrat_2 AS SELECT mandant_id,
 lief_beleg_id,
 av_herkunft_id,
 wup_id,
 nb_id,
 plantour_id,
 vp_fg,
 stp_faktor_tour,
 anz_stp,
 dat_aenderung,
 dat_lief_soll
FROM kfl_production_dbp_data.lief_plantour_arbeitsvorrat_2;