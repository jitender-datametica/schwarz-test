CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_kundenfaktor_spr_zu_2 AS SELECT kundenfaktor_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar,
 MAX(CASE
   WHEN spr_id = 22
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN kf_kommentar
   ELSE NULL
   END) AS kf_kommentar_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN kf_bez
   ELSE NULL
   END) AS kf_bez_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN kf_kommentar
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN kf_kommentar
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_kommentar
    ELSE NULL
    END)
  END AS kf_kommentar_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN kf_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN kf_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_bez
    ELSE NULL
    END)
  END AS kf_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN kf_kommentar
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN kf_kommentar
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_kommentar
    ELSE NULL
    END)
  END AS kf_kommentar_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN kf_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN kf_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_bez
    ELSE NULL
    END)
  END AS kf_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN kf_kommentar
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN kf_kommentar
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_kommentar
    ELSE NULL
    END)
  END AS kf_kommentar_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN kf_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN kf_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_bez
    ELSE NULL
    END)
  END AS kf_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN kf_kommentar
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN kf_kommentar
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_kommentar
    ELSE NULL
    END)
  END AS kf_kommentar_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN kf_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN kf_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_bez
    ELSE NULL
    END)
  END AS kf_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN kf_kommentar
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN kf_kommentar
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_kommentar
    ELSE NULL
    END)
  END AS kf_kommentar_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN kf_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN kf_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_bez
    ELSE NULL
    END)
  END AS kf_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN kf_kommentar
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN kf_kommentar
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_kommentar
    ELSE NULL
    END)
  END AS kf_kommentar_bg,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN kf_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN kf_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN kf_bez
    ELSE NULL
    END)
  END AS kf_bez_bg
FROM kfl_production_dbp_view.v_geku_kundenfaktor_spr_zu_2
GROUP BY kundenfaktor_id;