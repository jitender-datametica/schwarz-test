CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_owg_spr_zu (owg_id, mandant_id, owg_bez, owg_bez_de,
owg_bez_cz, owg_bez_sk, owg_bez_hr, owg_bez_pl, owg_bez_ro, owg_bez_bg) AS SELECT V01.owg_id,
 V01.mandant_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.owg_bez
    ELSE NULL
    END), 'N/A') AS owg_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.owg_bez
    ELSE NULL
    END), 'N/A') AS owg_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.owg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.owg_bez
     ELSE NULL
     END), 'N/A')) AS owg_bez_bg
FROM kfl_production_dbp_view.v_owg_per AS V01
 INNER JOIN kfl_production_dbp_view.v_owg_spr_zu AS V02 ON V01.owg_id = V02.owg_id
WHERE CURRENT_DATE BETWEEN V01.dat_von AND V01.dat_bis
GROUP BY V01.owg_id,
 V01.mandant_id;