CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wup_wotag_zu_per_2 (mandant_id, wup_id, nb_id, wtag_id, umsatz_prz
, dat_von, dat_bis) AS SELECT mandant_id,
 wup_id,
 nb_id,
 wtag_id,
 umsatz_prz,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_wup_wotag_zu_per_2
WHERE mandant_id = 1;