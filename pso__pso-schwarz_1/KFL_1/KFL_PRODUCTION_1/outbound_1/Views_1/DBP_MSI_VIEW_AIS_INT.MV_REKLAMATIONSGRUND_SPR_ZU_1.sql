CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_reklamationsgrund_spr_zu_1 (reklamationsgrund_id,
reklamationsgrund_bez, reklamationsgrund_bez_de, reklamationsgrund_bez_cz, reklamationsgrund_bez_sk,
reklamationsgrund_bez_hr, reklamationsgrund_bez_pl, reklamationsgrund_bez_ro, reklamationsgrund_bez_bg, mandant_id) AS
SELECT reklamationsgrund_id,
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
     END), 'N/A')) AS reklamationsgrund_bez_bg,
 mandant_id
FROM kfl_production_dbp_view.v_reklamationsgrund_spr_zu_1 AS V01
GROUP BY reklamationsgrund_id,
 mandant_id;