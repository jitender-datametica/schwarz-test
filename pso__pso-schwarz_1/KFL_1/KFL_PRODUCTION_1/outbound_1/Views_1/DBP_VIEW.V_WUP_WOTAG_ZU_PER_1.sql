CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_wotag_zu_per_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 wtag_id,
 umsatz_prz,
 dat_von,
 dat_bis
FROM kfl_production_dbp_data.wup_wotag_zu_per_1;