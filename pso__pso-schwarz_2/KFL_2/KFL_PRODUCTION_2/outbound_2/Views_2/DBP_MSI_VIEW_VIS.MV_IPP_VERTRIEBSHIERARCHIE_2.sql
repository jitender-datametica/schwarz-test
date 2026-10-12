CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ipp_vertriebshierarchie_2 AS SELECT mandant_id,
  TRIM(CAST(mandant_id AS STRING FORMAT '00')) || '.99.999999.999999.999999' AS id,
 5 AS ebene_id,
 'ZZZZZ' AS vs_sort,
 '' AS gf_sort,
 '' AS vkl_sort,
 'Gesamt' AS vs_bez,
 '' AS gf_anrede,
 '' AS gf_name,
 '' AS gf_vorname,
 '' AS vkl_anrede,
 '' AS vkl_name,
 '' AS vkl_vorname,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez,
 '' AS wup_standort,
 'Gesamt' AS vs_bez_de,
 '' AS gf_anrede_de,
 '' AS gf_name_de,
 '' AS gf_vorname_de,
 '' AS vkl_anrede_de,
 '' AS vkl_name_de,
 '' AS vkl_vorname_de,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_de,
 '' AS wup_standort_de,
 'Celkem' AS vs_bez_cz,
 '' AS gf_anrede_cz,
 '' AS gf_name_cz,
 '' AS gf_vorname_cz,
 '' AS vkl_anrede_cz,
 '' AS vkl_name_cz,
 '' AS vkl_vorname_cz,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_cz,
 '' AS wup_standort_cz,
 'Suma' AS vs_bez_pl,
 '' AS gf_anrede_pl,
 '' AS gf_name_pl,
 '' AS gf_vorname_pl,
 '' AS vkl_anrede_pl,
 '' AS vkl_name_pl,
 '' AS vkl_vorname_pl,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_pl,
 '' AS wup_standort_pl,
 'Celkom' AS vs_bez_sk,
 '' AS gf_anrede_sk,
 '' AS gf_name_sk,
 '' AS gf_vorname_sk,
 '' AS vkl_anrede_sk,
 '' AS vkl_name_sk,
 '' AS vkl_vorname_sk,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_sk,
 '' AS wup_standort_sk,
 'Ukupno' AS vs_bez_hr,
 '' AS gf_anrede_hr,
 '' AS gf_name_hr,
 '' AS gf_vorname_hr,
 '' AS vkl_anrede_hr,
 '' AS vkl_name_hr,
 '' AS vkl_vorname_hr,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_hr,
 '' AS wup_standort_hr,
 'Total' AS vs_bez_ro,
 '' AS gf_anrede_ro,
 '' AS gf_name_ro,
 '' AS gf_vorname_ro,
 '' AS vkl_anrede_ro,
 '' AS vkl_name_ro,
 '' AS vkl_vorname_ro,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_ro,
 '' AS wup_standort_ro,
 '\\u041E\\u0431\\u0449\\u043E' AS vs_bez_bg,
 '' AS gf_anrede_bg,
 '' AS gf_name_bg,
 '' AS gf_vorname_bg,
 '' AS vkl_anrede_bg,
 '' AS vkl_name_bg,
 '' AS vkl_vorname_bg,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_bg,
 '' AS wup_standort_bg
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT mandant_id,
    TRIM(CAST(mandant_id AS STRING FORMAT '00')) || '.' || TRIM(CAST(vs_id AS STRING FORMAT '00')) ||
  '.999999.999999.999999' AS id,
 4 AS ebene_id,
  COALESCE(vs_bez, '') || 'ZZZ' AS vs_sort,
 '' AS gf_sort,
 '' AS vkl_sort,
  'Gesamt ' || COALESCE(vs_bez, '') AS vs_bez,
 '' AS gf_anrede,
 '' AS gf_name,
 '' AS gf_vorname,
 '' AS vkl_anrede,
 '' AS vkl_name,
 '' AS vkl_vorname,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez,
 '' AS wup_standort,
  'Gesamt ' || COALESCE(vs_bez, '') AS vs_bez_de,
 '' AS gf_anrede_de,
 '' AS gf_name_de,
 '' AS gf_vorname_de,
 '' AS vkl_anrede_de,
 '' AS vkl_name_de,
 '' AS vkl_vorname_de,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_de,
 '' AS wup_standort_de,
  'Celkem ' || COALESCE(vs_bez, '') AS vs_bez_cz,
 '' AS gf_anrede_cz,
 '' AS gf_name_cz,
 '' AS gf_vorname_cz,
 '' AS vkl_anrede_cz,
 '' AS vkl_name_cz,
 '' AS vkl_vorname_cz,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_cz,
 '' AS wup_standort_cz,
  'Suma ' || COALESCE(vs_bez, '') AS vs_bez_pl,
 '' AS gf_anrede_pl,
 '' AS gf_name_pl,
 '' AS gf_vorname_pl,
 '' AS vkl_anrede_pl,
 '' AS vkl_name_pl,
 '' AS vkl_vorname_pl,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_pl,
 '' AS wup_standort_pl,
  'Celkom ' || COALESCE(vs_bez, '') AS vs_bez_sk,
 '' AS gf_anrede_sk,
 '' AS gf_name_sk,
 '' AS gf_vorname_sk,
 '' AS vkl_anrede_sk,
 '' AS vkl_name_sk,
 '' AS vkl_vorname_sk,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_sk,
 '' AS wup_standort_sk,
  'Ukupno ' || COALESCE(vs_bez, '') AS vs_bez_hr,
 '' AS gf_anrede_hr,
 '' AS gf_name_hr,
 '' AS gf_vorname_hr,
 '' AS vkl_anrede_hr,
 '' AS vkl_name_hr,
 '' AS vkl_vorname_hr,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_hr,
 '' AS wup_standort_hr,
  'Total ' || COALESCE(vs_bez, '') AS vs_bez_ro,
 '' AS gf_anrede_ro,
 '' AS gf_name_ro,
 '' AS gf_vorname_ro,
 '' AS vkl_anrede_ro,
 '' AS vkl_name_ro,
 '' AS vkl_vorname_ro,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_ro,
 '' AS wup_standort_ro,
   '\\u041E\\u0431\\u0449\\u043E' || ' ' || COALESCE(vs_bez, '') AS vs_bez_bg,
 '' AS gf_anrede_bg,
 '' AS gf_name_bg,
 '' AS gf_vorname_bg,
 '' AS vkl_anrede_bg,
 '' AS vkl_name_bg,
 '' AS vkl_vorname_bg,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_bg,
 '' AS wup_standort_bg
