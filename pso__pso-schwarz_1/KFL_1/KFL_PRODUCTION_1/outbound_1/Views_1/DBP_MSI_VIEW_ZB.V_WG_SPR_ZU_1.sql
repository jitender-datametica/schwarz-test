CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_wg_spr_zu_1 (mandant_id, wg_id, warengruppe_bez,
warengruppe_bez_de, warengruppe_bez_cz, warengruppe_bez_sk, warengruppe_bez_hr, warengruppe_bez_pl, warengruppe_bez_ro,
warengruppe_bez_bg) AS SELECT mandant_id,
 wg_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END), 'N/A') AS warengruppe_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN wg_bez
    ELSE NULL
    END), 'N/A') AS warengruppe_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS warengruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS warengruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS warengruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS warengruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS warengruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN wg_bez
     ELSE NULL
     END), 'N/A')) AS warengruppe_bez_bg
FROM kfl_production_dbp_data.wg_spr_zu_1
GROUP BY mandant_id,
 wg_id;