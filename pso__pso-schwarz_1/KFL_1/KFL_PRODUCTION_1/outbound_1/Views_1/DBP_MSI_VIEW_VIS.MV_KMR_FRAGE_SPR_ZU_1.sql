CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_frage_spr_zu_1 (kmr_frage_id, kmr_quelle_id, kmr_frage_bez,
kmr_frage_bez_cz, kmr_frage_bez_pl, kmr_frage_bez_sk, kmr_frage_bez_hr, kmr_frage_bez_ro, kmr_frage_bez_bg) AS SELECT
 V02.kmr_agm_id AS kmr_frage_id,
 V02.kmr_quelle_id,
 V01.amx_frage_bez AS kmr_frage_bez,
 V01.amx_frage_bez AS kmr_frage_bez_cz,
 V01.amx_frage_bez AS kmr_frage_bez_pl,
 V01.amx_frage_bez AS kmr_frage_bez_sk,
 V01.amx_frage_bez AS kmr_frage_bez_hr,
 V01.amx_frage_bez AS kmr_frage_bez_ro,
 V01.amx_frage_bez AS kmr_frage_bez_bg
FROM kfl_production_dbp_view.v_amx_frage_katalog_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_1 AS V02 ON V01.amx_frage_katalog_id = V02.kmr_agm_id AND
   V02.kmr_quelle_id = 1
UNION ALL
SELECT V04.kmr_agm_id AS kmr_frage_id,
 V04.kmr_quelle_id,
 MAX(CASE
   WHEN V06.gesamt_fg = 1
   THEN CASE
    WHEN V07.spr_id = 22
    THEN V07.frage_bez
    ELSE NULL
    END
   ELSE CASE
    WHEN V03.spr_id = 22
    THEN V03.antwort_bez
    ELSE NULL
    END
   END) AS kmr_frage_bez,
 MAX(CASE
   WHEN V06.gesamt_fg = 1
   THEN CASE
    WHEN V07.spr_id = 124
    THEN V07.frage_bez
    ELSE NULL
    END
   ELSE CASE
    WHEN V03.spr_id = 124
    THEN V03.antwort_bez
    ELSE NULL
    END
   END) AS kmr_frage_bez_cz,
 MAX(CASE
   WHEN V06.gesamt_fg = 1
   THEN CASE
    WHEN V07.spr_id = 90
    THEN V07.frage_bez
    ELSE NULL
    END
   ELSE CASE
    WHEN V03.spr_id = 90
    THEN V03.antwort_bez
    ELSE NULL
    END
   END) AS kmr_frage_bez_pl,
 MAX(CASE
   WHEN V06.gesamt_fg = 1
   THEN CASE
    WHEN V07.spr_id = 108
    THEN V07.frage_bez
    ELSE NULL
    END
   ELSE CASE
    WHEN V03.spr_id = 108
    THEN V03.antwort_bez
    ELSE NULL
    END
   END) AS kmr_frage_bez_sk,
 MAX(CASE
   WHEN V06.gesamt_fg = 1
   THEN CASE
    WHEN V07.spr_id = 65
    THEN V07.frage_bez
    ELSE NULL
    END
   ELSE CASE
    WHEN V03.spr_id = 65
    THEN V03.antwort_bez
    ELSE NULL
    END
   END) AS kmr_frage_bez_hr,
 MAX(CASE
   WHEN V06.gesamt_fg = 1
   THEN CASE
    WHEN V07.spr_id = 95
    THEN V07.frage_bez
    ELSE NULL
    END
   ELSE CASE
    WHEN V03.spr_id = 95
    THEN V03.antwort_bez
    ELSE NULL
    END
   END) AS kmr_frage_bez_ro,
 MAX(CASE
   WHEN V06.gesamt_fg = 1
   THEN CASE
    WHEN V07.spr_id = 18
    THEN V07.frage_bez
    ELSE NULL
    END
   ELSE CASE
    WHEN V03.spr_id = 18
    THEN V03.antwort_bez
    ELSE NULL
    END
   END) AS kmr_frage_bez_bg
