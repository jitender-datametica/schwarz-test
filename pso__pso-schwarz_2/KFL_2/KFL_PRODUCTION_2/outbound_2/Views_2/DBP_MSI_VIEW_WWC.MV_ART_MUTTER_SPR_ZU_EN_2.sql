CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_mutter_spr_zu_en_2 (mandant_id, art_id, art_bez, art_id_bez
, spr_id) AS SELECT mandant_id,
 art_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN art_bez
    ELSE NULL
    END)) AS art_bez,
 SUBSTR(CAST(SUBSTR(CAST(art_id AS STRING), 1, 10) || ' ' || COALESCE(MAX(CASE
       WHEN spr_id = 24
       THEN art_bez
       ELSE NULL
       END), MAX(CASE
       WHEN spr_id = 22
       THEN art_bez
       ELSE NULL
       END)) AS STRING), 1, 60) AS art_id_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_art_spr_zu_2 AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 art_id;