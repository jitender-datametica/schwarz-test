CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_pruefgrund_2 (pruef_id, mandant_id, pruef_bez,
pruef_bez_de, pruef_bez_cz, pruef_bez_sk, pruef_bez_hr, pruef_bez_pl, pruef_bez_ro, pruef_bez_bg, z_arbeitsgebiet_id) AS
SELECT pruef_id,
 mandant_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN pruef_bez
    ELSE NULL
    END), 'N/A') AS pruef_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN pruef_bez
    ELSE NULL
    END), 'N/A') AS pruef_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN pruef_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN pruef_bez
     ELSE NULL
     END), 'N/A')) AS pruef_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN pruef_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN pruef_bez
     ELSE NULL
     END), 'N/A')) AS pruef_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN pruef_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN pruef_bez
     ELSE NULL
     END), 'N/A')) AS pruef_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN pruef_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN pruef_bez
     ELSE NULL
     END), 'N/A')) AS pruef_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN pruef_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN pruef_bez
     ELSE NULL
     END), 'N/A')) AS pruef_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN pruef_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN pruef_bez
     ELSE NULL
     END), 'N/A')) AS pruef_bez_bg,
 z_arbeitsgebiet_id
FROM kfl_production_dbp_view.v_l_pruefgrund_2 AS V01
WHERE CAST(pruef_id AS INTEGER) IN (202, 203, 205, 206, 207, 209, 210, 214, 216, 218, 223, 225, 231, 700) AND mandant_id
     > 1 AND z_arbeitsgebiet_id = 1
 OR mandant_id > 1 AND CAST(pruef_id AS INTEGER) IN (250, 252, 1, 5, 2, 253, 254) AND z_arbeitsgebiet_id = 0
GROUP BY pruef_id,
 mandant_id,
 z_arbeitsgebiet_id;