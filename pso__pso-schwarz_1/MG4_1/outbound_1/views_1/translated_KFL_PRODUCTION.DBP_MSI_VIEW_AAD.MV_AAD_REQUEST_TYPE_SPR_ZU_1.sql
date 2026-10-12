-- 30.06.2023 staeblern Erstellen Sprachtabelle AAD_REQUEST_TYPE

CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_aad_request_type_spr_zu_1 (request_type_id, request_type_descr,
request_type_descr_de, request_type_descr_cz, request_type_descr_sk, request_type_descr_hr, request_type_descr_pl,
request_type_descr_ro, request_type_descr_bg) AS SELECT request_type_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN request_type_descr
    ELSE NULL
    END), 'N/A') AS request_type_descr,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN request_type_descr
    ELSE NULL
    END), 'N/A') AS request_type_descr_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN request_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_type_descr
     ELSE NULL
     END), 'N/A')) AS request_type_descr_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN request_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_type_descr
     ELSE NULL
     END), 'N/A')) AS request_type_descr_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN request_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_type_descr
     ELSE NULL
     END), 'N/A')) AS request_type_descr_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN request_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_type_descr
     ELSE NULL
     END), 'N/A')) AS request_type_descr_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN request_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_type_descr
     ELSE NULL
     END), 'N/A')) AS request_type_descr_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN request_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_type_descr
     ELSE NULL
     END), 'N/A')) AS request_type_descr_bg
FROM kfl_production_dbp_view.v_aad_request_type_spr_zu_1 AS v01
GROUP BY request_type_id
UNION DISTINCT
SELECT 0 AS request_type_id,
 '' AS request_type_descr,
 '' AS request_type_descr_de,
 '' AS request_type_descr_cz,
 '' AS request_type_descr_sk,
 '' AS request_type_descr_hr,
 '' AS request_type_descr_pl,
 '' AS request_type_descr_ro,
 '' AS request_type_descr_bg;