FROM kfl_production_dbp_view.v_vs_2
UNION ALL
SELECT W.mandant_id,
      TRIM(CAST(W.mandant_id AS STRING FORMAT '00')) || '.' || TRIM(CAST(W.vs_id AS STRING FORMAT '00')) || '.' || TRIM(CAST(WD.gf_gbl_vertrieb_id AS STRING FORMAT '00')
    ) || '.999999.999999' AS id,
 3 AS ebene_id,
 V.vs_bez AS vs_sort,
  GF.ma_name || 'ZZZ' AS gf_sort,
 '' AS vkl_sort,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN V.vs_bez
   ELSE NULL
   END) AS vs_bez,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN 'Gesamt ' || COALESCE(GF.ma_anrede, '')
   ELSE NULL
   END) AS gf_anrede,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_name
   ELSE NULL
   END) AS gf_name,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_vorname
   ELSE NULL
   END) AS gf_vorname,
 '' AS vkl_anrede,
 '' AS vkl_name,
 '' AS vkl_vorname,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez,
 '' AS wup_standort,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN V.vs_bez
   ELSE NULL
   END) AS vs_bez0,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN 'Gesamt ' || COALESCE(GF.ma_anrede, '')
   ELSE NULL
   END) AS gf_anrede0,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_name
   ELSE NULL
   END) AS gf_name0,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_vorname
   ELSE NULL
   END) AS gf_vorname0,
 '' AS vkl_anrede_de,
 '' AS vkl_name_de,
 '' AS vkl_vorname_de,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_de,
 '' AS wup_standort_de,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN 'Celkem ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN 'Celkem ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN 'Celkem ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  END AS gf_anrede_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_cz,
 '' AS vkl_anrede_cz,
 '' AS vkl_name_cz,
 '' AS vkl_vorname_cz,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_cz,
 '' AS wup_standort_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN 'Suma ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN 'Suma ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN 'Suma ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  END AS gf_anrede_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_pl,
 '' AS vkl_anrede_pl,
 '' AS vkl_name_pl,
 '' AS vkl_vorname_pl,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_pl,
 '' AS wup_standort_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN 'Celkom ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN 'Celkom ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN 'Celkom ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  END AS gf_anrede_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_sk,
 '' AS vkl_anrede_sk,
 '' AS vkl_name_sk,
 '' AS vkl_vorname_sk,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_sk,
 '' AS wup_standort_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN 'Ukupno ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN 'Ukupno ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN 'Ukupno ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  END AS gf_anrede_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_hr,
 '' AS vkl_anrede_hr,
 '' AS vkl_name_hr,
 '' AS vkl_vorname_hr,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_hr,
 '' AS wup_standort_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN 'Total ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN 'Total ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN 'Total ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  END AS gf_anrede_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_ro,
 '' AS vkl_anrede_ro,
 '' AS vkl_name_ro,
 '' AS vkl_vorname_ro,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_ro,
 '' AS wup_standort_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN '\\u041E\\u0431\\u0449\\u043E' || ' ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN '\\u041E\\u0431\\u0449\\u043E' || ' ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN '\\u041E\\u0431\\u0449\\u043E' || ' ' || COALESCE(GF.ma_anrede, '')
    ELSE NULL
    END)
  END AS gf_anrede_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_bg,
 '' AS vkl_anrede_bg,
 '' AS vkl_name_bg,
 '' AS vkl_vorname_bg,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_bg,
 '' AS wup_standort_bg
