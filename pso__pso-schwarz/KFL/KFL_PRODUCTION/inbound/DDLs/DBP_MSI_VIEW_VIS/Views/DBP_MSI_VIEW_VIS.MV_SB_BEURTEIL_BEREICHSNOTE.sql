CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_BEURTEIL_BEREICHSNOTE as
   -- FAKT Schnellbeurteilung Bereich
   -- Fakten auf Ebene 1 Bereich
   -- 20120130 MR Initial
   -- 20120403 Update
   -- 2015KW05 : ohne geloeschte SB (Filter loesch_fg=0)
   -- 2015KW09PU : Filter auf Filialreporting (Checklistentyp = 1)
   -- 2015KW16 : Filter Checklistentyp entfernt > Berichtsfilter, Spalte ergaenzt

   SELECT
   v01.bereichsnote_id, v01.mandant_id, v01.beurteilung_bereich_id, v01.beurteilung_id, v01.note_bereich, v01.eindruck_bereich, v02.dat_beurteilung, v02.sb_checkliste_typ_id

   FROM dbp_view.v_sb_beurteil_bereichsnote  v01

   JOIN dbp_view.v_sb_beurteilung  v02
   ON v01.beurteilung_id = v02.beurteilung_id

   WHERE v02.loesch_fg = 0
   ;