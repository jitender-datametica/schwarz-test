-- HR
 -- BG
 -- standard == DE
 -- CZ
 -- PL
 -- SK
 -- DE
 -- RO

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_konditionsart_spr_zu_2 (mandant_id,
konditionsart_id, system_id, konditionsart_bez, konditionsart_bez_de, konditionsart_bez_cz, konditionsart_bez_sk,
konditionsart_bez_hr, konditionsart_bez_pl, konditionsart_bez_ro, konditionsart_bez_bg) AS SELECT mandant_id,
 konditionsart_id,
 system_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN konditionsart_bez
   ELSE NULL
   END) AS konditionsart_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN konditionsart_bez
   ELSE NULL
   END) AS konditionsart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN konditionsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN konditionsart_bez
    ELSE NULL
    END)) AS konditionsart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN konditionsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN konditionsart_bez
    ELSE NULL
    END)) AS konditionsart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN konditionsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN konditionsart_bez
    ELSE NULL
    END)) AS konditionsart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN konditionsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN konditionsart_bez
    ELSE NULL
    END)) AS konditionsart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN konditionsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN konditionsart_bez
    ELSE NULL
    END)) AS konditionsart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN konditionsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN konditionsart_bez
    ELSE NULL
    END)) AS konditionsart_bez_bg
FROM kfl_production_dbp_view.v_konditionsart_spr_zu_2 AS V01
GROUP BY mandant_id,
 konditionsart_id,
 system_id;