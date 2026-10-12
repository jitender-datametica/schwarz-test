CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_kjmo_spr_zu_1 AS SELECT V01.kjmo,
 V01.kj,
 V01.mo_kj,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS kjmo_bez,
 CAST(MAX(CASE
    WHEN V02.spr_id = 22
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS kjmo_bez_de,
 CAST(MAX(CASE
    WHEN V02.spr_id = 124
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS kjmo_bez_cz,
 CAST(MAX(CASE
    WHEN V02.spr_id = 90
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS kjmo_bez_pl,
 CAST(MAX(CASE
    WHEN V02.spr_id = 108
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS kjmo_bez_sk,
 CAST(MAX(CASE
    WHEN V02.spr_id = 65
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS kjmo_bez_hr,
 CAST(MAX(CASE
    WHEN V02.spr_id = 95
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS kjmo_bez_ro,
 CAST(MAX(CASE
    WHEN V02.spr_id = 18
    THEN TRIM(V02.mo_bez) || ' ' || TRIM(SUBSTR(CAST(V01.kj AS STRING), 1, 39))
    ELSE NULL
    END) AS STRING) AS kjmo_bez_bg
FROM kfl_production_dbp_view.v_monat_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS V02 ON V01.mo_kj = V02.mo_id
GROUP BY V01.kjmo,
 V01.kj,
 V01.mo_kj;