CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_AGGREGAT
AS
   -- FAKT Schnellbeurteilung Gesamt - Bereich - Detail
   -- Denormalisierung der Fakttabellen + Sortierung der Elemente
   -- 20120126 Initial
   -- 20120213 Optimierung + Erweiterung Gruende
   -- 20120416 Anpassung Gruende + Ebenen (COALESCE)
   -- 2012KW28 : Ausbau Gesamt-Grund + Erweiterung dat_erfassung, zeit_stunde
   -- 2012KW31PU NEU dat_erfassung
   -- 2014KW20 : NEU frueh_kz + Alias frueh_fg
   -- 2014KW20 : Performance Teil 1 (UNION reduziert, JOIN sb_mandant_ebene)
   -- 20140721 NEUE FELDER : pep_fg + kennzahl_fg
   -- 2015KW05 : ohne geloeschte SB (Filter loesch_fg=0)
   -- 2015KW09PU : Filter auf Filialreporting (Checklistentyp = 1)
   -- 2015KW16 : Filter Checklistentyp entfernt > Berichtsfilter, Spalte ergaenzt

   SELECT
   v01.mandant_id, v01.beurteilung_id, v01.dat_erfassung, v01.dat_beurteilung, v01.zeit_beurteilung, (HOUR(zeit_beurteilung))::INTEGER AS zeit_stunde, v01.wup_id, v01.beurteiler_id, v01.letzte_beurteilung -- Rang = 1
   , v01.note_gesamt, v01.eindruck_gesamt, sub01.bereichsnote_id, sub01.detailnote_id, v01.hl_anwesend_fg   -- HL Anwesend Ja/Nein (Font Wingdings)
   , CASE WHEN hl_anwesend_fg = 1 THEN 'þ' ELSE '¨' END::CHAR(1) AS hl_anwesend_ja, CASE WHEN hl_anwesend_fg = 0 THEN 'þ' ELSE '¨' END::CHAR(1) AS hl_anwesend_no, v01.chef_tag_fg      -- Chef des Tages Anwesend Ja/Nein (Font Wingdings)
   , CASE WHEN chef_tag_fg = 1 THEN 'þ' ELSE '¨' END::CHAR(1) AS chef_tag_ja, CASE WHEN chef_tag_fg = 0 THEN 'þ' ELSE '¨' END::CHAR(1) AS chef_tag_no, v01.hotday_fg        -- Hotday Ja/Nein (Font Wingdings)
   , CASE WHEN hotday_fg = 1 THEN 'þ' ELSE '¨' END::CHAR(1) AS hotday_ja, CASE WHEN hotday_fg = 0 THEN 'þ' ELSE '¨' END::CHAR(1) AS hotday_no, v01.frueh_kz AS frueh_fg         -- Frueh oder Spaet (Alias fuer alte Spalte)
   , v01.frueh_kz                             -- Frueh oder Spaet (Neues Feld)
   , v01.pep_fg, v01.kennzahl_fg, v01.tf_fg                                   -- Taskforce (umgemappter Mandant)
   , v01.sb_checkliste_typ_id, sub01.sb_sort                   -- Sortierung aus Gesamt, Bereich, Detail + Grund
   , sub01.sb_ebene                  -- Ebene 0x=Gesamt; 1x=Bereich; 2x=Detail
   , sub01.bereichsnote_id AS sb_ebene1_id, sub01.detailnote_id   AS sb_ebene2_id, sub01.sb_id, sub01.sb_note_id, sub01.sb_note, sub01.sb_eindruck, sub01.sb_grund_id
   FROM
   (
   SELECT
   mandant_id, beurteilung_id, dat_erfassung, dat_beurteilung, zeit_beurteilung, wup_id, beurteiler_id, hl_anwesend_fg, chef_tag_fg, hotday_fg, frueh_kz, pep_fg, kennzahl_fg, tf_fg, sb_checkliste_typ_id, note_gesamt, eindruck_gesamt, RANK() OVER (PARTITION BY mandant_id, wup_id ORDER BY dat_beurteilung DESC NULLS LAST, zeit_beurteilung DESC NULLS LAST, beurteilung_id DESC NULLS LAST) AS letzte_beurteilung
   FROM dbp_view.v_sb_beurteilung
   WHERE loesch_fg = 0
   ) v01

   JOIN
   ( -- Ebene 00 : Gesamt-Note (immer ohne Gruende)
   SELECT
   s01.mandant_id, s01.beurteilung_id, -1::INTEGER                AS bereichsnote_id, -1::INTEGER                AS detailnote_id, s02.sb_ebene                 AS sb_ebene, '0000.0000 '::VARCHAR(30)       AS sb_sort, s01.beurteilung_id          AS sb_note_id, s01.note_gesamt             AS sb_note, s01.eindruck_gesamt         AS sb_eindruck, -1::INTEGER                AS sb_id, -1::INTEGER                AS sb_grund_id
   FROM dbp_view.v_sb_beurteilung s01
   JOIN dbp_view.v_sb_mandant_ebene s02
   ON s01.mandant_id = s02.mandant_id
   AND s02.sb_ebene IN (0,1,2)
   WHERE s01.loesch_fg = 0

   -- Ebene 10 : Bereichs-Note + Gruende
   UNION ALL
   SELECT
     s01.mandant_id
   , s01.beurteilung_id
   , s02.bereichsnote_id, -1::INTEGER                AS detailnote_id 
   , 10::BYTEINT                AS sb_ebene
   --, '9999.0000 ' || (s02.beurteilung_bereich_id (FORMAT '9999')) || '.' || (COALESCE(s022.sb_grund_id, 0) (FORMAT '9999'))::VARCHAR(30) AS sb_sort
   , ('9999.0000 ' || lpad(s02.beurteilung_bereich_id, 4, '0') || '.' || lpad(COALESCE(s022.sb_grund_id, 0), 4, '0'))::VARCHAR(30) AS sb_sort
   , s02.bereichsnote_id         AS sb_note_id, s02.note_bereich            AS sb_note
   , s02.eindruck_bereich        AS sb_eindruck
   , s02.beurteilung_bereich_id  AS sb_id
   , COALESCE(s022.sb_grund_id, -1) AS sb_grund_id
   FROM dbp_view.v_sb_beurteilung s01
   JOIN dbp_view.v_sb_beurteil_bereichsnote s02
   ON s01.beurteilung_id = s02.beurteilung_id
   AND s01.mandant_id = s02.mandant_id
   LEFT JOIN dbp_view.v_sb_beurteil_brch_grund_zu s022
   ON s02.bereichsnote_id = s022.bereichsnote_id
   AND s02.mandant_id = s022.mandant_id
   WHERE s01.loesch_fg = 0

   -- Ebene 11 : Bereichs-Note
   UNION ALL
   SELECT
   s01.mandant_id
   , s01.beurteilung_id
   , s02.bereichsnote_id, -1::INTEGER                AS detailnote_id
   , 11::BYTEINT                AS sb_ebene
   --, '9999.0000 ' || (s02.beurteilung_bereich_id (FORMAT '9999')) || '.0000'::VARCHAR(30) AS sb_sort
   , ('9999.0000 ' || lpad(s02.beurteilung_bereich_id, 4, '0') || '.0000')::VARCHAR(30) AS sb_sort
   , s02.bereichsnote_id         AS sb_note_id
   , s02.note_bereich            AS sb_note
   , s02.eindruck_bereich        AS sb_eindruck
   , s02.beurteilung_bereich_id  AS sb_id
   , -1::INTEGER                AS sb_grund_id
   FROM dbp_view.v_sb_beurteilung s01
   JOIN dbp_view.v_sb_beurteil_bereichsnote s02
   ON s01.beurteilung_id = s02.beurteilung_id
   AND s01.mandant_id = s02.mandant_id
   WHERE s01.loesch_fg = 0

   -- Ebene 12 : Bereichs-Gruende
   UNION ALL
   SELECT
   s01.mandant_id
     , s01.beurteilung_id
     , s02.bereichsnote_id, -1::INTEGER                AS detailnote_id
     , 12::BYTEINT                AS sb_ebene
     --, '9999.0000 ' || (s02.beurteilung_bereich_id (FORMAT '9999')) || '.' || (s022.sb_grund_id (FORMAT '9999'))::VARCHAR(30) AS sb_sort
     , ('9999.0000 ' || lpad(s02.beurteilung_bereich_id, 4, '0') || '.' || lpad(s022.sb_grund_id, 4, '0'))::VARCHAR(30) AS sb_sort
     , s02.bereichsnote_id         AS sb_note_id
     , s02.note_bereich            AS sb_note
     , s02.eindruck_bereich        AS sb_eindruck
     , s02.beurteilung_bereich_id  AS sb_id
     , s022.sb_grund_id            AS sb_grund_id
   FROM dbp_view.v_sb_beurteilung s01
   JOIN dbp_view.v_sb_beurteil_bereichsnote s02
   ON s01.beurteilung_id = s02.beurteilung_id
   AND s01.mandant_id = s02.mandant_id
   JOIN dbp_view.v_sb_beurteil_brch_grund_zu s022
   ON s02.bereichsnote_id = s022.bereichsnote_id
   AND s02.mandant_id = s022.mandant_id
   WHERE s01.loesch_fg = 0

   -- Ebene 20 : Detail-Note + Gruende
   UNION ALL
   SELECT
   s01.mandant_id, s01.beurteilung_id, s02.bereichsnote_id, s03.detailnote_id, 20::BYTEINT                AS sb_ebene
     --, '9999.0000 ' || (s02.beurteilung_bereich_id (FORMAT '9999')) || '.9999 ' || (s03.beurteilung_detail_id (FORMAT '9999')) || '.' || (COALESCE(s033.sb_grund_id, 0) (FORMAT '9999'))::VARCHAR(30) AS sb_sort
     , ('9999.0000 ' || lpad(s02.beurteilung_bereich_id, 4, '0') || '.9999 ' || lpad(s03.beurteilung_detail_id, 4, '0') || '.' || lpad(COALESCE(s033.sb_grund_id, 0), 4, '0'))::VARCHAR(30) AS sb_sort
     , s03.detailnote_id           AS sb_note_id, s03.note_detail             AS sb_note, s03.eindruck_detail         AS sb_eindruck, s03.beurteilung_detail_id   AS sb_id, COALESCE(s033.sb_grund_id, -1) AS sb_grund_id
   FROM dbp_view.v_sb_beurteilung s01
   JOIN dbp_view.v_sb_beurteil_bereichsnote s02
   ON s01.beurteilung_id = s02.beurteilung_id
   AND s01.mandant_id = s02.mandant_id
   JOIN dbp_view.v_sb_beurteil_detailnote s03
   ON s02.bereichsnote_id = s03.bereichsnote_id
   AND s02.mandant_id = s03.mandant_id
   LEFT JOIN dbp_view.v_sb_beurteil_det_grund_zu s033
   ON s03.detailnote_id = s033.detailnote_id
   AND s03.mandant_id = s033.mandant_id
   WHERE s01.loesch_fg = 0

   -- Ebene 21 : Detail-Note
   UNION ALL
   SELECT
   s01.mandant_id, s01.beurteilung_id, s02.bereichsnote_id, s03.detailnote_id, 21::BYTEINT                AS sb_ebene
     --, '9999.0000 ' || (s02.beurteilung_bereich_id (FORMAT '9999')) || '.9999 ' || (s03.beurteilung_detail_id (FORMAT '9999')) || '.0000'::VARCHAR(30) AS sb_sort
     , ('9999.0000 ' || lpad(s02.beurteilung_bereich_id, 4, '0') || '.9999 ' || lpad(s03.beurteilung_detail_id, 4, '0') || '.0000')::VARCHAR(30) AS sb_sort
     , s03.detailnote_id           AS sb_note_id, s03.note_detail             AS sb_note, s03.eindruck_detail         AS sb_eindruck, s03.beurteilung_detail_id   AS sb_id, -1::INTEGER                AS sb_grund_id
   FROM dbp_view.v_sb_beurteilung s01
   JOIN dbp_view.v_sb_beurteil_bereichsnote s02
   ON s01.beurteilung_id = s02.beurteilung_id
   AND s01.mandant_id = s02.mandant_id
   JOIN dbp_view.v_sb_beurteil_detailnote s03
   ON s02.bereichsnote_id = s03.bereichsnote_id
   AND s02.mandant_id = s03.mandant_id
   WHERE s01.loesch_fg = 0

   -- Ebene 22 : Detail-Gruende
   UNION ALL
   SELECT
   s01.mandant_id, s01.beurteilung_id, s02.bereichsnote_id, s03.detailnote_id, 22::BYTEINT                AS sb_ebene
     --, '9999.0000 ' || (s02.beurteilung_bereich_id (FORMAT '9999')) || '.9999 ' || (s03.beurteilung_detail_id (FORMAT '9999')) || '.' || (s033.sb_grund_id (FORMAT '9999'))::VARCHAR(30) AS sb_sort
     , ('9999.0000 ' || lpad(s02.beurteilung_bereich_id, 4, '0') || '.9999 ' || lpad(s03.beurteilung_detail_id, 4, '0') || '.' || lpad(s033.sb_grund_id, 4, '0'))::VARCHAR(30) AS sb_sort
     , s03.detailnote_id           AS sb_note_id, s03.note_detail             AS sb_note, s03.eindruck_detail         AS sb_eindruck, s03.beurteilung_detail_id   AS sb_id, s033.sb_grund_id            AS sb_grund_id
   FROM dbp_view.v_sb_beurteilung s01
   JOIN dbp_view.v_sb_beurteil_bereichsnote s02
   ON s01.beurteilung_id = s02.beurteilung_id
   AND s01.mandant_id = s02.mandant_id
   JOIN dbp_view.v_sb_beurteil_detailnote s03
   ON s02.bereichsnote_id = s03.bereichsnote_id
   AND s02.mandant_id = s03.mandant_id
   JOIN dbp_view.v_sb_beurteil_det_grund_zu s033
   ON s03.detailnote_id = s033.detailnote_id
   AND s03.mandant_id = s033.mandant_id
   WHERE s01.loesch_fg = 0
   ) sub01
   ON v01.mandant_id = sub01.mandant_id
   AND v01.beurteilung_id = sub01.beurteilung_id
   ;