FROM kfl_production_dbp_view.v_mcx_antwort_spr_zu_1 AS V03
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_1 AS V04 ON V03.antwort_id = V04.kmr_agm_id AND V03.umfrage_id
     = V04.umfrage_id AND V04.kmr_quelle_id = 2
 INNER JOIN kfl_production_dbp_view.v_mcx_l_antwort_1 AS V05 ON V03.antwort_id = V05.antwort_id AND V03.umfrage_id = V05.umfrage_id
   
 INNER JOIN kfl_production_dbp_view.v_mcx_antwort_kategorie_zu_1 AS V06 ON V05.antwort_id = V06.antwort_id AND V05.umfrage_id
    = V06.umfrage_id
 INNER JOIN kfl_production_dbp_view.v_mcx_frage_spr_zu_1 AS V07 ON V05.frage_id = V07.frage_id AND V05.umfrage_id = V07.umfrage_id
   
GROUP BY kmr_frage_id,
 V04.kmr_quelle_id
UNION ALL
SELECT V06.kmr_agm_id AS kmr_frage_id,
 V06.kmr_quelle_id,
 MAX(CASE
   WHEN V05.spr_id = 22
   THEN V05.geku_dwh_artikel_bez
   ELSE NULL
   END) AS kmr_frage_bez,
 MAX(CASE
   WHEN V05.spr_id = 124
   THEN V05.geku_dwh_artikel_bez
   ELSE NULL
   END) AS kmr_frage_bez_cz,
 MAX(CASE
   WHEN V05.spr_id = 90
   THEN V05.geku_dwh_artikel_bez
   ELSE NULL
   END) AS kmr_frage_bez_pl,
 MAX(CASE
   WHEN V05.spr_id = 108
   THEN V05.geku_dwh_artikel_bez
   ELSE NULL
   END) AS kmr_frage_bez_sk,
 MAX(CASE
   WHEN V05.spr_id = 65
   THEN V05.geku_dwh_artikel_bez
   ELSE NULL
   END) AS kmr_frage_bez_hr,
 MAX(CASE
   WHEN V05.spr_id = 95
   THEN V05.geku_dwh_artikel_bez
   ELSE NULL
   END) AS kmr_frage_bez_ro,
 MAX(CASE
   WHEN V05.spr_id = 18
   THEN V05.geku_dwh_artikel_bez
   ELSE NULL
   END) AS kmr_frage_bez_bg
FROM kfl_production_dbp_view.v_geku_dwh_artikel_spr_zu_1 AS V05
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_1 AS V06 ON V05.geku_dwh_artikel_id = V06.kmr_agm_id AND
   V06.kmr_quelle_id = 3
WHERE V05.geku_dwh_artikel_id IN (SELECT geku_dwh_artikel_id
   FROM kfl_production_dbp_view.v_l_geku_artikel_1)
GROUP BY kmr_frage_id,
 V06.kmr_quelle_id
UNION ALL
SELECT V08.kmr_agm_id AS kmr_frage_id,
 V08.kmr_quelle_id,
 MAX(CASE
   WHEN V07.spr_id = 22
   THEN V07.fipo_pruefpunkt_bez
   ELSE NULL
   END) AS kmr_frage_bez,
  CASE
  WHEN MAX(CASE
    WHEN V07.spr_id = 124
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V07.spr_id = 124
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V07.spr_id = 22
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  END AS kmr_frage_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN V07.spr_id = 90
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V07.spr_id = 90
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V07.spr_id = 22
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  END AS kmr_frage_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN V07.spr_id = 108
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V07.spr_id = 108
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V07.spr_id = 22
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  END AS kmr_frage_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN V07.spr_id = 65
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V07.spr_id = 65
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V07.spr_id = 22
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  END AS kmr_frage_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN V07.spr_id = 95
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V07.spr_id = 95
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V07.spr_id = 22
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  END AS kmr_frage_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN V07.spr_id = 18
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V07.spr_id = 18
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V07.spr_id = 22
    THEN V07.fipo_pruefpunkt_bez
    ELSE NULL
    END)
  END AS kmr_frage_bez_bg
FROM kfl_production_dbp_view.v_fipo_pruefpunkt_spr_zu_1 AS V07
 INNER JOIN kfl_production_dbp_view.v_kmr_agm_unter_kategorie_zu_1 AS V08 ON V07.fipo_pruefpunkt_id = V08.kmr_agm_id AND
   V08.kmr_quelle_id = 4
GROUP BY kmr_frage_id,
 V08.kmr_quelle_id;