CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_ereignisquelle AS SELECT mandant_id,
 ereignisquelle_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignisquelle_bez
   ELSE NULL
   END) AS ereignisquelle_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignisquelle_bez
   ELSE NULL
   END) AS ereignisquelle_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignisquelle_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  END AS ereignisquelle_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignisquelle_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  END AS ereignisquelle_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignisquelle_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  END AS ereignisquelle_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignisquelle_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  END AS ereignisquelle_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignisquelle_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  END AS ereignisquelle_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignisquelle_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignisquelle_bez
    ELSE NULL
    END)
  END AS ereignisquelle_bez_bg
FROM kfl_production_dbp_view.v_ereignisquelle_spr_zu AS V01
GROUP BY mandant_id,
 ereignisquelle_id;