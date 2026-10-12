CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vz_wup_zu AS SELECT v01.mandant_id,
 v01.nb_id,
 v01.wup_id,
 v01.wup_standort,
 COALESCE(v03.vz_wup_id, 0) AS vz_wup_id,
 COALESCE(v03.vz_prio_id, 0) AS vz_prio_id,
 COALESCE(v03.kreistyp_id, '') AS vz_kreistyp_id
FROM (SELECT mandant_id,
   nb_id,
   wup_id,
   wup_standort
  FROM kfl_production_dbp_view.v_wup
  WHERE (nb_id = 0 OR wup_id = 0)
   AND dat_eroeffnung > DATE '1900-01-01'
   AND (mandant_id, wup_id) NOT IN (SELECT (mandant_id, wup_id_alt)
     FROM kfl_production_dbp_view.v_wup
     WHERE wup_id_alt > 0
      AND dat_von > DATE '2010-03-01'
      AND dat_von < CURRENT_DATE)) AS v01
 LEFT JOIN (SELECT mandant_id,
   nb_id,
   wup_id,
   vz_wup_id,
   vz_prio_id,
   kreistyp_id
  FROM kfl_production_dbp_view.v_vz_wg_wup_zu_per
  WHERE dat_bis = DATE '9999-12-31'
   AND arthiertyp_id = - 1
   AND wg_hierarchie_ebene_id = - 1
   AND wg_hierarchie_id = - 1
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   vz_wup_id,
   vz_prio_id,
   kreistyp_id) AS v03 ON v01.mandant_id = v03.mandant_id AND v01.wup_id = v03.wup_id;