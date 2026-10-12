-- standard == DE
 -- SK
 -- CZ
 -- HR
 -- DE
 -- PL
 -- RO

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_warenbewegungstyp_spr_zu_1 (mandant_id,
warenbewegungstyp_id, warenbewegungstyp_bez, warenbewegungstyp_bez_de, warenbewegungstyp_bez_cz,
warenbewegungstyp_bez_sk, warenbewegungstyp_bez_hr, warenbewegungstyp_bez_pl, warenbewegungstyp_bez_ro,
warenbewegungstyp_bez_b) AS SELECT mandant_id,
 warenbewegungstyp_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN warenbewegungstyp_bez
   ELSE NULL
   END) AS warenbewegungstyp_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN warenbewegungstyp_bez
   ELSE NULL
   END) AS warenbewegungstyp_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN warenbewegungstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN warenbewegungstyp_bez
    ELSE NULL
    END)) AS warenbewegungstyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN warenbewegungstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN warenbewegungstyp_bez
    ELSE NULL
    END)) AS warenbewegungstyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN warenbewegungstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN warenbewegungstyp_bez
    ELSE NULL
    END)) AS warenbewegungstyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN warenbewegungstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN warenbewegungstyp_bez
    ELSE NULL
    END)) AS warenbewegungstyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN warenbewegungstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN warenbewegungstyp_bez
    ELSE NULL
    END)) AS warenbewegungstyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN warenbewegungstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN warenbewegungstyp_bez
    ELSE NULL
    END)) AS warenbewegungstyp_bez_b
FROM kfl_production_dbp_view.v_warenbewegungstyp_spr_zu_1 AS V01
GROUP BY mandant_id,
 warenbewegungstyp_id;