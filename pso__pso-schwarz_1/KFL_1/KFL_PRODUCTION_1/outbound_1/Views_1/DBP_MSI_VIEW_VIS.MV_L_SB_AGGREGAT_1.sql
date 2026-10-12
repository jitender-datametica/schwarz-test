CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_sb_aggregat_1 AS SELECT mandant_id,
 sb_ebene,
 sb_id
FROM (SELECT mandant_id,
    20 AS sb_ebene,
    beurteilung_detail_id AS sb_id,
    beurteilung_detail_bez AS sb_bez
   FROM kfl_production_dbp_view.v_sb_beurteil_detail_spr_zu_1
   WHERE spr_id = 22
   UNION ALL
   SELECT mandant_id,
    21 AS sb_ebene,
    beurteilung_detail_id AS sb_id,
    beurteilung_detail_bez AS sb_bez
   FROM kfl_production_dbp_view.v_sb_beurteil_detail_spr_zu_1
   WHERE spr_id = 22
   UNION ALL
   SELECT mandant_id,
    22 AS sb_ebene,
    beurteilung_detail_id AS sb_id,
    beurteilung_detail_bez AS sb_bez
   FROM kfl_production_dbp_view.v_sb_beurteil_detail_spr_zu_1
   WHERE spr_id = 22
   UNION ALL
   SELECT mandant_id,
    10 AS sb_ebene,
    beurteilung_bereich_id AS sb_id,
    beurteilung_bereich_bez AS sb_bez
   FROM kfl_production_dbp_view.v_sb_beurteil_bereich_spr_zu_1
   WHERE spr_id = 22
   UNION ALL
   SELECT mandant_id,
    11 AS sb_ebene,
    beurteilung_bereich_id AS sb_id,
    beurteilung_bereich_bez AS sb_bez
   FROM kfl_production_dbp_view.v_sb_beurteil_bereich_spr_zu_1
   WHERE spr_id = 22
   UNION ALL
   SELECT mandant_id,
    12 AS sb_ebene,
    beurteilung_bereich_id AS sb_id,
    beurteilung_bereich_bez AS sb_bez
   FROM kfl_production_dbp_view.v_sb_beurteil_bereich_spr_zu_1
   WHERE spr_id = 22
   UNION ALL
   SELECT mandant_id,
    0 AS sb_ebene,
    - 1 AS sb_id,
    'Filiale/Gesamt' AS sb_bez
   FROM kfl_production_dbp_view.v_mandant_1
   WHERE mandant_id <> 4
   UNION ALL
   SELECT mandant_id,
    1 AS sb_ebene,
    - 1 AS sb_id,
    'Filiale/Gesamt' AS sb_bez
   FROM kfl_production_dbp_view.v_mandant_1
   WHERE mandant_id <> 4
   UNION ALL
   SELECT mandant_id,
    2 AS sb_ebene,
    - 1 AS sb_id,
    'Filiale/Gesamt' AS sb_bez
   FROM kfl_production_dbp_view.v_mandant_1
   WHERE mandant_id <> 4) AS sub01;