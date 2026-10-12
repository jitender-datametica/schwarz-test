CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hyg_thema_spr_zu_2 AS SELECT TH.frage_katalog_id,
 TH.hyg_thema_id,
 TH.gj,
 MAX(CASE
   WHEN HS.spr_id = 22
   THEN HS.hyg_text
   ELSE NULL
   END) AS hyg_thema_bez,
 MAX(CASE
   WHEN HS.spr_id = 22
   THEN HS.hyg_text
   ELSE NULL
   END) AS hyg_thema_bez_de,
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
  END AS hyg_thema_bez_cz,
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
  END AS hyg_thema_bez_pl,
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
  END AS hyg_thema_bez_sk,
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
  END AS hyg_thema_bez_hr,
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
  END AS hyg_thema_bez_ro,
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
  END AS hyg_thema_bez_bg
FROM kfl_production_dbp_view.v_hyg_thema_2 AS TH
 INNER JOIN kfl_production_dbp_view.v_hyg_spr_zu_2 AS HS ON TH.hyg_thema_id = HS.hyg_ref_id AND TH.gj = HS.gj
WHERE HS.hyg_column = 'Name'
GROUP BY TH.frage_katalog_id,
 TH.hyg_thema_id,
 TH.gj;