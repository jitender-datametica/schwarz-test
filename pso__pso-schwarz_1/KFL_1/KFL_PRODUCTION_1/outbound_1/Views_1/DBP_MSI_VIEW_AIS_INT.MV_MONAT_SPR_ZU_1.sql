CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_monat_spr_zu_1 (kjmo, gj, mo_gj, gjmo, kj, mo_kj, mo_bez,
mo_bez_de, mo_bez_cz, mo_bez_sk, mo_bez_hr, mo_bez_pl, mo_bez_ro, mo_bez_bg) AS SELECT V01.kjmo,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.kj,
 V01.mo_kj,
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
    END) AS STRING) AS mo_bez_bg
FROM kfl_production_dbp_view.v_monat_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_spr_zu_1 AS V02 ON V01.mo_kj = V02.mo_id
GROUP BY V01.kjmo,
 V01.gj,
 V01.mo_gj,
 V01.gjmo,
 V01.kj,
 V01.mo_kj;