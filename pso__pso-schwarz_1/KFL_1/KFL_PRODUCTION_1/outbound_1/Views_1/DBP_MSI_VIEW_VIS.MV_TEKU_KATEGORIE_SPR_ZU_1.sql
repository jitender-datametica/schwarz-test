CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_kategorie_spr_zu_1 AS SELECT LTK.teku_kategorie_nr,
 MAX(CASE
   WHEN TKSP.spr_id = 22
   THEN TKSP.teku_kategorie_bez
   ELSE NULL
   END) AS teku_kategorie_bez,
 MAX(CASE
   WHEN TKSP.spr_id = 22
   THEN TKSP.teku_kategorie_bez
   ELSE NULL
   END) AS teku_kategorie_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN TKSP.spr_id = 124
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN TKSP.spr_id = 124
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN TKSP.spr_id = 22
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN TKSP.spr_id = 90
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN TKSP.spr_id = 90
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN TKSP.spr_id = 22
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN TKSP.spr_id = 108
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN TKSP.spr_id = 108
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN TKSP.spr_id = 22
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN TKSP.spr_id = 65
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN TKSP.spr_id = 65
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN TKSP.spr_id = 22
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN TKSP.spr_id = 95
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN TKSP.spr_id = 95
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN TKSP.spr_id = 22
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN TKSP.spr_id = 18
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN TKSP.spr_id = 18
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN TKSP.spr_id = 22
    THEN TKSP.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_bg,
  CASE
  WHEN LTK.teku_kategorie_nr BETWEEN 310 AND 328
  THEN 10000 + LTK.teku_kategorie_nr
  WHEN LTK.teku_kategorie_nr BETWEEN 144 AND 145
  THEN 20000 + LTK.teku_kategorie_nr
  ELSE LTK.teku_kategorie_nr
  END AS tkfil_sort_id,
  CASE
  WHEN LTK.teku_kategorie_nr = 892
  THEN 879
  ELSE LTK.teku_kategorie_nr
  END AS tek3_sort_id
FROM kfl_production_dbp_view.v_teku_kategorie_spr_zu_1 AS TKSP
 INNER JOIN kfl_production_dbp_view.v_l_teku_kategorie_1 AS LTK ON TKSP.teku_kategorie_id = LTK.teku_kategorie_id
GROUP BY LTK.teku_kategorie_nr,
 tkfil_sort_id,
 tek3_sort_id
UNION ALL
SELECT T011.teku_kategorie_nr + DATE_DIFF(T02.dat, CURRENT_DATE, DAY) AS `_kat_nr`,
 MAX(CASE
   WHEN T01.spr_id = 22
   THEN T01.teku_kategorie_bez
   ELSE NULL
   END) AS teku_kategorie_bez,
 MAX(CASE
   WHEN T01.spr_id = 22
   THEN T01.teku_kategorie_bez
   ELSE NULL
   END) AS teku_kategorie_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN T01.spr_id = 124
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN T01.spr_id = 124
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN T01.spr_id = 90
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN T01.spr_id = 90
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN T01.spr_id = 108
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN T01.spr_id = 108
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN T01.spr_id = 65
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN T01.spr_id = 65
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN T01.spr_id = 95
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN T01.spr_id = 95
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN T01.spr_id = 18
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN T01.spr_id = 18
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.teku_kategorie_bez
    ELSE NULL
    END)
  END AS teku_kategorie_bez_bg,
  T011.teku_kategorie_nr + DATE_DIFF(T02.dat, CURRENT_DATE, DAY) AS tkfil_sort_id,
  T011.teku_kategorie_nr + DATE_DIFF(T02.dat, CURRENT_DATE, DAY) AS tek3_sort_id
FROM kfl_production_dbp_view.v_teku_kategorie_spr_zu_1 AS T01
 INNER JOIN kfl_production_dbp_view.v_l_teku_kategorie_1 AS T011 ON T01.teku_kategorie_id = T011.teku_kategorie_id
 INNER JOIN kfl_production_dbp_view.v_tag_1 AS T02 ON T02.dat BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 3 DAY) AND (DATE_SUB(CURRENT_DATE
    ,INTERVAL 1 DAY))
WHERE T011.teku_kategorie_nr = 9999
GROUP BY `_kat_nr`;