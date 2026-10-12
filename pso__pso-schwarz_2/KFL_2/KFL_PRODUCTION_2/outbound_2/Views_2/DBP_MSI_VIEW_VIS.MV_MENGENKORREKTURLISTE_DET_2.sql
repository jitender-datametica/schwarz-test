CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mengenkorrekturliste_det_2 AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_buch,
 V01.dat_aenderung_rpw,
 V01.gp_id,
 V02.art_id,
 V02.best_menge_einh_id,
 V04.menge_lagerbew_bme AS we_menge,
 V02.menge_rech
FROM kfl_production_dbp_view.v_besch_rech_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_rech_det_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
        AND V01.rech_beleg_id = V02.rech_beleg_id AND V01.gj = V02.gj AND V01.system_id = V02.system_id AND V01.nb_id =
   V02.nb_id
 INNER JOIN (SELECT mandant_id,
   nb_id,
   wup_id,
   system_id,
   beleg_id,
   beleg_gj
  FROM kfl_production_dbp_view.v_problemmeldung_2
  WHERE problemcode_id IN ('0347   ', '0538   ', '0539   ', '0594   ')
   AND system_id = 7
   AND mandant_id = 1
   AND nb_id = 0
  GROUP BY system_id,
   mandant_id,
   wup_id,
   nb_id,
   beleg_id,
   beleg_gj) AS v03 ON V01.mandant_id = v03.mandant_id AND V01.wup_id = v03.wup_id AND V01.rech_beleg_id = v03.beleg_id
    AND V01.gj = v03.beleg_gj AND V01.system_id = v03.system_id AND V01.nb_id = v03.nb_id
 INNER JOIN kfl_production_dbp_view.v_lagerbew_det_2 AS V04 ON V02.mandant_id = V04.mandant_id AND V02.lagerbew_beleg_id =
     V04.lagerbew_beleg_id AND V02.lagerbew_beleg_pos_id = V04.lagerbew_beleg_pos_id AND V02.kj = V04.kj
WHERE V01.mandant_id = 1
 AND V01.nb_id = 0
UNION ALL
SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_buch,
 V01.dat_aenderung_rpw,
 V01.gp_id,
 V02.art_id,
 V02.best_menge_einh_id,
 V04.menge_lagerbew_bme AS we_menge,
 V02.menge_rech
FROM kfl_production_dbp_view.v_besch_rech_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_rech_det_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
        AND V01.rech_beleg_id = V02.rech_beleg_id AND V01.gj = V02.gj AND V01.system_id = V02.system_id AND V01.nb_id =
   V02.nb_id
 INNER JOIN (SELECT mandant_id,
   nb_id,
   wup_id,
   system_id,
   beleg_id,
   beleg_gj,
   beleg_pos_id
  FROM kfl_production_dbp_view.v_problemmeldung_2
  WHERE problemcode_id IN ('0231   ', '0313   ', '0314   ', '0593   ', '0595   ')
   AND system_id = 7
   AND mandant_id = 1
   AND nb_id = 0
   AND (mandant_id, nb_id, wup_id, system_id, beleg_id, beleg_gj) NOT IN (SELECT (mandant_id, nb_id, wup_id, system_id,
       beleg_id, beleg_gj)
     FROM kfl_production_dbp_view.v_problemmeldung_2
     WHERE problemcode_id IN ('0347   ', '0538   ', '0539   ', '0594   '))
  GROUP BY system_id,
   mandant_id,
   beleg_pos_id,
   wup_id,
   nb_id,
   beleg_id,
   beleg_gj) AS v03 ON V02.mandant_id = v03.mandant_id AND V02.wup_id = v03.wup_id AND V02.rech_beleg_id = v03.beleg_id
     AND V02.gj = v03.beleg_gj AND V02.rech_beleg_pos_id = v03.beleg_pos_id AND V02.system_id = v03.system_id AND V02.nb_id
    = v03.nb_id
 INNER JOIN kfl_production_dbp_view.v_lagerbew_det_2 AS V04 ON V02.mandant_id = V04.mandant_id AND V02.lagerbew_beleg_id =
     V04.lagerbew_beleg_id AND V02.lagerbew_beleg_pos_id = V04.lagerbew_beleg_pos_id AND V02.kj = V04.kj
WHERE V01.mandant_id = 1
 AND V01.nb_id = 0;