CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_BEURTEIL_DETAILNOTE_2 as
   -- FAKT Schnellbeurteilung Detail
   -- Fakten auf Ebene 3 Bereich
   -- 20120130 MR Initial
   -- 20120403 Update
   -- 2015KW05 : ohne geloeschte SB (Filter loesch_fg=0)
   -- 2015KW09PU : Filter auf Filialreporting (Checklistentyp = 1)
   -- 2015KW16 : Filter Checklistentyp entfernt > Berichtsfilter, Spalte ergaenzt

   SELECT
   v01.detailnote_id, v01.mandant_id, v01.bereichsnote_id, v01.note_detail, v01.eindruck_detail, v01.beurteilung_detail_id, v03.dat_beurteilung, v03.sb_checkliste_typ_id
   --, v02.beurteilung_bereich_id

   FROM
   dbp_view.v_sb_beurteil_detailnote_2  v01

   JOIN dbp_view.v_sb_beurteil_bereichsnote_2  v02
   ON v01.bereichsnote_id = v02.bereichsnote_id

   JOIN dbp_view.v_sb_beurteilung_2  v03
   ON v03.beurteilung_id = v02.beurteilung_id

   WHERE v03.loesch_fg = 0
   ;