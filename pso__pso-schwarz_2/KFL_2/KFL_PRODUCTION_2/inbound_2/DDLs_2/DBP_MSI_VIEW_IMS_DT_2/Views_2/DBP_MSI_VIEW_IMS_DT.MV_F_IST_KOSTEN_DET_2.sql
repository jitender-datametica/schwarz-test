CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.MV_F_IST_KOSTEN_DET_2
(
	MANDANT_ID,
	PSP_ID,
	PROJEKT_TYP_ID,
	GJ,
	BUCHUNGSPERIODE_ID,
	BUCHUNGSKREIS_ID,
	DAT_BUCH,
	DAT_BELEG,
	SOLL_HABEN_KZ,
	BELASTUNGS_KZ,
	BELEG_ID,
	BELEG_POS_ID,
	BELEG_BEZ,
	KRK_ID,
	GESCHAEFTSBEREICH_ID,
	IN_LIEF_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	REF_BELEG_ID,
	REF_FI_BELEG_ID,
	BETRAG_LANDESWRG,
	AUFTRAG_ID,
	KOSTENART_ID,
	ANLAGE_ID,
	ANLAGE_SUB_ID,
	ANLAGE_BUCHUNGSKREIS_ID,
	BERICHTS_POSITION_IT_ID,
	BERICHTS_POSITION_INVEST_ID,
	SPARTE_ID,
	IN_ART_ID,
	KOSTENSTELLE_ID,
	BESTELL_TEXT,
	REF_BUCHUNGSKREIS_ID,
	BELEGART_ID,
	GEGENKONTO_ID,
	HB2_FG,
	BEDARF_NR,
	BETRAG
)
AS
-- 21.05.2013 AL init
-- 24.05.2013 twie: Ermittlung Planungselement
-- 29.05.2013 twie: Dummywert bei geschaeftsbereich_id
-- 31.05.2013 twie: in_art_id hinzugefügt
-- 10.06.2013 AL psp_id <> -1 anstatt psp_id > -1 wegen generierten I PSP
-- 12.06.2013 twie: Istdaten auf Projekten in Sparte 4 (TIP) auf Zentrale (PR_Z) zuordnen
-- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage_2 vorhanden
-- 13.06.2013 AL soll_haben_kz
-- 14.06.2013 twie: beleg_bez hinzugefügt
-- 08.07.2013 twie: weitere Felder wie best_beleg_id sowie Betrag in Landeswährung hinzugefügt
-- 15.07.2013 AL HB1/HB2 Sicht Auswahl und Ausschluss definierten Kostenarten
-- 25.07.2013 AL HB2 Sicht, falls kostenart_2 mit H beginnt, unabhängig ob Anlage_2 befühlt ist.
-- 30.07.2013 AL HB1 / HB2 Unterscheidung Nachkorrektur mit der Berücksichtigung Manuelle HB2 Anpassungen
-- 30.07.2013 AL leading 0 auf gegenkonto entfernt
-- 31.07.2013 AL Anpassung für Sparte ID Tip, KI, KIS auf die Zentrale mappen
-- 22.08.2013 AL Umrechnung zum aktuellen Kurs_2, Gegenkonto '' falls nicht als Kostenart_2 existiert
-- 22.08.2013 twie: kostenstelle_id ausgeben
-- 19.09.2013 AL Kostenart_2 880100 ausgeschlossen, nur INV nicht bei IT Projekte
-- 24.03.2014 SH Anpassung aufgrund manueller Einspielung bzw. Einspielung HBI- Daten
-- 25.03.2014 SH nochmal feinere Anpassung aufgrund manueller Einspielung bzw. Einspielung HBI- Daten
-- 01.04.2014 twie: Workaround: Filterung bei CS-Aufträgen (psp_id < -1) auf soll_haben_kz = S
-- 12.06.2014 twie: kostenart_id 48011 ausschließen
-- 27.08.2014 twie: belastungs_kz, bestell_text, ref_buchungskreis_id, belegart_id neu
-- 29.08.2014 twie: Dummy_2 für buchungskreis_id
-- 02.12.2014 twie: krk_id DE02 in DE ausschließen
-- 08.07.2015 mcan1401: ims_projekt_typ_id in die Tabelle in_projekt_2 aufgenommen und direkt referenziert
-- 03.08.2015 twie: neues Hauptbuch, alte HB I - HB II Logik entfernt, es gibt nur noch HB II Buchungen (alte HB I Datensätze ausfiltern)
-- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
-- 08.03.2018 srom: NSR0112499 Zusammenfassen Werbung, (KIS, KI) zu Zentrale, KIS herausgenommen bei sparte_id
-- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern
-- 20.10.2022 prescherad: NSR3269480 Feld planungs_element_id ausbauen da nicht mehr benötigt

SELECT
   v01.mandant_id,
   v01.psp_id,
   projekt_typ_id,
   v01.gj,
   v01.buchungsperiode_id,
   buchungskreis_id,
   v01.dat_buch,
   v01.dat_beleg,
   v01.soll_haben_kz,
   v01.belastungs_kz,
   v01.beleg_id,
   v01.beleg_pos_id,
   beleg_bez,
   v01.krk_id,
   geschaeftsbereich_id,
   in_lief_id,
   best_beleg_id,
   best_beleg_pos_id,
   ref_beleg_id,
   ref_fi_beleg_id,
   betrag_landeswrg,
   v01.auftrag_id,
   kostenart_id,
   anlage_id,
   anlage_sub_id,
   anlage_buchungskreis_id,
   v01.berichts_position_it_id,
   v01.berichts_position_invest_id,
   v01.sparte_id,
   in_art_id,
   kostenstelle_id,
   v01.bestell_text,
   v01.ref_buchungskreis_id,
   v01.belegart_id,
   gegenkonto_id,
   v01.hb2_fg,
   v01.bedarf_nr,
   CASE WHEN v400.wrg_typ_id = 1 THEN v01.betrag ELSE v01.betrag * umrechnungskurs END AS betrag

FROM DBP_MSI_VIEW_IMS_DT.TBL_MV_F_IST_KOSTEN_DET_2 v01

-- Ermittlung der eingestellter Währung
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

-- Ermittlung Kurstyp
CROSS JOIN  dbp_msi.akt_msi_user_kurstyp_zu_2 v300

JOIN  dbp_view.v_mandant_wrg_typ_zu_2 v400
  ON v01.mandant_id = v400.mandant_id  
  AND v200.wrg_typ_id = v400.wrg_typ_id

-- Umrechnung Standardkurs, Tageskurs
JOIN   dbp_view.v_kurs_2 v500
  ON v300.kurstyp_id = v500.kurstyp_id
  AND v01.wrg_id = v500.von_wrg_id
  AND v500.nach_wrg_id ='EUR'
  AND CURRENT_DATE BETWEEN v500.dat_von AND v500.dat_bis

--WHERE Bedingung ist bereits in der materialisierten View enthalten
;