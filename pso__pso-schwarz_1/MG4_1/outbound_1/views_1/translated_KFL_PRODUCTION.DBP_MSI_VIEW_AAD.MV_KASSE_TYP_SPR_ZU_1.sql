CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_kasse_typ_spr_zu_1 (kasse_typ_id, kasse_typ_bez_de,
kasse_typ_bez, kasse_typ_bez_cz, kasse_typ_bez_sk, kasse_typ_bez_hr, kasse_typ_bez_pl, kasse_typ_bez_ro,
kasse_typ_bez_bg) AS SELECT kasse_typ_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN kasse_typ_bez
   ELSE TRIM(SUBSTR(CAST(kasse_typ_id AS STRING), 1, 10))
   END) AS kasse_typ_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN kasse_typ_bez
   ELSE TRIM(SUBSTR(CAST(kasse_typ_id AS STRING), 1, 10))
   END) AS kasse_typ_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kasse_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kasse_typ_bez
    ELSE TRIM(SUBSTR(CAST(kasse_typ_id AS STRING), 1, 10))
    END)) AS kasse_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kasse_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kasse_typ_bez
    ELSE TRIM(SUBSTR(CAST(kasse_typ_id AS STRING), 1, 10))
    END)) AS kasse_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kasse_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kasse_typ_bez
    ELSE TRIM(SUBSTR(CAST(kasse_typ_id AS STRING), 1, 10))
    END)) AS kasse_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kasse_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kasse_typ_bez
    ELSE TRIM(SUBSTR(CAST(kasse_typ_id AS STRING), 1, 10))
    END)) AS kasse_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kasse_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kasse_typ_bez
    ELSE TRIM(SUBSTR(CAST(kasse_typ_id AS STRING), 1, 10))
    END)) AS kasse_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kasse_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN kasse_typ_bez
    ELSE TRIM(SUBSTR(CAST(kasse_typ_id AS STRING), 1, 10))
    END)) AS kasse_typ_bez_bg
FROM kfl_production_dbp_v_ods.v_kasse_typ_spr_zu_1 AS v01
GROUP BY kasse_typ_id;