CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_buchungskreis_spr_zu_2 AS SELECT V01.mandant_id,
 V01.buchungskreis_id,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.buchungskreis_bez
   ELSE NULL
   END) AS buchungskreis_bez,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.strasse
   ELSE NULL
   END) AS strasse,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.plz
   ELSE NULL
   END) AS plz,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.ort
   ELSE NULL
   END) AS ort,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.buchungskreis_bez
   ELSE NULL
   END) AS buchungskreis_bez_de,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.strasse
   ELSE NULL
   END) AS strasse_de,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.plz
   ELSE NULL
   END) AS plz_de,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.ort
   ELSE NULL
   END) AS ort_de,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.buchungskreis_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  END AS buchungskreis_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.strasse
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.strasse
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.strasse
    ELSE NULL
    END)
  END AS strasse_cz,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.plz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.plz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.plz
    ELSE NULL
    END)
  END AS plz_cz,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.ort
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.ort
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ort
    ELSE NULL
    END)
  END AS ort_cz,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.buchungskreis_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  END AS buchungskreis_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.strasse
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.strasse
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.strasse
    ELSE NULL
    END)
  END AS strasse_pl,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.plz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.plz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.plz
    ELSE NULL
    END)
  END AS plz_pl,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.ort
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.ort
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ort
    ELSE NULL
    END)
  END AS ort_pl,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.buchungskreis_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  END AS buchungskreis_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.strasse
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.strasse
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.strasse
    ELSE NULL
    END)
  END AS strasse_sk,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.plz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.plz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.plz
    ELSE NULL
    END)
  END AS plz_sk,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.ort
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.ort
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ort
    ELSE NULL
    END)
  END AS ort_sk,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.buchungskreis_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  END AS buchungskreis_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.strasse
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.strasse
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.strasse
    ELSE NULL
    END)
  END AS strasse_hr,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.plz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.plz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.plz
    ELSE NULL
    END)
  END AS plz_hr,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.ort
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.ort
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ort
    ELSE NULL
    END)
  END AS ort_hr,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.buchungskreis_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  END AS buchungskreis_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.strasse
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.strasse
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.strasse
    ELSE NULL
    END)
  END AS strasse_ro,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.plz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.plz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.plz
    ELSE NULL
    END)
  END AS plz_ro,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.ort
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.ort
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ort
    ELSE NULL
    END)
  END AS ort_ro,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.buchungskreis_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.buchungskreis_bez
    ELSE NULL
    END)
  END AS buchungskreis_bez_bg,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.strasse
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.strasse
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.strasse
    ELSE NULL
    END)
  END AS strasse_bg,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.plz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.plz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.plz
    ELSE NULL
    END)
  END AS plz_bg,
  CASE
  WHEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.ort
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.ort
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ort
    ELSE NULL
    END)
  END AS ort_bg
FROM kfl_production_dbp_view.v_buchungskreis_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_system_2 AS V02 ON V01.system_id = V02.system_id
WHERE V02.system_gruppe = 'SAP RET'
GROUP BY V01.mandant_id,
 V01.buchungskreis_id;