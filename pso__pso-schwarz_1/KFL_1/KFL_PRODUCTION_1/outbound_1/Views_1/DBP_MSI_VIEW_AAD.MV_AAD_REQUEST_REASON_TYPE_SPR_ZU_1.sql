CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_request_reason_type_spr_zu_1 AS SELECT
 request_reason_type_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN request_reason_type_descr
    ELSE NULL
    END), 'N/A') AS request_reason_type_descr,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN request_reason_type_descr
    ELSE NULL
    END), 'N/A') AS request_reason_type_descr_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN request_reason_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_reason_type_descr
     ELSE NULL
     END), 'N/A')) AS request_reason_type_descr_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN request_reason_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_reason_type_descr
     ELSE NULL
     END), 'N/A')) AS request_reason_type_descr_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN request_reason_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_reason_type_descr
     ELSE NULL
     END), 'N/A')) AS request_reason_type_descr_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN request_reason_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_reason_type_descr
     ELSE NULL
     END), 'N/A')) AS request_reason_type_descr_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN request_reason_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_reason_type_descr
     ELSE NULL
     END), 'N/A')) AS request_reason_type_descr_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN request_reason_type_descr
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN request_reason_type_descr
     ELSE NULL
     END), 'N/A')) AS request_reason_type_descr_bg
FROM kfl_production_dbp_view.v_aad_request_reason_type_spr_zu_1 AS V01
GROUP BY request_reason_type_id
UNION DISTINCT
SELECT 0 AS request_reason_type_id,
 '' AS request_reason_type_descr,
 '' AS request_reason_type_descr_de,
 '' AS request_reason_type_descr_cz,
 '' AS request_reason_type_descr_sk,
 '' AS request_reason_type_descr_hr,
 '' AS request_reason_type_descr_pl,
 '' AS request_reason_type_descr_ro,
 '' AS request_reason_type_descr_bg;