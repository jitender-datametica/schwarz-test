CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_stueckliste AS SELECT STKO.mandant_id,
 STKO.stueckliste_id,
 STKO.dat_von,
 STKO.dat_bis,
 STKO.art_id AS art_id_kopf,
 STKO.stueckliste_verwendung_id,
 STPO.stueckliste_pos_id,
 STPO.dat_von AS dat_von_pos,
 STPO.dat_bis AS dat_bis_pos,
 STPO.art_id AS art_id_komponente,
 STPO.stueckliste_typ_id,
 STPO.komponentenmenge,
 STPO.komponentenmenge_einh_id
FROM kfl_production_dbp_view.v_stueckliste AS STKO
 INNER JOIN kfl_production_dbp_view.v_stueckliste_det AS STPO ON STKO.mandant_id = STPO.mandant_id AND STKO.stueckliste_id
    = STPO.stueckliste_id
WHERE STKO.dat_bis = DATE '9999-12-31'
 AND STPO.dat_bis = DATE '9999-12-31';