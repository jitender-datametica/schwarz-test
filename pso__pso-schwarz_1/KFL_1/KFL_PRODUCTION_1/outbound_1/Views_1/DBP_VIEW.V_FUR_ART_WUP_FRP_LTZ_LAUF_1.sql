CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fur_art_wup_frp_ltz_lauf_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 standardabweichung,
 klassifikationsmittelwert,
 drehklasse_kz,
 td_update,
 td_insert
FROM kfl_production_dbp_data.fur_art_wup_frp_ltz_lauf_1;