CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_frage_spr_zu_2 AS SELECT HF.frage_katalog_id,
 HF.hyg_frage_id,
 HF.gj,
 MAX(CASE
   WHEN HS.spr_id = 22
   THEN HS.hyg_text
   ELSE NULL
   END) AS hyg_frage_bez,
 MAX(CASE
   WHEN HS.spr_id = 22
   THEN HS.hyg_text
   ELSE NULL
   END) AS hyg_frage_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN HS.spr_id = 124
    THEN HS.hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN HS.spr_id = 124
    THEN HS.hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN HS.spr_id = 22
    THEN HS.hyg_text
    ELSE NULL
    END)
  END AS hyg_frage_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN HS.spr_id = 90
    THEN HS.hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN HS.spr_id = 90
    THEN HS.hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN HS.spr_id = 22
    THEN HS.hyg_text
    ELSE NULL
    END)
  END AS hyg_frage_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN HS.spr_id = 108
    THEN HS.hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN HS.spr_id = 108
    THEN HS.hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN HS.spr_id = 22
    THEN HS.hyg_text
    ELSE NULL
    END)
  END AS hyg_frage_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN HS.spr_id = 65
    THEN HS.hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN HS.spr_id = 65
    THEN HS.hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN HS.spr_id = 22
    THEN HS.hyg_text
    ELSE NULL
    END)
  END AS hyg_frage_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN HS.spr_id = 95
    THEN HS.hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN HS.spr_id = 95
    THEN HS.hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN HS.spr_id = 22
    THEN HS.hyg_text
    ELSE NULL
    END)
  END AS hyg_frage_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN HS.spr_id = 18
    THEN HS.hyg_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN HS.spr_id = 18
    THEN HS.hyg_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN HS.spr_id = 22
    THEN HS.hyg_text
    ELSE NULL
    END)
  END AS hyg_frage_bez_bg
FROM kfl_production_dbp_view.v_hyg_frage_2 AS HF
 INNER JOIN kfl_production_dbp_view.v_hyg_spr_zu_2 AS HS ON HF.hyg_frage_id = HS.hyg_ref_id AND HF.gj = HS.gj
WHERE HS.hyg_column = 'QuestionText'
GROUP BY HF.frage_katalog_id,
 HF.hyg_frage_id,
 HF.gj
UNION ALL
SELECT frage_katalog_id,
 'ZZZZ' AS hyg_frage_id,
 gj,
 'Gesamt' AS hyg_frage_bez,
 'Gesamt' AS hyg_frage_bez_de,
 'Gesamt' AS hyg_frage_bez_cz,
 'Gesamt' AS hyg_frage_bez_pl,
 'Gesamt' AS hyg_frage_bez_sk,
 'Gesamt' AS hyg_frage_bez_hr,
 'Gesamt' AS hyg_frage_bez_ro,
 'Gesamt' AS hyg_frage_bez_bg
FROM kfl_production_dbp_view.v_hyg_frage_katalog_2;