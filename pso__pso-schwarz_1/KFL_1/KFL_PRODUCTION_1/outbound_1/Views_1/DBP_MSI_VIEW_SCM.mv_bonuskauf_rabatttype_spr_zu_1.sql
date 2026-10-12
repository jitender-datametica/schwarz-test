-- Bonuskauf Rabatttyp Spr_1 Zu


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_bonuskauf_rabatttype_spr_zu_1 (bonuskauf_rabatttype_id,
bonuskauf_rabatttype_bez, bonuskauf_rabatttype_bez_de, bonuskauf_rabatttype_bez_cz, bonuskauf_rabatttype_bez_sk,
bonuskauf_rabatttype_bez_hr, bonuskauf_rabatttype_bez_pl, bonuskauf_rabatttype_bez_ro, bonuskauf_rabatttype_bez_bg) AS
SELECT bonuskauf_rabatttype_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN bonuskauf_rabatttype_bez
   ELSE NULL
   END) AS bonuskauf_rabatttype_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN bonuskauf_rabatttype_bez
   ELSE NULL
   END) AS bonuskauf_rabatttype_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END)) AS bonuskauf_rabatttype_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END)) AS bonuskauf_rabatttype_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END)) AS bonuskauf_rabatttype_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END)) AS bonuskauf_rabatttype_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END)) AS bonuskauf_rabatttype_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bonuskauf_rabatttype_bez
    ELSE NULL
    END)) AS bonuskauf_rabatttype_bez_bg
FROM kfl_production_dbp_view.v_bonuskauf_rabatttype_spr_zu_1 AS V01
GROUP BY bonuskauf_rabatttype_id;