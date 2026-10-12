-- DE
 -- RO
 -- 2023-08_18, dknop, initial
 -- standard == DE
 -- PL
 -- SK
 -- HR
 -- CZ
 -- BG

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_vz_dispo_status_spr_zu (vz_dispo_status_id,
mandant_id, vz_dispo_status_bez, vz_dispo_status_bez_de, vz_dispo_status_bez_cz, vz_dispo_status_bez_sk,
vz_dispo_status_bez_hr, vz_dispo_status_bez_pl, vz_dispo_status_bez_ro, vz_dispo_status_bez_bg) AS SELECT
 vz_dispo_status_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN vz_dispo_status_bez
   ELSE NULL
   END) AS vz_dispo_status_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN vz_dispo_status_bez
   ELSE NULL
   END) AS vz_dispo_status_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN vz_dispo_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN vz_dispo_status_bez
    ELSE NULL
    END)) AS vz_dispo_status_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN vz_dispo_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN vz_dispo_status_bez
    ELSE NULL
    END)) AS vz_dispo_status_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN vz_dispo_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN vz_dispo_status_bez
    ELSE NULL
    END)) AS vz_dispo_status_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN vz_dispo_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN vz_dispo_status_bez
    ELSE NULL
    END)) AS vz_dispo_status_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN vz_dispo_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN vz_dispo_status_bez
    ELSE NULL
    END)) AS vz_dispo_status_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN vz_dispo_status_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN vz_dispo_status_bez
    ELSE NULL
    END)) AS vz_dispo_status_bez_bg
FROM kfl_production_dbp_view.v_vz_dispo_status_spr_zu AS V01
GROUP BY vz_dispo_status_id,
 mandant_id;