FROM kfl_production_dbp_view.v_wup_2 AS W
 INNER JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_2 AS WD ON W.wup_id = WD.wup_id AND W.mandant_id = WD.mandant_id
 INNER JOIN kfl_production_dbp_view.v_vs_2 AS V ON W.mandant_id = V.mandant_id AND W.vs_id = V.vs_id
 INNER JOIN kfl_production_dbp_view.v_ma_spr_zu_2 AS GF_2 ON WD.mandant_id = GF.mandant_id AND WD.gf_gbl_vertrieb_id = GF.ma_id
   
WHERE WD.glv_land_id <> - 1
GROUP BY W.mandant_id,
 id,
 ebene_id,
 vs_sort,
 gf_sort
UNION ALL
SELECT W.mandant_id,
        TRIM(CAST(W.mandant_id AS STRING FORMAT '00')) || '.' || TRIM(CAST(W.vs_id AS STRING FORMAT '00')) || '.' ||
     TRIM(CAST(WD.gf_gbl_vertrieb_id AS STRING FORMAT '000000')) || '.' || TRIM(CAST(WD.vkl_id AS STRING FORMAT '000000')
    ) || '.999999' AS id,
 2 AS ebene_id,
 V.vs_bez AS vs_sort,
 GF.ma_name AS gf_sort,
  VKL.ma_name || 'ZZZ' AS vkl_sort,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN V.vs_bez
   ELSE NULL
   END) AS vs_bez,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_anrede
   ELSE NULL
   END) AS gf_anrede,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_name
   ELSE NULL
   END) AS gf_name,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_vorname
   ELSE NULL
   END) AS gf_vorname,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN 'Gesamt ' || COALESCE(VKL.ma_anrede, '')
   ELSE NULL
   END) AS vkl_anrede,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_name
   ELSE NULL
   END) AS vkl_name,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_vorname
   ELSE NULL
   END) AS vkl_vorname,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez,
 '' AS wup_standort,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN V.vs_bez
   ELSE NULL
   END) AS vs_bez_de,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_anrede
   ELSE NULL
   END) AS gf_anrede_de,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_name
   ELSE NULL
   END) AS gf_name_de,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_vorname
   ELSE NULL
   END) AS gf_vorname_de,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN 'Gesamt ' || COALESCE(VKL.ma_anrede, '')
   ELSE NULL
   END) AS vkl_anrede_de,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_name
   ELSE NULL
   END) AS vkl_name_de,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_vorname
   ELSE NULL
   END) AS vkl_vorname_de,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_de,
 '' AS wup_standort_de,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_cz,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN 'Celkem ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN 'Celkem ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN 'Celkem ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  END AS vkl_anrede_cz,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_cz,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_cz,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_cz,
 '' AS wup_standort_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_pl,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN 'Suma ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN 'Suma ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN 'Suma ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  END AS vkl_anrede_pl,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_pl,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_pl,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_pl,
 '' AS wup_standort_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_sk,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN 'Celkom ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN 'Celkom ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN 'Celkom ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  END AS vkl_anrede_sk,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_sk,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_sk,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_sk,
 '' AS wup_standort_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_hr,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN 'Ukupno ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN 'Ukupno ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN 'Ukupno ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  END AS vkl_anrede_hr,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_hr,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_hr,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_hr,
 '' AS wup_standort_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_ro,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN 'Total ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN 'Total ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN 'Total ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  END AS vkl_anrede_ro,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_ro,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_ro,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_ro,
 '' AS wup_standort_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_bg,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN '\\u041E\\u0431\\u0449\\u043E' || ' ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN '\\u041E\\u0431\\u0449\\u043E' || ' ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN '\\u041E\\u0431\\u0449\\u043E' || ' ' || COALESCE(VKL.ma_anrede, '')
    ELSE NULL
    END)
  END AS vkl_anrede_bg,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_bg,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_bg,
 CAST(NULL AS BIGNUMERIC) AS wup_id_bez_bg,
 '' AS wup_standort_bg
