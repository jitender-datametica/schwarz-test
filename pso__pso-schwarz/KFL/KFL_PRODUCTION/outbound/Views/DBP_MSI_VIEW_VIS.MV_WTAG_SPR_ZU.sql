CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wtag_spr_zu AS SELECT wtag_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN TRIM(SUBSTR(wtag_bez, 1, 2))
   ELSE NULL
   END) AS wtag_kbez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wtag_bez
   ELSE NULL
   END) AS wtag_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN TRIM(SUBSTR(wtag_bez, 1, 2))
   ELSE NULL
   END) AS wtag_kbez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN wtag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN wtag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)
  END AS wtag_bez_cz,
 CAST(CASE
   WHEN MAX(CASE
     WHEN spr_id = 124
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END) IS NOT NULL
   THEN MAX(CASE
     WHEN spr_id = 124
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN spr_id = 22
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   END AS STRING) AS wtag_kbez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN wtag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN wtag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)
  END AS wtag_bez_pl,
 CAST(CASE
   WHEN MAX(CASE
     WHEN spr_id = 90
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END) IS NOT NULL
   THEN MAX(CASE
     WHEN spr_id = 90
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN spr_id = 22
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   END AS STRING) AS wtag_kbez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN wtag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN wtag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)
  END AS wtag_bez_sk,
 CAST(CASE
   WHEN MAX(CASE
     WHEN spr_id = 108
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END) IS NOT NULL
   THEN MAX(CASE
     WHEN spr_id = 108
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN spr_id = 22
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   END AS STRING) AS wtag_kbez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN wtag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN wtag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)
  END AS wtag_bez_hr,
 CAST(CASE
   WHEN MAX(CASE
     WHEN spr_id = 65
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END) IS NOT NULL
   THEN MAX(CASE
     WHEN spr_id = 65
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN spr_id = 22
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   END AS STRING) AS wtag_kbez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN wtag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN wtag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)
  END AS wtag_bez_ro,
 CAST(CASE
   WHEN MAX(CASE
     WHEN spr_id = 95
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END) IS NOT NULL
   THEN MAX(CASE
     WHEN spr_id = 95
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN spr_id = 22
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   END AS STRING) AS wtag_kbez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN wtag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN wtag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN wtag_bez
    ELSE NULL
    END)
  END AS wtag_bez_bg,
 CAST(CASE
   WHEN MAX(CASE
     WHEN spr_id = 18
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END) IS NOT NULL
   THEN MAX(CASE
     WHEN spr_id = 18
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   ELSE MAX(CASE
     WHEN spr_id = 22
     THEN TRIM(SUBSTR(wtag_bez, 1, 2))
     ELSE NULL
     END)
   END AS STRING) AS wtag_kbez_bg
FROM kfl_production_dbp_view.v_wtag_spr_zu AS V01
GROUP BY wtag_id;