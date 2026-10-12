CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_agg_grund_helper_1 AS SELECT S01.mandant_id,
 S01.beurteilung_id,
 10 AS sb_ebene,
 S02.beurteilung_bereich_id AS sb_id,
 COALESCE(S022.sb_grund_id, - 1) AS sb_grund_id,
 ROW_NUMBER() OVER (PARTITION BY CAST(S01.mandant_id AS STRING), CAST(S01.beurteilung_id AS STRING), CAST(10 AS STRING)
    , CAST(S02.beurteilung_bereich_id AS STRING) ORDER BY S01.mandant_id IS NULL, S01.mandant_id, S01.beurteilung_id
    IS NULL, S01.beurteilung_id, 10 IS NULL, 10, S02.beurteilung_bereich_id IS NULL, S02.beurteilung_bereich_id, S022.sb_grund_id
    IS NULL, S022.sb_grund_id) AS sb_count
FROM kfl_production_dbp_view.v_sb_beurteilung_1 AS S01
 INNER JOIN kfl_production_dbp_view.v_sb_beurteil_bereichsnote_1 AS S02 ON S01.beurteilung_id = S02.beurteilung_id AND S01
   .mandant_id = S02.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_sb_beurteil_brch_grund_zu_1 AS S022 ON S02.bereichsnote_id = S022.bereichsnote_id AND
   S02.mandant_id = S022.mandant_id
WHERE S01.loesch_fg = 0;