FROM kfl_production_dbp_view.v_wup_2 AS W
 INNER JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_2 AS WD ON W.wup_id = WD.wup_id AND W.mandant_id = WD.mandant_id
 INNER JOIN kfl_production_dbp_view.v_vs_2 AS V ON W.mandant_id = V.mandant_id AND W.vs_id = V.vs_id
 INNER JOIN kfl_production_dbp_view.v_ma_spr_zu_2 AS GF_2 ON WD.mandant_id = GF.mandant_id AND WD.gf_gbl_vertrieb_id = GF.ma_id
   
 INNER JOIN kfl_production_dbp_view.v_ma_spr_zu_2 AS VKL_2 ON WD.mandant_id = VKL.mandant_id AND WD.vkl_id = VKL.ma_id
WHERE WD.glv_land_id <> - 1
GROUP BY W.mandant_id,
 id,
 ebene_id,
 vs_sort,
 gf_sort,
 vkl_sort
UNION ALL
SELECT W.mandant_id,
         TRIM(CAST(W.mandant_id AS STRING FORMAT '00')) || '.' || TRIM(CAST(W.vs_id AS STRING FORMAT '00')) || '.' ||
      TRIM(CAST(WD.gf_gbl_vertrieb_id AS STRING FORMAT '000000')) || '.' || TRIM(CAST(WD.vkl_id AS STRING FORMAT '000000')
     ) || '.' || TRIM(CAST(W.wup_id AS STRING FORMAT '000000')) AS id,
 1 AS ebene_id,
 V.vs_bez AS vs_sort,
 GF.ma_name AS gf_sort,
 VKL.ma_name AS vkl_sort,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN V.vs_bez
   ELSE NULL
   END) AS vs_bez,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_anrede
   ELSE NULL
   END) AS gf_anrede,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_name
   ELSE NULL
   END) AS gf_name,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_vorname
   ELSE NULL
   END) AS gf_vorname,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_anrede
   ELSE NULL
   END) AS vkl_anrede,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_name
   ELSE NULL
   END) AS vkl_name,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_vorname
   ELSE NULL
   END) AS vkl_vorname,
 W.wup_id AS wup_id_bez,
 W.wup_standort,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN V.vs_bez
   ELSE NULL
   END) AS vs_bez_de,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_anrede
   ELSE NULL
   END) AS gf_anrede_de,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_name
   ELSE NULL
   END) AS gf_name_de,
 MAX(CASE
   WHEN GF.spr_id = 22
   THEN GF.ma_vorname
   ELSE NULL
   END) AS gf_vorname_de,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_anrede
   ELSE NULL
   END) AS vkl_anrede_de,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_name
   ELSE NULL
   END) AS vkl_name_de,
 MAX(CASE
   WHEN VKL.spr_id = 22
   THEN VKL.ma_vorname
   ELSE NULL
   END) AS vkl_vorname_de,
 W.wup_id AS wup_id_bez_de,
 W.wup_standort AS wup_standort_de,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 124
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_cz,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  END AS vkl_anrede_cz,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_cz,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 124
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_cz,
 W.wup_id AS wup_id_bez_cz,
 W.wup_standort AS wup_standort_cz,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 90
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_pl,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  END AS vkl_anrede_pl,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_pl,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 90
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_pl,
 W.wup_id AS wup_id_bez_pl,
 W.wup_standort AS wup_standort_pl,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 108
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_sk,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  END AS vkl_anrede_sk,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_sk,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 108
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_sk,
 W.wup_id AS wup_id_bez_sk,
 W.wup_standort AS wup_standort_sk,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 65
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_hr,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  END AS vkl_anrede_hr,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_hr,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 65
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_hr,
 W.wup_id AS wup_id_bez_hr,
 W.wup_standort AS wup_standort_hr,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 95
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_ro,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  END AS vkl_anrede_ro,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_ro,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 95
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_ro,
 W.wup_id AS wup_id_bez_ro,
 W.wup_standort AS wup_standort_ro,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN V.vs_bez
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN V.vs_bez
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN V.vs_bez
    ELSE NULL
    END)
  END AS vs_bez_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_anrede
    ELSE NULL
    END)
  END AS gf_anrede_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_name
    ELSE NULL
    END)
  END AS gf_name_bg,
  CASE
  WHEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN GF.spr_id = 18
    THEN GF.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN GF.spr_id = 22
    THEN GF.ma_vorname
    ELSE NULL
    END)
  END AS gf_vorname_bg,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_anrede
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_anrede
    ELSE NULL
    END)
  END AS vkl_anrede_bg,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_name
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_name
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_name
    ELSE NULL
    END)
  END AS vkl_name_bg,
  CASE
  WHEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_vorname
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN VKL.spr_id = 18
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN VKL.spr_id = 22
    THEN VKL.ma_vorname
    ELSE NULL
    END)
  END AS vkl_vorname_bg,
 W.wup_id AS wup_id_bez_bg,
 W.wup_standort AS wup_standort_bg
FROM kfl_production_dbp_view.v_wup_2 AS W
 INNER JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_2 AS WD ON W.wup_id = WD.wup_id AND W.mandant_id = WD.mandant_id
 INNER JOIN kfl_production_dbp_view.v_vs_2 AS V ON W.mandant_id = V.mandant_id AND W.vs_id = V.vs_id
 INNER JOIN kfl_production_dbp_view.v_ma_spr_zu_2 AS GF_2 ON WD.mandant_id = GF.mandant_id AND WD.gf_gbl_vertrieb_id = GF.ma_id
   
 INNER JOIN kfl_production_dbp_view.v_ma_spr_zu_2 AS VKL_2 ON WD.mandant_id = VKL.mandant_id AND WD.vkl_id = VKL.ma_id
WHERE WD.glv_land_id <> - 1
GROUP BY W.mandant_id,
 id,
 ebene_id,
 vs_sort,
 gf_sort,
 vkl_sort,
 W.wup_standort,
 wup_id_bez;