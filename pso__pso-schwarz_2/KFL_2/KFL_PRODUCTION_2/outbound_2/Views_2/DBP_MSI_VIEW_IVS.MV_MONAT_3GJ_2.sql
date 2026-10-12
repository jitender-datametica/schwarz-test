CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_monat_3gj_2 (kjmo_buchungsschluss, gj, gj_vj_kz, max_dat,
kjmo_min, kjmo_max, gjmo_max) AS SELECT ALLES.kjmo_buchungsschluss,
 ALLES.gj,
 ALLES.gj_vj_kz,
  CASE
  WHEN ALLES.gj_vj_kz = 0
  THEN MGMAX.dat_mo_ende
  ELSE MMAX.dat_mo_ende
  END AS max_dat,
 MIN(ALLES.kjmo_min) AS kjmo_min,
 MAX(ALLES.kjmo_max) AS kjmo_max,
 MAX(ALLES.gjmo_max) AS gjmo_max
FROM (SELECT CASE
    WHEN M.akt_buchungs_schluss = 0
    THEN M.kjmo
    ELSE NULL
    END AS kjmo_buchungsschluss,
   M3J.gj,
    CASE
    WHEN M3J.gj = M.gj
    THEN 0
    WHEN M3J.gj = M.gj - 1
    THEN - 1
    WHEN M3J.gj = M.gj - 2
    THEN - 2
    WHEN M3J.gj = M.gj - 3
    THEN - 3
    ELSE NULL
    END AS gj_vj_kz,
   101 AS max_dat,
   MIN(M3J.kjmo) OVER (PARTITION BY CAST(M3J.gj AS STRING) ORDER BY M3J.kjmo IS NULL, M3J.kjmo RANGE BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS kjmo_min,
   MAX(M3J.kjmo) OVER (PARTITION BY CAST(M3J.gj AS STRING) ORDER BY M3J.kjmo IS NULL, M3J.kjmo RANGE BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW) AS kjmo_max,
    CASE
    WHEN CASE
      WHEN M3J.gj = M.gj
      THEN 0
      WHEN M3J.gj = M.gj - 1
      THEN - 1
      WHEN M3J.gj = M.gj - 2
      THEN - 2
      WHEN M3J.gj = M.gj - 3
      THEN - 3
      ELSE NULL
      END < 0
    THEN MAX(M3J.kjmo) OVER (PARTITION BY CAST(M3J.gj AS STRING) ORDER BY M3J.kjmo IS NULL, M3J.kjmo RANGE BETWEEN
     UNBOUNDED PRECEDING AND CURRENT ROW)
    WHEN CASE
      WHEN M3J.gj = M.gj
      THEN 0
      WHEN M3J.gj = M.gj - 1
      THEN - 1
      WHEN M3J.gj = M.gj - 2
      THEN - 2
      WHEN M3J.gj = M.gj - 3
      THEN - 3
      ELSE NULL
      END = 0
    THEN CASE
     WHEN M.akt_buchungs_schluss = 0
     THEN M.kjmo
     ELSE NULL
     END
    ELSE NULL
    END AS gjmo_max
  FROM kfl_production_dbp_msi_view_ivs.mv_monat_2 AS M
   INNER JOIN kfl_production_dbp_view.v_monat_2 AS M3J ON M3J.gj BETWEEN M.gj - 3 AND M.gj AND M.akt_buchungs_schluss = 0
  ) AS ALLES
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_monat_2 AS MMAX ON ALLES.kjmo_max = MMAX.kjmo
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_monat_2 AS MGMAX ON ALLES.gjmo_max = MGMAX.kjmo
GROUP BY ALLES.kjmo_buchungsschluss,
 ALLES.gj,
 ALLES.gj_vj_kz,
 max_dat;