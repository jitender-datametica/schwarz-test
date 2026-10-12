CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_marc_2 (art_id, dat_bis, dat_von, mandant_id, nb_id, wup_id,
dismm, bwscl, eislo) AS SELECT art_id,
 dat_bis,
 dat_von,
 mandant_id,
 nb_id,
 wup_id,
 dispomerkmal AS dismm,
 bezugsweg_id AS bwscl,
 min_sicherh_bestand AS eislo
FROM kfl_production_dbp_view.v_art_wup_status_per_2 AS V01
WHERE dat_bis = DATE '9999-12-31'
 AND mandant_id <> 1
 AND nb_id <> 99;