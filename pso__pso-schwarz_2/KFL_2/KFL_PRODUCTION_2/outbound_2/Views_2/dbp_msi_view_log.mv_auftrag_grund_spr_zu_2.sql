CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_auftrag_grund_spr_zu_2 AS SELECT mandant_id,
 auftrag_grund_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN auftrag_grund_bez
   ELSE NULL
   END) AS auftrag_grund_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN auftrag_grund_bez
   ELSE NULL
   END) AS auftrag_grund_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN auftrag_grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftrag_grund_bez
    ELSE NULL
    END)) AS auftrag_grund_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN auftrag_grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftrag_grund_bez
    ELSE NULL
    END)) AS auftrag_grund_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN auftrag_grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftrag_grund_bez
    ELSE NULL
    END)) AS auftrag_grund_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN auftrag_grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftrag_grund_bez
    ELSE NULL
    END)) AS auftrag_grund_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN auftrag_grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftrag_grund_bez
    ELSE NULL
    END)) AS auftrag_grund_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN auftrag_grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN auftrag_grund_bez
    ELSE NULL
    END)) AS auftrag_grund_bez_bg
FROM kfl_production_dbp_view.v_auftrag_grund_spr_zu_2 AS V01
GROUP BY mandant_id,
 auftrag_grund_id;