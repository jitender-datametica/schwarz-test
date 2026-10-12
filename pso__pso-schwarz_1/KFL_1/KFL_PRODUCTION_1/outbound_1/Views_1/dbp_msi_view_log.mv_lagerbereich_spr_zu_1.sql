CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagerbereich_spr_zu_1 (mandant_id, wup_id, nb_id, lagernummer_id
, lagertyp_id, lagerbereich_id, lagerbereich_bez, lagerbereich_bez_de, lagerbereich_bez_cz, lagerbereich_bez_sk,
lagerbereich_bez_hr, lagerbereich_bez_pl, lagerbereich_bez_ro, lagerbereich_bez_bg) AS SELECT mandant_id,
 wup_id,
 nb_id,
 lagernummer_id,
 lagertyp_id,
 lagerbereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagerbereich_bez
   ELSE NULL
   END) AS lagerbereich_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagerbereich_bez
   ELSE NULL
   END) AS lagerbereich_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lagerbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerbereich_bez
    ELSE NULL
    END)) AS lagerbereich_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lagerbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerbereich_bez
    ELSE NULL
    END)) AS lagerbereich_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lagerbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerbereich_bez
    ELSE NULL
    END)) AS lagerbereich_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lagerbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerbereich_bez
    ELSE NULL
    END)) AS lagerbereich_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lagerbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerbereich_bez
    ELSE NULL
    END)) AS lagerbereich_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lagerbereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerbereich_bez
    ELSE NULL
    END)) AS lagerbereich_bez_bg
FROM kfl_production_dbp_view.v_lagerbereich_spr_zu_1 AS V01
GROUP BY mandant_id,
 wup_id,
 nb_id,
 lagernummer_id,
 lagertyp_id,
 lagerbereich_id;