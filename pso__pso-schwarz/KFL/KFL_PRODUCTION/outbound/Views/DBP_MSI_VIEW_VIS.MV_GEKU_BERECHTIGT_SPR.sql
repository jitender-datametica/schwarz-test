CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_berechtigt_spr AS SELECT berechtigt_fg,
 MAX(CASE
   WHEN spr_id = 22
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN berechtigt_bez
   ELSE NULL
   END) AS berechtigt_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN berechtigt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN berechtigt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN berechtigt_bez
    ELSE NULL
    END)
  END AS berechtigt_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN berechtigt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN berechtigt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN berechtigt_bez
    ELSE NULL
    END)
  END AS berechtigt_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN berechtigt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN berechtigt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN berechtigt_bez
    ELSE NULL
    END)
  END AS berechtigt_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN berechtigt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN berechtigt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN berechtigt_bez
    ELSE NULL
    END)
  END AS berechtigt_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN berechtigt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN berechtigt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN berechtigt_bez
    ELSE NULL
    END)
  END AS berechtigt_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN berechtigt_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN berechtigt_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN berechtigt_bez
    ELSE NULL
    END)
  END AS berechtigt_bez_bg
FROM kfl_production_dbp_view.v_geku_berechtigt_spr_zu
GROUP BY berechtigt_fg;