CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ker_mo_periode_zu_1 (buchungsperiode_id, buchungsperiode_bez, gj
, ker_mo_id, kj, kj_ker_mo_id, kjmo, akt_mo, akt_gj) AS SELECT V01.buchungsperiode_id,
 V02.buchungsperiode_bez,
 V01.gj,
 V01.ker_mo_id,
 V01.kj,
 V01.kj_ker_mo_id,
 V01.kjmo,
 V03.akt_mo,
 v04.akt_gj
FROM kfl_production_dbp_view.v_ker_mo_periode_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_buchungsperiode_1 AS V02 ON V01.buchungsperiode_id = V02.buchungsperiode_id AND
   V01.krk_id = V02.krk_id
 LEFT JOIN kfl_production_dbp_view.v_monat_1 AS V03 ON V01.kj_ker_mo_id = V03.kjmo
 INNER JOIN (SELECT gj,
   akt_gj
  FROM kfl_production_dbp_view.v_monat_1
  GROUP BY gj,
   akt_gj) AS v04 ON V01.gj = v04.gj
WHERE V01.mandant_id = 3
 AND V01.buchungsperiode_id <= 13;