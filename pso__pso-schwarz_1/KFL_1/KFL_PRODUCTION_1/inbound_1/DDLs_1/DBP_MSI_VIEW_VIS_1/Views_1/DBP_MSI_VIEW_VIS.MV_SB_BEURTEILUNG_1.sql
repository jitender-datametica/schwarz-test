CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_BEURTEILUNG_1 as
   -- FAKT Schnellbeurteilung pro Tag_1/Uhrzeit und Filiale
   -- 2012KW28 : Review + Erweiterung dat_erfassung, zeit_stunde
   -- 2012KW31PU Neu dat_erfassung
   -- 2012KW42PU NEU loesch_fg
   -- 2014KW20 : NEU frueh_kz + Alias frueh_fg
   -- 20140721 NEUE FELDER : pep_fg + kennzahl_fg
   -- 2015KW09PU : Filter auf Filialreporting (Checklistentyp = 1)
   -- 2015KW16 : Filter Checklistentyp entfernt > Berichtsfilter, Spalte ergaenzt

   SELECT
   mandant_id, beurteilung_id, dat_erfassung, dat_beurteilung, zeit_beurteilung, EXTRACT(hour FROM zeit_beurteilung) as zeit_stunde, wup_id, beurteiler_id, RANK() OVER (PARTITION BY mandant_id, wup_id ORDER BY dat_beurteilung DESC NULLS LAST, zeit_beurteilung DESC NULLS LAST, beurteilung_id DESC NULLS LAST) AS letzte_beurteilung, note_gesamt, eindruck_gesamt, hl_anwesend_fg, chef_tag_fg, hotday_fg, frueh_kz AS frueh_fg -- Alias
   , frueh_kz, pep_fg, kennzahl_fg, tf_fg, sb_checkliste_typ_id
   FROM dbp_view.v_sb_beurteilung_1  v01
   WHERE v01.loesch_fg = 0
   ;