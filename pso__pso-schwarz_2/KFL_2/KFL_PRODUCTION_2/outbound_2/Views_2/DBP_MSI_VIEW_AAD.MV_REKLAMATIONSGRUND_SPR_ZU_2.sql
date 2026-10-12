CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_reklamationsgrund_spr_zu_2 AS SELECT mandant_id,
 reklamationsgrund_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN reklamationsgrund_bez
    ELSE NULL
    END), 'N/A') AS reklamationsgrund_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN reklamationsgrund_bez
    ELSE NULL
    END), 'N/A') AS reklamationsgrund_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN reklamationsgrund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN reklamationsgrund_bez
     ELSE NULL
     END), 'N/A')) AS reklamationsgrund_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN reklamationsgrund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN reklamationsgrund_bez
     ELSE NULL
     END), 'N/A')) AS reklamationsgrund_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN reklamationsgrund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN reklamationsgrund_bez
     ELSE NULL
     END), 'N/A')) AS reklamationsgrund_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN reklamationsgrund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN reklamationsgrund_bez
     ELSE NULL
     END), 'N/A')) AS reklamationsgrund_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN reklamationsgrund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN reklamationsgrund_bez
     ELSE NULL
     END), 'N/A')) AS reklamationsgrund_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN reklamationsgrund_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN reklamationsgrund_bez
     ELSE NULL
     END), 'N/A')) AS reklamationsgrund_bez_bg
FROM kfl_production_dbp_view.v_reklamationsgrund_spr_zu_2 AS V01
GROUP BY mandant_id,
 reklamationsgrund_id;