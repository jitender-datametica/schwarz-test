CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.TBL_MV_F_IST_KOSTEN_DET_1
-- 21.05.2013 AL init
-- 24.05.2013 twie: Ermittlung Planungselement
-- 29.05.2013 twie: Dummywert bei geschaeftsbereich_id
-- 31.05.2013 twie: in_art_id hinzugefügt
-- 10.06.2013 AL psp_id <> -1 anstatt psp_id > -1 wegen generierten I PSP
-- 12.06.2013 twie: Istdaten auf Projekten in Sparte 4 (TIP) auf Zentrale (PR_Z) zuordnen
-- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage_1 vorhanden
-- 13.06.2013 AL soll_haben_kz
-- 14.06.2013 twie: beleg_bez hinzugefügt
-- 08.07.2013 twie: weitere Felder wie best_beleg_id sowie Betrag in Landeswährung hinzugefügt
-- 15.07.2013 AL HB1/HB2 Sicht Auswahl und Ausschluss definierten Kostenarten
-- 25.07.2013 AL HB2 Sicht, falls kostenart_1 mit H beginnt, unabhängig ob Anlage_1 befühlt ist.
-- 30.07.2013 AL HB1 / HB2 Unterscheidung Nachkorrektur mit der Berücksichtigung Manuelle HB2 Anpassungen
-- 30.07.2013 AL leading 0 auf gegenkonto entfernt
-- 31.07.2013 AL Anpassung für Sparte ID Tip, KI, KIS auf die Zentrale mappen
-- 22.08.2013 AL Umrechnung zum aktuellen Kurs_1, Gegenkonto '' falls nicht als Kostenart_1 existiert
-- 22.08.2013 twie: kostenstelle_id ausgeben
-- 19.09.2013 AL Kostenart_1 880100 ausgeschlossen, nur INV nicht bei IT Projekte
-- 24.03.2014 SH Anpassung aufgrund manueller Einspielung bzw. Einspielung HBI- Daten
-- 25.03.2014 SH nochmal feinere Anpassung aufgrund manueller Einspielung bzw. Einspielung HBI- Daten
-- 01.04.2014 twie: Workaround: Filterung bei CS-Aufträgen (psp_id < -1) auf soll_haben_kz = S
-- 12.06.2014 twie: kostenart_id 48011 ausschließen
-- 27.08.2014 twie: belastungs_kz, bestell_text, ref_buchungskreis_id, belegart_id neu
-- 29.08.2014 twie: Dummy_1 für buchungskreis_id
-- 02.12.2014 twie: krk_id DE02 in DE ausschließen
-- 08.07.2015 mcan1401: ims_projekt_typ_id in die Tabelle in_projekt_1 aufgenommen und direkt referenziert
-- 03.08.2015 twie: neues Hauptbuch, alte HB I - HB II Logik entfernt, es gibt nur noch HB II Buchungen (alte HB I Datensätze ausfiltern)
-- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
-- 08.03.2018 srom: NSR0112499 Zusammenfassen Werbung, (KIS, KI) zu Zentrale, KIS herausgenommen bei sparte_id
-- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern
-- 20.10.2022 prescherad: NSR3269480 Feld planungs_element_id ausbauen da nicht mehr benötigt
-- 01.07.2025 pkra: new data type for BELEG_ID column
AS
   SELECT
   v01.mandant_id,
   v01.psp_id,
   v03.ims_projekt_typ_id AS projekt_typ_id,
   --auskommentieren aktuell nicht benötigtes Feld Plaungs_element_ID
   --CAST( -- Standort bzw. Projekt zu Istkosten ermitteln
   --    CASE 
   --      --WHEN v03.ims_projekt_typ_id IN ('A', 'B', 'E', 'G', 'I') THEN SUBSTRING(v03.in_projekt_id_char, 2, 4)
   --      WHEN v03.ims_projekt_typ_id IN ('P') AND v01.sparte_id = 1 THEN 21 --PR_V
   --      WHEN v03.ims_projekt_typ_id IN ('P') AND v01.sparte_id = 2 THEN 22 --PR_L
   --      WHEN v03.ims_projekt_typ_id IN ('P') AND v01.sparte_id = 3 THEN 23 --PR_F
   --      WHEN v03.ims_projekt_typ_id IN ('P') AND v01.sparte_id IN (4,5,6) THEN 25 --PR_Z
   --      ELSE NULL
   --    END  AS INTEGER
   --  ) AS planungs_element_id,
   v01.gj,
   v01.buchungsperiode_id,
   COALESCE(v01.buchungskreis_id, -1) AS buchungskreis_id,
   v01.dat_buch,
   v01.dat_beleg,
   v01.soll_haben_kz,
   v01.belastungs_kz,
   v01.beleg_id,
   v01.beleg_pos_id,
   COALESCE(v01.beleg_bez, '') AS beleg_bez,
   v01.krk_id,
   COALESCE(v01.geschaeftsbereich_id, '-1') AS geschaeftsbereich_id,
   COALESCE(v01.in_lief_id,-1) AS in_lief_id,
   COALESCE(v01.best_beleg_id, 0) AS best_beleg_id,
   COALESCE(v01.best_beleg_pos_id, 0) AS best_beleg_pos_id,
   COALESCE(v01.ref_beleg_id, 0) AS ref_beleg_id,
   COALESCE(v01.ref_fi_beleg_id, '') AS ref_fi_beleg_id,
   v01.betrag AS betrag_landeswrg,
   v01.auftrag_id,
   LTRIM(collate(v01.kostenart_id,''),'0') AS kostenart_id,
   COALESCE(v01.anlage_id, '') AS anlage_id,
   COALESCE(v01.anlage_sub_id, 0) AS anlage_sub_id,
   CAST(CASE WHEN v01.anlage_id IS NULL THEN -1 ELSE v01.buchungskreis_id END AS SMALLINT) AS anlage_buchungskreis_id,
   v01.berichts_position_it_id,
   v01.berichts_position_invest_id,
   -- Zusammenfassen Werbung, (KIS, KI) zu Zentrale
   CASE WHEN v01.sparte_id = 4 THEN 5 ELSE v01.sparte_id END sparte_id,
   COALESCE(v01.in_art_id, -1) AS in_art_id,
   COALESCE(kostenstelle_id, '') AS kostenstelle_id,
   v01.bestell_text,
   v01.ref_buchungskreis_id,
   v01.belegart_id,
   COALESCE(LTRIM(COLLATE(gegenkonto_id_,''), '0'), '') AS gegenkonto_id,
   v01.hb2_fg,
   v01.bedarf_nr,
   v01.wrg_id,
   v01.betrag
   
   FROM  dbp_view.v_ist_kosten_det_1 v01
   
   JOIN  dbp_view.v_in_psp_element_1 v02
   ON v01.psp_id = v02.psp_id
   AND v01.mandant_id = v02.mandant_id
   
   JOIN  dbp_view.v_in_projekt_1 v03
   ON v02.in_projekt_id = v03.in_projekt_id
   AND v02.mandant_id = v03.mandant_id
   
   --Falls Gegenkonto als Kostenart_1 nicht existiert ==> als '' anzeigen
   LEFT JOIN
   (
       SELECT kostenart_id AS gegenkonto_id_
       FROM  dbp_view.v_kostenart_1 v04
       WHERE        v04.mandant_id = 1 AND
       v04.krk_id='XX01'
   ) v04
   ON  v01.gegenkonto_id = v04.gegenkonto_id_

   JOIN  dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id
   
   WHERE
   --KRK DE02 in DE ausschließen
     (v01.krk_id <> 'DE02' OR v01.mandant_id <> 1) AND
     -- CS Aufträge soll nur im Soll ausgegeben werden, keine Habenbuchungen, bis neues Feld in TD abgezogen wird (Workaround für Inc. DE13638552)
   (v01.psp_id >= -1
   OR
   (v01.psp_id < -1
   AND v01.soll_haben_kz = 'S'
   )
   ) AND
   --Alles was nicht auf PSP gebucht wird, ist für IMS Auswertungen nicht relevant
   v01.psp_id <> -1  AND
   --HB3 und Steuerliche Sichten werden ausgeschlossen -> oblsolet durch neues Hauptbuch
   --NOT v01.kostenart_id  LIKE ANY ('I%', 'S%')  AND
   --Auszuschliessenden Kostenarten
   LTRIM(TRIM(TO_VARCHAR(v01.kostenart_id)),'0')  NOT IN  ('912000', '979002', 'H912000', 'H979002', '880100', '940003')  AND
   -- nur HB2 Buchungen anzeigen für Altdaten (ab 09.2015 ist das flag immer 1)
   hb2_fg = 1
   ;