CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_bsch_bestvor_det_2 (best_vor_nr, mandant_id, wup_id, nb_id,
best_vor_pos, dat_plan, art_id, gp_id, menge_best_vor, menge_best, status_2, best_vor_einh, best_einh, dispomerkmal) AS
SELECT V02.best_vor_nr,
 V02.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 V02.nb_id,
 V02.best_vor_pos,
 V02.dat_plan,
 V02.art_id,
 V02.gp_id,
 V02.menge_best_vor,
 V02.menge_best,
 V02.status_2,
 V02.best_vor_einh,
 V02.best_einh,
 V03.dispomerkmal
FROM kfl_production_dbp_data.bsch_bestvor_det_2 AS V02
 INNER JOIN kfl_production_dbp_data.art_wup_status_per_2 AS V03 ON V02.art_id = V03.art_id AND V02.wup_id = V03.wup_id AND
     V02.mandant_id = V03.mandant_id AND V02.nb_id = V03.nb_id AND V02.dat_plan BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V02.mandant_id = WUP.mandant_id AND V02.wup_id = WUP.wup_id
WHERE (V02.menge_best <> 0 OR V02.status_2 <> '0B')
 AND (V02.mandant_id = 1 AND V03.dispomerkmal IN ('10', '11', '12', '14') AND V03.kdis = 0 OR V02.mandant_id <> 1 AND
     V03.dispomerkmal IN ('10', 'S2', '14'))
 AND V02.nb_id IN (- 1, 0);