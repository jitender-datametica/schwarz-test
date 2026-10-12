CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lieferndeswerk_1 (lieferndeswerk, lieferndeswerk_nb_id, mandant_id
, dat_von, wup_typ_id, wup_standort, dat_bis, verkaufsorganisation_id) AS SELECT wup_id AS lieferndeswerk,
 nb_id AS lieferndeswerk_nb_id,
 mandant_id,
 dat_von,
 wup_typ_id,
 wup_standort,
 dat_bis,
 verkaufsorganisation_id
FROM kfl_production_dbp_view.v_wup_1
WHERE nb_id = - 111;