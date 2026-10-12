CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_fipo_pruef_modul_spr_zu AS SELECT fipo_pruef_modul_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN fipo_pruef_modul_bez
   ELSE NULL
   END) AS fipo_pruef_modul_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN fipo_pruef_modul_bez
   ELSE NULL
   END) AS fipo_pruef_modul_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  END AS fipo_pruef_modul_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  END AS fipo_pruef_modul_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  END AS fipo_pruef_modul_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  END AS fipo_pruef_modul_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  END AS fipo_pruef_modul_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN fipo_pruef_modul_bez
    ELSE NULL
    END)
  END AS fipo_pruef_modul_bez_bg
FROM kfl_production_dbp_view.v_fipo_pruef_modul_spr_zu
GROUP BY fipo_pruef_modul_id;