CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_betrag_2 AS SELECT mandant_id,
 ausgeber_typ_id,
 betrag_von,
 MAX(CASE
   WHEN spr_id = 22
   THEN betrag_bez
   ELSE NULL
   END) AS betrag_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN betrag_bez
   ELSE NULL
   END) AS betrag_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN betrag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN betrag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN betrag_bez
    ELSE NULL
    END)
  END AS betrag_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN betrag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN betrag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN betrag_bez
    ELSE NULL
    END)
  END AS betrag_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN betrag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN betrag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN betrag_bez
    ELSE NULL
    END)
  END AS betrag_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN betrag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN betrag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN betrag_bez
    ELSE NULL
    END)
  END AS betrag_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN betrag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN betrag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN betrag_bez
    ELSE NULL
    END)
  END AS betrag_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN betrag_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN betrag_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN betrag_bez
    ELSE NULL
    END)
  END AS betrag_bez_bg
FROM kfl_production_dbp_view.v_gs_betrag_spr_zu_2 AS V01
GROUP BY mandant_id,
 ausgeber_typ_id,
 betrag_von;