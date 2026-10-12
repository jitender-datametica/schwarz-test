CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_aggregat_spr_zu_2 AS SELECT S01.mandant_id,
 S02.sb_ebene,
 S01.beurteilung_detail_id AS sb_id,
 MAX(CASE
   WHEN S01.spr_id = 22
   THEN S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez,
 MAX(CASE
   WHEN S01.spr_id = 22
   THEN S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez_de,
 MAX(CASE
   WHEN S01.spr_id = 124
   THEN S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez_cz,
 MAX(CASE
   WHEN S01.spr_id = 90
   THEN S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez_pl,
 MAX(CASE
   WHEN S01.spr_id = 108
   THEN S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez_sk,
 MAX(CASE
   WHEN S01.spr_id = 65
   THEN S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez_hr,
 MAX(CASE
   WHEN S01.spr_id = 95
   THEN S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez_ro,
 MAX(CASE
   WHEN S01.spr_id = 18
   THEN S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez_bg,
 MAX(CASE
   WHEN S01.spr_id = 22
   THEN '   - ' || S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez2,
 MAX(CASE
   WHEN S01.spr_id = 22
   THEN '   - ' || S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez2_de,
 MAX(CASE
   WHEN S01.spr_id = 124
   THEN '   - ' || S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez2_cz,
 MAX(CASE
   WHEN S01.spr_id = 90
   THEN '   - ' || S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez2_pl,
 MAX(CASE
   WHEN S01.spr_id = 108
   THEN '   - ' || S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez2_sk,
 MAX(CASE
   WHEN S01.spr_id = 65
   THEN '   - ' || S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez2_hr,
 MAX(CASE
   WHEN S01.spr_id = 95
   THEN '   - ' || S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez2_ro,
 MAX(CASE
   WHEN S01.spr_id = 18
   THEN '   - ' || S01.beurteilung_detail_bez
   ELSE NULL
   END) AS sb_bez2_bg
FROM kfl_production_dbp_view.v_sb_beurteil_detail_spr_zu_2 AS S01
 INNER JOIN kfl_production_dbp_view.v_sb_mandant_ebene_2 AS S02 ON S01.mandant_id = S02.mandant_id AND S02.sb_ebene IN (20
    , 21, 22)
GROUP BY S01.mandant_id,
 S02.sb_ebene,
 sb_id
UNION ALL
SELECT S01.mandant_id,
 S02.sb_ebene,
 S01.beurteilung_bereich_id AS sb_id,
 MAX(CASE
   WHEN S01.spr_id = 22
   THEN S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez,
 MAX(CASE
   WHEN S01.spr_id = 22
   THEN S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez_de,
 MAX(CASE
   WHEN S01.spr_id = 124
   THEN S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez_cz,
 MAX(CASE
   WHEN S01.spr_id = 90
   THEN S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez_pl,
 MAX(CASE
   WHEN S01.spr_id = 108
   THEN S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez_sk,
 MAX(CASE
   WHEN S01.spr_id = 65
   THEN S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez_hr,
 MAX(CASE
   WHEN S01.spr_id = 95
   THEN S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez_ro,
 MAX(CASE
   WHEN S01.spr_id = 18
   THEN S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez_bg,
 MAX(CASE
   WHEN S01.spr_id = 22
   THEN '  ' || S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez2,
 MAX(CASE
   WHEN S01.spr_id = 22
   THEN '  ' || S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez2_de,
 MAX(CASE
   WHEN S01.spr_id = 124
   THEN '  ' || S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez2_cz,
 MAX(CASE
   WHEN S01.spr_id = 90
   THEN '  ' || S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez2_pl,
 MAX(CASE
   WHEN S01.spr_id = 108
   THEN '  ' || S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez2_sk,
 MAX(CASE
   WHEN S01.spr_id = 65
   THEN '  ' || S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez2_hr,
 MAX(CASE
   WHEN S01.spr_id = 95
   THEN '  ' || S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez2_ro,
 MAX(CASE
   WHEN S01.spr_id = 18
   THEN '  ' || S01.beurteilung_bereich_bez
   ELSE NULL
   END) AS sb_bez2_bg
FROM kfl_production_dbp_view.v_sb_beurteil_bereich_spr_zu_2 AS S01
 INNER JOIN kfl_production_dbp_view.v_sb_mandant_ebene_2 AS S02 ON S01.mandant_id = S02.mandant_id AND S02.sb_ebene IN (10
    , 11, 12)
GROUP BY S01.mandant_id,
 S02.sb_ebene,
 sb_id
UNION ALL
SELECT mandant_id,
 sb_ebene,
 - 1 AS sb_id,
 'Gesamt' AS sb_bez,
 'Gesamt' AS sb_bez_de,
 'Celkem' AS sb_bez_cz,
 'Suma' AS sb_bez_pl,
 'Celkom' AS sb_bez_sk,
 'Ukupno' AS sb_bez_hr,
 'Total' AS sb_bez_ro,
 '\u001a\u001a\u001a\u001a' AS sb_bez_bg,
 'Gesamt' AS sb_bez2,
 'Gesamt' AS sb_bez2_de,
 'Celkem' AS sb_bez2_cz,
 'Suma' AS sb_bez2_pl,
 'Celkom' AS sb_bez2_sk,
 'Ukupno' AS sb_bez2_hr,
 'Total' AS sb_bez2_ro,
 '\u001a\u001a\u001a\u001a' AS sb_bez2_bg
FROM kfl_production_dbp_view.v_sb_mandant_ebene_2 AS S02
WHERE sb_ebene IN (0, 1, 2);