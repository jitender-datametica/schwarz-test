CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_antwort AS SELECT hyg_ref_id AS hyg_antwort_id,
 gj,
 MAX(CASE
   WHEN spr_id = 22
   THEN hyg_text
   ELSE NULL
   END) AS hyg_antwort_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN hyg_text
   ELSE NULL
   END) AS hyg_antwort_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN hyg_text
    ELSE NULL
    END)
  END AS hyg_antwort_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN hyg_text
    ELSE NULL
    END)
  END AS hyg_antwort_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN hyg_text
    ELSE NULL
    END)
  END AS hyg_antwort_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN hyg_text
    ELSE NULL
    END)
  END AS hyg_antwort_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN hyg_text
    ELSE NULL
    END)
  END AS hyg_antwort_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN hyg_text
    ELSE NULL
    END)
  END AS hyg_antwort_bez_bg
FROM kfl_production_dbp_view.v_hyg_spr_zu
WHERE hyg_column = 'AnswerText'
GROUP BY hyg_antwort_id,
 gj
UNION ALL
SELECT SUBSTR('00000000-0000-0000-0000-000000000000', 1, 36) AS hyg_antwort_id,
 gj,
 '' AS hyg_antwort_bez,
 '' AS hyg_antwort_bez_de,
 '' AS hyg_antwort_bez_cz,
 '' AS hyg_antwort_bez_pl,
 '' AS hyg_antwort_bez_sk,
 '' AS hyg_antwort_bez_hr,
 '' AS hyg_antwort_bez_ro,
 '' AS hyg_antwort_bez_bg
FROM kfl_production_dbp_view.v_hyg_frage_katalog;