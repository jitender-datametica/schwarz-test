CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.TBL_MV_F_IN_BESCH_BEST_DET_1
   -- 03.12.2012 SHoger Initial
-- 18.02.2013 A Lipkin Währungsumrechnung / Filterung EKORG
-- 16.04.2013 AL memory_fg=0
-- 21.11.2013 twie: Korrektur Join auf mandant_1
-- 17.01.2014 AL dat_von_rb  und menge_bme aufgenommen
-- 06.02.2014 twie: Kommentare/Formatierung
-- 27.11.2014 twie: Ausschluss gelöschte Belege korrigiert
-- 27.02.2015 twie: Prüfung auf in_best_belegfluss_1 temporär entfernt, da Tabelle nicht beladen
-- 17.08.2015 twie: nur Umsätze auf relevanten Artikeln reporten, analog Artikellookup
-- 21.09.2015 twie: neu dat_aenderung zur Berechnung OnTime Quote
-- 07.12.2016 twie: SPEC0017788 keine Umsätze ohne EKG (entspr. EKG -1), die sind nicht beschaffungsrelevant

AS
   SELECT
   v01.bestellart_id,
v01.buchungskreis_id,
v01.dat_aenderung,
v01.dat_best_beleg,
v01.dat_von_rb,
v01.einkaufsorganisation_id,
v01.in_lief_id,
v02.besch_pos_typ_id,
v02.best_beleg_id,
v02.best_beleg_pos_id,
v02.best_menge_einh_id,
v02.betrag_pos_netto_best_wrg,
v02.endrech_fg,
v02.in_art_id,
v02.mandant_id,
v02.menge_best_bme,
v02.menge_bme,
v02.rech_plan_id,
v02.werk_id,
v05.umrechnungskurs,
retourenpos_fg
   FROM dbp_view.v_in_besch_best_1 v01
   INNER JOIN dbp_view.v_in_besch_best_det_1 v02
   ON v01.best_beleg_id = v02.best_beleg_id
   AND v01.mandant_id     = v02.mandant_id
   INNER JOIN dbp_view.v_mandant_1 v03
   ON v01.mandant_id=v03.mandant_id
   JOIN dbp_view.v_kurs_1 AS v05
   ON   v05.von_wrg_id = v03.default_wrg
   AND v01.dat_best_beleg BETWEEN v05.dat_von AND v05.dat_bis
   AND v05.kurstyp_id = 9
   AND v05.nach_wrg_id = 'EUR'

   JOIN dbp_view.v_in_art_1 v06
   ON v02.in_art_id = v06.in_art_id
   AND v02.mandant_id = v06.mandant_id

   WHERE v01. memory_fg = 0

   --Einschränkung auf relevante Lieferanten
   AND (v01.mandant_id, v01.in_lief_id) IN
   (
   SELECT
   v11.mandant_id,
   v11.in_lief_id
   FROM dbp_view.v_in_lieferant_ekorg_zu_1 v11
   INNER JOIN dbp_view.v_in_l_ekorg_1 v12
   ON v11.mandant_id = v12.mandant_id
   AND v11.einkaufsorganisation_id = v12.einkaufsorganisation_id
   AND v12.sako_fg = 1
   AND v11.einkaeufer_grp_id IS NOT NULL
   )

   --Einschränkung auf relevante Buchungskreise
   AND (v01.mandant_id, v01.buchungskreis_id) IN
   (
   SELECT
   mandant_id,
   buchungskreis_id
   FROM dbp_view.v_in_l_buchungskreis_1
   WHERE sako_fg = 1
   )

   -- nur Umsätze auf relevanten Artikeln reporten, analog Artikellookup
   AND (v06.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
   OR SUBSTR( v06.in_art_nr, 1, 1) = 'W'
   OR v06.in_art_id = -1
   )

   --gelöschte Bestellungen ausschließen
   AND (loesch_id = ''
   /*
   OR
   (v02.mandant_id, v02.best_beleg_id, v02.best_beleg_pos_id) IN
   (
   SELECT
   mandant_id
   ,best_beleg_id
   ,best_beleg_pos_id
   FROM dbp_view.v_in_best_belegfluss_1
   )
   */
   )
   ;