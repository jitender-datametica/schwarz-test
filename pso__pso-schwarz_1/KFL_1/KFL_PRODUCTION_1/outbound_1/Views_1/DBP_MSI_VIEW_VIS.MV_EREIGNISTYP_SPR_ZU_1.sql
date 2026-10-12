CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ereignistyp_spr_zu_1 AS SELECT ereignistyp_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignistyp_bez
   ELSE NULL
   END) AS ereignistyp_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignistyp_bez
   ELSE NULL
   END) AS ereignistyp_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignistyp_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignistyp_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignistyp_bez
    ELSE NULL
    END)
  END AS ereignistyp_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignistyp_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignistyp_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignistyp_bez
    ELSE NULL
    END)
  END AS ereignistyp_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignistyp_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignistyp_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignistyp_bez
    ELSE NULL
    END)
  END AS ereignistyp_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignistyp_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignistyp_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignistyp_bez
    ELSE NULL
    END)
  END AS ereignistyp_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignistyp_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignistyp_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignistyp_bez
    ELSE NULL
    END)
  END AS ereignistyp_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignistyp_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignistyp_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignistyp_bez
    ELSE NULL
    END)
  END AS ereignistyp_bez_bg
FROM kfl_production_dbp_view.v_ereignistyp_spr_zu_1
GROUP BY ereignistyp_id,
 mandant_id;