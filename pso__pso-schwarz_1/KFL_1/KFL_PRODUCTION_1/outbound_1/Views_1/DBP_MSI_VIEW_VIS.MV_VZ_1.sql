CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vz_1 AS SELECT v01.mandant_id,
 v01.vz_wup_id,
 v02.wup_standort AS vz_standort,
 COALESCE(v02.dat_von, DATE('2000-01-01')) AS vz_dat_von,
 COALESCE(v02.dat_bis, DATE('9999-12-31')) AS vz_dat_bis
FROM (SELECT mandant_id,
   vz_wup_id
  FROM kfl_production_dbp_view.v_vz_wg_wup_zu_per_1
  WHERE dat_bis = DATE '9999-12-31'
   AND arthiertyp_id = - 1
   AND wg_hierarchie_ebene_id = - 1
   AND wg_hierarchie_id = - 1
  GROUP BY mandant_id,
   vz_wup_id) AS v01
 INNER JOIN (SELECT mandant_id,
   wup_id,
   wup_standort,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_view.v_wup_1
  WHERE nb_id = - 111
   AND wup_typ_id = 2) AS v02 ON v01.mandant_id = v02.mandant_id AND v01.vz_wup_id = v02.wup_id
UNION ALL
SELECT mandant_id,
 wup_id AS vz_wup_id,
 wup_standort AS vz_standort,
 COALESCE(dat_von, DATE('2000-01-01')) AS vz_dat_von,
 COALESCE(dat_bis, DATE('9999-12-31')) AS vz_dat_bis
FROM kfl_production_dbp_view.v_wup_1
WHERE wup_id = 0;