-- PL
 -- SK
 -- CZ
 -- standard == DE
 -- DE
 -- RO
 -- HR

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_verrechnungsart_spr_zu (mandant_id,
verrechnungsart_id, verrechnungsart_bez, verrechnungsart_bez_de, verrechnungsart_bez_cz, verrechnungsart_bez_sk,
verrechnungsart_bez_hr, verrechnungsart_bez_pl, verrechnungsart_bez_ro, verrechnungsart_bez_bez_b) AS SELECT mandant_id
 ,
 verrechnungsart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN verrechnungsart_bez
   ELSE NULL
   END) AS verrechnungsart_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN verrechnungsart_bez
   ELSE NULL
   END) AS verrechnungsart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN verrechnungsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verrechnungsart_bez
    ELSE NULL
    END)) AS verrechnungsart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN verrechnungsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verrechnungsart_bez
    ELSE NULL
    END)) AS verrechnungsart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN verrechnungsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verrechnungsart_bez
    ELSE NULL
    END)) AS verrechnungsart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN verrechnungsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verrechnungsart_bez
    ELSE NULL
    END)) AS verrechnungsart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN verrechnungsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verrechnungsart_bez
    ELSE NULL
    END)) AS verrechnungsart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN verrechnungsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verrechnungsart_bez
    ELSE NULL
    END)) AS verrechnungsart_bez_bez_b
FROM kfl_production_dbp_view.v_verrechnungsart_spr_zu AS V01
GROUP BY verrechnungsart_id,
 mandant_id;