CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_aggregat_2 AS SELECT v01.mandant_id,
 v01.beurteilung_id,
 v01.dat_erfassung,
 v01.dat_beurteilung,
 v01.zeit_beurteilung,
 CAST(EXTRACT(HOUR FROM v01.zeit_beurteilung) AS BIGNUMERIC) AS zeit_stunde,
 v01.wup_id,
 v01.beurteiler_id,
 v01.letzte_beurteilung,
 v01.note_gesamt,
 v01.eindruck_gesamt,
 sub01.bereichsnote_id,
 sub01.detailnote_id,
 v01.hl_anwesend_fg,
 SUBSTR(CASE
   WHEN v01.hl_anwesend_fg = 1
   THEN '\u00fe'
   ELSE '\u00a8'
   END, 1, 1) AS hl_anwesend_ja,
 SUBSTR(CASE
   WHEN v01.hl_anwesend_fg = 0
   THEN '\u00fe'
   ELSE '\u00a8'
   END, 1, 1) AS hl_anwesend_no,
 v01.chef_tag_fg,
 SUBSTR(CASE
   WHEN v01.chef_tag_fg = 1
   THEN '\u00fe'
   ELSE '\u00a8'
   END, 1, 1) AS chef_tag_ja,
 SUBSTR(CASE
   WHEN v01.chef_tag_fg = 0
   THEN '\u00fe'
   ELSE '\u00a8'
   END, 1, 1) AS chef_tag_no,
 v01.hotday_fg,
 SUBSTR(CASE
   WHEN v01.hotday_fg = 1
   THEN '\u00fe'
   ELSE '\u00a8'
   END, 1, 1) AS hotday_ja,
 SUBSTR(CASE
   WHEN v01.hotday_fg = 0
   THEN '\u00fe'
   ELSE '\u00a8'
   END, 1, 1) AS hotday_no,
 v01.frueh_kz AS frueh_fg,
 v01.frueh_kz,
 v01.pep_fg,
 v01.kennzahl_fg,
 v01.tf_fg,
 v01.sb_checkliste_typ_id,
 sub01.sb_sort,
 sub01.sb_ebene,
 sub01.bereichsnote_id AS sb_ebene1_id,
 sub01.detailnote_id AS sb_ebene2_id,
 sub01.sb_id,
 sub01.sb_note_id,
 sub01.sb_note,
 sub01.sb_eindruck,
 sub01.sb_grund_id
