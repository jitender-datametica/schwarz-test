CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_monat_spr_zu_1 (kjmo, gj, mo_gj, gjmo, kj, mo_kj, mo_bez_en,
mo_bez, mo_bez_cz, mo_bez_pl, mo_bez_sk, mo_bez_hr, mo_bez_ro, mo_bez_bg) AS -- EN
 -- DE (Standard)
 -- CZ
 -- PL

-- SK
 -- HR
 -- RO
 -- BG
 SELECT v01.kjmo,
 v01.gj,
 v01.mo_gj,
 v01.gjmo,
 v01.kj,
 v01.mo_kj,
 CAST(MAX(CASE
    WHEN v02.spr_id = 24
    THEN v02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_en,
 COALESCE(MAX(CASE
    WHEN v02.spr_id = 22
    THEN v02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN v02.spr_id = 24
     THEN v02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez,
 COALESCE(MAX(CASE
    WHEN v02.spr_id = 124
    THEN v02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN v02.spr_id = 24
     THEN v02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_cz,
 COALESCE(MAX(CASE
    WHEN v02.spr_id = 90
    THEN v02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN v02.spr_id = 24
     THEN v02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_pl,
 COALESCE(MAX(CASE
    WHEN v02.spr_id = 108
    THEN v02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN v02.spr_id = 24
     THEN v02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_sk,
 COALESCE(MAX(CASE
    WHEN v02.spr_id = 65
    THEN v02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN v02.spr_id = 24
     THEN v02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_hr,
 COALESCE(MAX(CASE
    WHEN v02.spr_id = 95
    THEN v02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN v02.spr_id = 24
     THEN v02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_ro,
 COALESCE(MAX(CASE
    WHEN v02.spr_id = 18
    THEN v02.mo_bez
    ELSE NULL
    END), CAST(MAX(CASE
     WHEN v02.spr_id = 24
     THEN v02.mo_bez
     ELSE NULL
     END) AS STRING)) AS mo_bez_bg
FROM kfl_production_dbp_view.v_monat_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS v02 ON v01.mo_kj = v02.mo_id
GROUP BY v01.kjmo,
 v01.gj,
 v01.mo_gj,
 v01.gjmo,
 v01.kj,
 v01.mo_kj;