CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_owg_spr_zu_2 AS SELECT V01.owg_id,
 V01.mandant_id,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.owg_bez
    ELSE NULL
    END), 'N/A') AS owg_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.owg_bez
    ELSE NULL
    END), 'N/A') AS owg_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_bg
FROM kfl_production_dbp_view.v_owg_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.owg_id = V02.owg_id
 INNER JOIN kfl_production_dbp_view.v_wg_filter_zu_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.wg_id = V03.wg_id
GROUP BY V01.owg_id,
 V01.mandant_id;