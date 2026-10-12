CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wup_werbegruppe_fleisch_1 (mandant_id, wup_id,
nb_id, werbegruppe_fleisch, werbegruppe_fleisch_bez, werbegruppe_fleisch_bez_de, werbegruppe_fleisch_bez_cz,
werbegruppe_fleisch_bez_sk, werbegruppe_fleisch_bez_hr, werbegruppe_fleisch_bez_pl, werbegruppe_fleisch_bez_ro,
werbegruppe_fleisch_bez_bg) AS -- standard == DE
 -- DE
 -- CZ
 -- SK
 -- HR
 -- PL
 -- RO
 -- BG
 SELECT mandant_id,
 wup_id,
 nb_id,
 werbegruppe_fleisch,
 MAX(`A11866`) AS werbegruppe_fleisch_bez,
 MAX(`A11866`) AS werbegruppe_fleisch_bez_de,
 COALESCE(MAX(`A11867`), MAX(`A11866`)) AS werbegruppe_fleisch_bez_cz,
 COALESCE(MAX(`A11868`), MAX(`A11866`)) AS werbegruppe_fleisch_bez_sk,
 COALESCE(MAX(`A11869`), MAX(`A11866`)) AS werbegruppe_fleisch_bez_hr,
 COALESCE(MAX(`A118610`), MAX(`A11866`)) AS werbegruppe_fleisch_bez_pl,
 COALESCE(MAX(`A118611`), MAX(`A11866`)) AS werbegruppe_fleisch_bez_ro,
 COALESCE(MAX(`A118612`), MAX(`A11866`)) AS werbegruppe_fleisch_bez_bg
FROM (SELECT V00.mandant_id,
   V00.wup_id,
   V00.nb_id,
   V00.marktmerkmal_wert AS werbegruppe_fleisch,
    CASE
    WHEN V01.spr_id = 22
    THEN V01.marktmerkmal_wert_bez
    ELSE NULL
    END AS `A11866`,
    CASE
    WHEN V01.spr_id = 124
    THEN V01.marktmerkmal_wert_bez
    ELSE NULL
    END AS `A11867`,
    CASE
    WHEN V01.spr_id = 108
    THEN V01.marktmerkmal_wert_bez
    ELSE NULL
    END AS `A11868`,
    CASE
    WHEN V01.spr_id = 65
    THEN V01.marktmerkmal_wert_bez
    ELSE NULL
    END AS `A11869`,
    CASE
    WHEN V01.spr_id = 90
    THEN V01.marktmerkmal_wert_bez
    ELSE NULL
    END AS `A118610`,
    CASE
    WHEN V01.spr_id = 95
    THEN V01.marktmerkmal_wert_bez
    ELSE NULL
    END AS `A118611`,
    CASE
    WHEN V01.spr_id = 18
    THEN V01.marktmerkmal_wert_bez
    ELSE NULL
    END AS `A118612`
  FROM kfl_production_dbp_view.v_wup_marktmerkmal_zu_per_1 AS V00
   INNER JOIN kfl_production_dbp_view.v_marktmerkmal_wert_spr_zu_1 AS V01 ON V00.marktmerkmal_id = V01.marktmerkmal_id AND
     V00.marktmerkmal_wert = V01.marktmerkmal_wert
  WHERE V00.marktmerkmal_id = '0051'
   AND (CURRENT_DATE BETWEEN V00.dat_von AND V00.dat_bis OR V00.dat_von > CURRENT_DATE AND V00.dat_bis =
       DATE '9999-12-31')
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY V00.mandant_id, V00.wup_id, V01.spr_id ORDER BY V00.dat_von IS NULL, V00.dat_von
        )) = 1) AS t2
GROUP BY mandant_id,
 wup_id,
 nb_id,
 werbegruppe_fleisch;