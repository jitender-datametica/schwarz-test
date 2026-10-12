CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_fipo_standard_text_spr_zu_2 AS SELECT fipo_standard_text_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN fipo_standard_text
   ELSE NULL
   END) AS fipo_standard_text,
 MAX(CASE
   WHEN spr_id = 22
   THEN fipo_standard_text
   ELSE NULL
   END) AS fipo_standard_text_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN fipo_standard_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN fipo_standard_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_standard_text
    ELSE NULL
    END)
  END AS fipo_standard_text_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN fipo_standard_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN fipo_standard_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_standard_text
    ELSE NULL
    END)
  END AS fipo_standard_text_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN fipo_standard_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN fipo_standard_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_standard_text
    ELSE NULL
    END)
  END AS fipo_standard_text_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN fipo_standard_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN fipo_standard_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_standard_text
    ELSE NULL
    END)
  END AS fipo_standard_text_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN fipo_standard_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN fipo_standard_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_standard_text
    ELSE NULL
    END)
  END AS fipo_standard_text_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN fipo_standard_text
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN fipo_standard_text
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_standard_text
    ELSE NULL
    END)
  END AS fipo_standard_text_bg
FROM kfl_production_dbp_view.v_fipo_standard_text_spr_zu_2
GROUP BY fipo_standard_text_id;