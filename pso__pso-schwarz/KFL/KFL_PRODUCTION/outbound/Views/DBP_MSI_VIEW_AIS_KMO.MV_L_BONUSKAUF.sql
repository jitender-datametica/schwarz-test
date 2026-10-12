CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_bonuskauf (mandant_id, bonuskauf_id, bonuskauf_bez,
bonuskauf_bez_de, bonuskauf_bez_cz, bonuskauf_bez_sk, bonuskauf_bez_hr, bonuskauf_bez_pl, bonuskauf_bez_ro,
bonuskauf_bez_bg, zeit_von, zeit_bis, konditionsart_id, geschaeftsvorfall_id, dat_von, dat_bis, aktion_id) AS SELECT V01
 .mandant_id,
 V01.bonuskauf_id,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bonuskauf_bez
    ELSE NULL
    END), 'N/A') AS bonuskauf_bez,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.bonuskauf_bez
    ELSE NULL
    END), 'N/A') AS bonuskauf_bez_de,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 124
    THEN V03.bonuskauf_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.bonuskauf_bez
     ELSE NULL
     END), 'N/A')) AS bonuskauf_bez_cz,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 108
    THEN V03.bonuskauf_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.bonuskauf_bez
     ELSE NULL
     END), 'N/A')) AS bonuskauf_bez_sk,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 65
    THEN V03.bonuskauf_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.bonuskauf_bez
     ELSE NULL
     END), 'N/A')) AS bonuskauf_bez_hr,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 90
    THEN V03.bonuskauf_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.bonuskauf_bez
     ELSE NULL
     END), 'N/A')) AS bonuskauf_bez_pl,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 95
    THEN V03.bonuskauf_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.bonuskauf_bez
     ELSE NULL
     END), 'N/A')) AS bonuskauf_bez_ro,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 18
    THEN V03.bonuskauf_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.bonuskauf_bez
     ELSE NULL
     END), 'N/A')) AS bonuskauf_bez_bg,
 V01.zeit_von,
 V01.zeit_bis,
 V01.konditionsart_id,
 V01.geschaeftsvorfall_id,
 V01.dat_von,
 V01.dat_bis,
 V01.aktion_id
FROM kfl_production_dbp_view.v_l_bonuskauf AS V01
 INNER JOIN kfl_production_dbp_view.v_bonuskauf_spr_zu AS V03 ON V01.bonuskauf_id = V03.bonuskauf_id AND V01.mandant_id
   = V03.mandant_id
WHERE V01.mandant_id <> 1
GROUP BY V01.mandant_id,
 V01.bonuskauf_id,
 V01.zeit_von,
 V01.zeit_bis,
 V01.konditionsart_id,
 V01.geschaeftsvorfall_id,
 V01.dat_von,
 V01.dat_bis,
 V01.aktion_id;