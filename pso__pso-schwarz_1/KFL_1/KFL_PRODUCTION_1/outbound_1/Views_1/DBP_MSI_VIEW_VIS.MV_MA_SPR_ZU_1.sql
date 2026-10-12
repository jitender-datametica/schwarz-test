CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ma_spr_zu_1 AS SELECT mandant_id,
 ma_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_anrede
   ELSE NULL
   END) AS ma_anrede,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_vorname
   ELSE NULL
   END) AS ma_vorname,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_name
   ELSE NULL
   END) AS ma_name,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_anrede
   ELSE NULL
   END) AS ma_anrede_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_vorname
   ELSE NULL
   END) AS ma_vorname_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_name
   ELSE NULL
   END) AS ma_name_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)
  END AS ma_anrede_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)
  END AS ma_vorname_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)
  END AS ma_name_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)
  END AS ma_anrede_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)
  END AS ma_vorname_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)
  END AS ma_name_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)
  END AS ma_anrede_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)
  END AS ma_vorname_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)
  END AS ma_name_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)
  END AS ma_anrede_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)
  END AS ma_vorname_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)
  END AS ma_name_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)
  END AS ma_anrede_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)
  END AS ma_vorname_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)
  END AS ma_name_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)
  END AS ma_anrede_bg,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)
  END AS ma_vorname_bg,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)
  END AS ma_name_bg
FROM kfl_production_dbp_view.v_ma_spr_zu_1 AS V01
GROUP BY mandant_id,
 ma_id;