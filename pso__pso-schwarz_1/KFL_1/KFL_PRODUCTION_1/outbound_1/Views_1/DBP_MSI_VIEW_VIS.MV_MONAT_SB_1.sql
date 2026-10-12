CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_monat_sb_1 AS SELECT V01.mo_kj,
 V01.mo_gj,
 V01.akt_mo,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_de,
 CAST(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_cz,
 CAST(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_pl,
 CAST(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_sk,
 CAST(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_hr,
 CAST(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_ro,
 CAST(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.mo_bez
    ELSE NULL
    END) AS STRING) AS mo_bez_bg,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_de,
 CAST(MAX(CASE
    WHEN V02.spr_id = 124
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_cz,
 CAST(MAX(CASE
    WHEN V02.spr_id = 90
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_pl,
 CAST(MAX(CASE
    WHEN V02.spr_id = 108
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_sk,
 CAST(MAX(CASE
    WHEN V02.spr_id = 65
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_hr,
 CAST(MAX(CASE
    WHEN V02.spr_id = 95
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_ro,
 CAST(MAX(CASE
    WHEN V02.spr_id = 18
    THEN TRIM(SUBSTR(V02.mo_bez, 1, 3))
    ELSE NULL
    END) AS STRING) AS mo_kbez_bg
FROM kfl_production_dbp_view.v_monat_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS V02 ON V01.mo_kj = V02.mo_id AND V01.akt_gj = 0
GROUP BY V01.mo_kj,
 V01.mo_gj,
 V01.akt_mo;