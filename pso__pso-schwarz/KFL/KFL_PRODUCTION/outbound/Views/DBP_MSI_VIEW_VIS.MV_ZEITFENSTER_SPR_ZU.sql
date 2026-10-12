CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zeitfenster_spr_zu AS SELECT mandant_id,
 zeitfenster_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN zeitfenster_bez
   ELSE NULL
   END) AS zeitfenster_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN zeitfenster_bez
   ELSE NULL
   END) AS zeitfenster_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN zeitfenster_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN zeitfenster_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN zeitfenster_bez
    ELSE NULL
    END)
  END AS zeitfenster_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN zeitfenster_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN zeitfenster_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN zeitfenster_bez
    ELSE NULL
    END)
  END AS zeitfenster_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN zeitfenster_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN zeitfenster_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN zeitfenster_bez
    ELSE NULL
    END)
  END AS zeitfenster_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN zeitfenster_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN zeitfenster_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN zeitfenster_bez
    ELSE NULL
    END)
  END AS zeitfenster_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN zeitfenster_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN zeitfenster_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN zeitfenster_bez
    ELSE NULL
    END)
  END AS zeitfenster_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN zeitfenster_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN zeitfenster_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN zeitfenster_bez
    ELSE NULL
    END)
  END AS zeitfenster_bez_bg
FROM kfl_production_dbp_view.v_zeitfenster_spr_zu
GROUP BY mandant_id,
 zeitfenster_id;