FROM (SELECT mandant_id,
   beurteilung_id,
   dat_erfassung,
   dat_beurteilung,
   zeit_beurteilung,
   wup_id,
   beurteiler_id,
   hl_anwesend_fg,
   chef_tag_fg,
   hotday_fg,
   frueh_kz,
   pep_fg,
   kennzahl_fg,
   tf_fg,
   sb_checkliste_typ_id,
   note_gesamt,
   eindruck_gesamt,
   RANK() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING) ORDER BY dat_beurteilung IS NULL,
      dat_beurteilung, zeit_beurteilung IS NULL, zeit_beurteilung, beurteilung_id IS NULL, beurteilung_id) AS
   letzte_beurteilung
  FROM kfl_production_dbp_view.v_sb_beurteilung_2
  WHERE loesch_fg = 0) AS v01
 INNER JOIN (SELECT S01.mandant_id,
    S01.beurteilung_id,
    - 1 AS bereichsnote_id,
    - 1 AS detailnote_id,
    S02.sb_ebene,
    '0000.0000 ' AS sb_sort,
    S01.beurteilung_id AS sb_note_id,
    S01.note_gesamt AS sb_note,
    S01.eindruck_gesamt AS sb_eindruck,
    - 1 AS sb_id,
    - 1 AS sb_grund_id
   FROM kfl_production_dbp_view.v_sb_beurteilung_2 AS S01
    INNER JOIN kfl_production_dbp_view.v_sb_mandant_ebene_2 AS S02 ON S01.mandant_id = S02.mandant_id AND S02.sb_ebene IN
       (0, 1, 2)
   WHERE S01.loesch_fg = 0
   UNION ALL
   SELECT S01.mandant_id,
    S01.beurteilung_id,
    S02.bereichsnote_id,
    - 1 AS detailnote_id,
    10 AS sb_ebene,
       '9999.0000 ' || LPAD(SUBSTR(CAST(S02.beurteilung_bereich_id AS STRING), 1, 39), 4, '0') || '.' || LPAD(SUBSTR(CAST(COALESCE(S022.sb_grund_id, 0) AS STRING)
       , 1, 39), 4, '0') AS sb_sort,
    S02.bereichsnote_id AS sb_note_id,
    S02.note_bereich AS sb_note,
    S02.eindruck_bereich AS sb_eindruck,
    S02.beurteilung_bereich_id AS sb_id,
    COALESCE(S022.sb_grund_id, - 1) AS sb_grund_id
   FROM kfl_production_dbp_view.v_sb_beurteilung_2 AS S01
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_bereichsnote_2 AS S02 ON S01.beurteilung_id = S02.beurteilung_id AND
      S01.mandant_id = S02.mandant_id
    LEFT JOIN kfl_production_dbp_view.v_sb_beurteil_brch_grund_zu_2 AS S022 ON S02.bereichsnote_id = S022.bereichsnote_id
     AND S02.mandant_id = S022.mandant_id
   WHERE S01.loesch_fg = 0
   UNION ALL
   SELECT S01.mandant_id,
    S01.beurteilung_id,
    S02.bereichsnote_id,
    - 1 AS detailnote_id,
    11 AS sb_ebene,
      '9999.0000 ' || LPAD(SUBSTR(CAST(S02.beurteilung_bereich_id AS STRING), 1, 39), 4, '0') || '.0000' AS sb_sort,
    S02.bereichsnote_id AS sb_note_id,
    S02.note_bereich AS sb_note,
    S02.eindruck_bereich AS sb_eindruck,
    S02.beurteilung_bereich_id AS sb_id,
    - 1 AS sb_grund_id
   FROM kfl_production_dbp_view.v_sb_beurteilung_2 AS S01
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_bereichsnote_2 AS S02 ON S01.beurteilung_id = S02.beurteilung_id AND
      S01.mandant_id = S02.mandant_id
   WHERE S01.loesch_fg = 0
   UNION ALL
   SELECT S01.mandant_id,
    S01.beurteilung_id,
    S02.bereichsnote_id,
    - 1 AS detailnote_id,
    12 AS sb_ebene,
       '9999.0000 ' || LPAD(SUBSTR(CAST(S02.beurteilung_bereich_id AS STRING), 1, 39), 4, '0') || '.' || LPAD(SUBSTR(CAST(S022.sb_grund_id AS STRING)
       , 1, 39), 4, '0') AS sb_sort,
    S02.bereichsnote_id AS sb_note_id,
    S02.note_bereich AS sb_note,
    S02.eindruck_bereich AS sb_eindruck,
    S02.beurteilung_bereich_id AS sb_id,
    S022.sb_grund_id
   FROM kfl_production_dbp_view.v_sb_beurteilung_2 AS S01
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_bereichsnote_2 AS S02 ON S01.beurteilung_id = S02.beurteilung_id AND
      S01.mandant_id = S02.mandant_id
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_brch_grund_zu_2 AS S022 ON S02.bereichsnote_id = S022.bereichsnote_id
       AND S02.mandant_id = S022.mandant_id
   WHERE S01.loesch_fg = 0
   UNION ALL
   SELECT S01.mandant_id,
    S01.beurteilung_id,
    S02.bereichsnote_id,
    S03.detailnote_id,
    20 AS sb_ebene,
         '9999.0000 ' || LPAD(SUBSTR(CAST(S02.beurteilung_bereich_id AS STRING), 1, 39), 4, '0') || '.9999 ' || LPAD(SUBSTR(CAST(S03.beurteilung_detail_id AS STRING)
         , 1, 39), 4, '0') || '.' || LPAD(SUBSTR(CAST(COALESCE(S033.sb_grund_id, 0) AS STRING), 1, 39), 4, '0') AS
    sb_sort,
    S03.detailnote_id AS sb_note_id,
    S03.note_detail AS sb_note,
    S03.eindruck_detail AS sb_eindruck,
    S03.beurteilung_detail_id AS sb_id,
    COALESCE(S033.sb_grund_id, - 1) AS sb_grund_id
   FROM kfl_production_dbp_view.v_sb_beurteilung_2 AS S01
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_bereichsnote_2 AS S02 ON S01.beurteilung_id = S02.beurteilung_id AND
      S01.mandant_id = S02.mandant_id
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_detailnote_2 AS S03 ON S02.bereichsnote_id = S03.bereichsnote_id AND
      S02.mandant_id = S03.mandant_id
    LEFT JOIN kfl_production_dbp_view.v_sb_beurteil_det_grund_zu_2 AS S033 ON S03.detailnote_id = S033.detailnote_id AND
      S03.mandant_id = S033.mandant_id
   WHERE S01.loesch_fg = 0
   UNION ALL
   SELECT S01.mandant_id,
    S01.beurteilung_id,
    S02.bereichsnote_id,
    S03.detailnote_id,
    21 AS sb_ebene,
        '9999.0000 ' || LPAD(SUBSTR(CAST(S02.beurteilung_bereich_id AS STRING), 1, 39), 4, '0') || '.9999 ' || LPAD(SUBSTR(CAST(S03.beurteilung_detail_id AS STRING)
        , 1, 39), 4, '0') || '.0000' AS sb_sort,
    S03.detailnote_id AS sb_note_id,
    S03.note_detail AS sb_note,
    S03.eindruck_detail AS sb_eindruck,
    S03.beurteilung_detail_id AS sb_id,
    - 1 AS sb_grund_id
   FROM kfl_production_dbp_view.v_sb_beurteilung_2 AS S01
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_bereichsnote_2 AS S02 ON S01.beurteilung_id = S02.beurteilung_id AND
      S01.mandant_id = S02.mandant_id
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_detailnote_2 AS S03 ON S02.bereichsnote_id = S03.bereichsnote_id AND
      S02.mandant_id = S03.mandant_id
   WHERE S01.loesch_fg = 0
   UNION ALL
   SELECT S01.mandant_id,
    S01.beurteilung_id,
    S02.bereichsnote_id,
    S03.detailnote_id,
    22 AS sb_ebene,
         '9999.0000 ' || LPAD(SUBSTR(CAST(S02.beurteilung_bereich_id AS STRING), 1, 39), 4, '0') || '.9999 ' || LPAD(SUBSTR(CAST(S03.beurteilung_detail_id AS STRING)
         , 1, 39), 4, '0') || '.' || LPAD(SUBSTR(CAST(S033.sb_grund_id AS STRING), 1, 39), 4, '0') AS sb_sort,
    S03.detailnote_id AS sb_note_id,
    S03.note_detail AS sb_note,
    S03.eindruck_detail AS sb_eindruck,
    S03.beurteilung_detail_id AS sb_id,
    S033.sb_grund_id
   FROM kfl_production_dbp_view.v_sb_beurteilung_2 AS S01
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_bereichsnote_2 AS S02 ON S01.beurteilung_id = S02.beurteilung_id AND
      S01.mandant_id = S02.mandant_id
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_detailnote_2 AS S03 ON S02.bereichsnote_id = S03.bereichsnote_id AND
      S02.mandant_id = S03.mandant_id
    INNER JOIN kfl_production_dbp_view.v_sb_beurteil_det_grund_zu_2 AS S033 ON S03.detailnote_id = S033.detailnote_id AND
      S03.mandant_id = S033.mandant_id
   WHERE S01.loesch_fg = 0) AS sub01 ON v01.mandant_id = sub01.mandant_id AND v01.beurteilung_id = sub01.beurteilung_id;