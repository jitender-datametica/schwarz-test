CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_hwg_wg_spr_zu_2 AS SELECT V01.hwg_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.hwg_bez
    ELSE NULL
    END), 'N/A') AS hwg_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.hwg_bez
    ELSE NULL
    END), 'N/A') AS hwg_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_bg,
 V03.owg_id,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.owg_bez
    ELSE NULL
    END), 'N/A') AS owg_bez,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 22
    THEN V04.owg_bez
    ELSE NULL
    END), 'N/A') AS owg_bez_de,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 124
    THEN V04.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 108
    THEN V04.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 65
    THEN V04.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 90
    THEN V04.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 95
    THEN V04.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V04.spr_id = 18
    THEN V04.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V04.spr_id = 22
     THEN V04.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_bg,
 V05.wg_id,
 COALESCE(MAX(CASE
    WHEN V06.spr_id = 22
    THEN V06.wg_bez
    ELSE NULL
    END), 'N/A') AS wg_bez,
 COALESCE(MAX(CASE
    WHEN V06.spr_id = 22
    THEN V06.wg_bez
    ELSE NULL
    END), 'N/A') AS wg_bez_de,
 COALESCE(MAX(CASE
    WHEN V06.spr_id = 124
    THEN V06.wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V06.spr_id = 22
     THEN V06.wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V06.spr_id = 108
    THEN V06.wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V06.spr_id = 22
     THEN V06.wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V06.spr_id = 65
    THEN V06.wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V06.spr_id = 22
     THEN V06.wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V06.spr_id = 90
    THEN V06.wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V06.spr_id = 22
     THEN V06.wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V06.spr_id = 95
    THEN V06.wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V06.spr_id = 22
     THEN V06.wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V06.spr_id = 18
    THEN V06.wg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V06.spr_id = 22
     THEN V06.wg_bez
     ELSE NULL
     END), 'N/A')) AS wg_bez_bg,
 V01.mandant_id
FROM kfl_production_dbp_view.v_hwg_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.hwg_id = V02.hwg_id
 INNER JOIN kfl_production_dbp_view.v_owg_per_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.hwg_id = V03.hwg_id AND
   CURRENT_DATE BETWEEN V03.dat_von AND V03.dat_bis
 INNER JOIN kfl_production_dbp_view.v_owg_spr_zu_2 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.owg_id = V04.owg_id
 INNER JOIN kfl_production_dbp_view.v_wg_per_2 AS V05 ON V03.mandant_id = V05.mandant_id AND V03.owg_id = V05.owg_id AND
   CURRENT_DATE BETWEEN V05.dat_von AND V05.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wg_spr_zu_2 AS V06 ON V05.mandant_id = V06.mandant_id AND V05.wg_id = V06.wg_id
WHERE CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis
GROUP BY V01.hwg_id,
 V03.owg_id,
 V05.wg_id,
 V01.mandant_id;