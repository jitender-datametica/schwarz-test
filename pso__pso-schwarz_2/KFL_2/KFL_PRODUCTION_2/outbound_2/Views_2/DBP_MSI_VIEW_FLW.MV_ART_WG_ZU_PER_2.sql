CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_art_wg_zu_per_2 (art_id, in_art_id, flw_art_id, mandant_id,
arthiertyp_id, wug_id, wg_id, dat_von, dat_bis) AS SELECT V01.art_id,
 V03.flw_art_id AS in_art_id,
 V03.flw_art_id,
 V01.mandant_id,
 V01.arthiertyp_id,
 V01.wug_id,
 V01.wg_id,
 V01.dat_von,
 V01.dat_bis
FROM kfl_production_dbp_view.v_art_wg_zu_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art_2 AS V03 ON V02.art_id = V03.art_id AND V02.mandant_id = V03.mandant_id
   
WHERE V01.arthiertyp_id = 2
 AND V01.mandant_id IN (1, 2)
 AND V02.dat_bis = DATE '9999-12-31'
 AND V01.dat_bis = DATE '9999-12-31';