CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_dwh_artikel_spr_zu_1 AS SELECT geku_dwh_artikel_id,
 geku_artikel_uid,
 3 AS kmr_quelle_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  END AS geku_dwh_artikel_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  END AS geku_dwh_artikel_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  END AS geku_dwh_artikel_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  END AS geku_dwh_artikel_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  END AS geku_dwh_artikel_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN geku_dwh_artikel_bez
    ELSE NULL
    END)
  END AS geku_dwh_artikel_bez_bg
FROM kfl_production_dbp_view.v_geku_dwh_artikel_spr_zu_1
GROUP BY geku_dwh_artikel_id,
 geku_artikel_uid;