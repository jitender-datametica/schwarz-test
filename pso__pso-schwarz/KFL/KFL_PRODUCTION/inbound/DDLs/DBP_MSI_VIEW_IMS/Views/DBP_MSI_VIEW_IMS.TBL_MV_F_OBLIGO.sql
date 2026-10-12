CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.TBL_MV_F_OBLIGO
-- 11.06.2013 twie: Viewerstellung analog zu mv_f_ist_kosten_det
-- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage vorhanden
-- 08.07.2013 AL : Beim Abbau von Obligo gibt es keine Gegenbuchung, sondern der Belegwert wird auf 0 gesetzt und
--                            darf in Berichten nicht angezeigt werden. ==> Einschränkung betrag <> 0.0
-- 15.07.2013 AL: Ausschluss von nicht relevanten Konten, keine Unterscheidung HB1/HB2 erforderlich
--                           Umstellung auf obligo_per

-- 18.07.2013 AL auftrag_id aufgenommen
-- 31.07.2013 AL Anpassung für Sparte ID Tip, KI, KIS auf die Zentrale mappen
-- 22.08.2013 twie: kostenstelle_id ausgeben
-- 12.09.2013 AL Umrechnung zum aktuellen Kurs
-- 24.09.2013 AL Ref Beleg ID in die View aufgenommen
-- 12.06.2014 twie: kostenart_id 48011 ausschließen
-- 27.08.2014 twie: neu bestell_text, betrag_plan
-- 29.08.2014 twie: Dummy für buchungskreis_id
-- 02.12.2014 twie: krk_id DE02 in DE ausschließen
-- 08.07.2015 mcan1401: ims_projekt_typ_id in die Tabelle in_projekt aufgenommen und direkt referenziert
-- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
-- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern
-- 20.10.2022 prescherad: NSR3269480 Feld planungs_element_id ausbauen da nicht mehr benötigt
AS
    SELECT v01.mandant_id,
           v01.psp_id,
           v03.ims_projekt_typ_id AS projekt_typ_id,
           --auskommentieren aktuell nicht benötigtes Feld Plaungs_element_ID
           --CAST( -- Standort bzw. Projekt zu Istkosten ermitteln
           --       CASE WHEN v03.ims_projekt_typ_id IN ('A', 'B', 'E', 'G', 'I') THEN SUBSTRING(v03.in_projekt_id_char, 3, 4)
           --            WHEN v03.ims_projekt_typ_id IN ('P') AND v01.sparte_id = 1 THEN 21 --PR_V
           --            WHEN v03.ims_projekt_typ_id IN ('P') AND v01.sparte_id = 2 THEN 22 --PR_L
           --            WHEN v03.ims_projekt_typ_id IN ('P') AND v01.sparte_id = 3 THEN 23 --PR_F
           --            WHEN v03.ims_projekt_typ_id IN ('P') AND v01.sparte_id IN (4,5,6) THEN 25 --PR_Z
           --            ELSE NULL
           --       END AS INTEGER
           --     ) AS planungs_element_id,
           v01.gj,
           v01.buchungsperiode_id,
           COALESCE(v01.buchungskreis_id, -1) AS buchungskreis_id,
           v01.dat_buch,
           v01.dat_beleg,
           v01.ref_beleg_id,
           v01.ref_beleg_pos_id,
           v01.krk_id,
           COALESCE(v01.in_lief_id,-1) AS in_lief_id,
           v01.auftrag_id,
           LTRIM(COLLATE(v01.kostenart_id,''),'0') AS kostenart_id,
           COALESCE(v01.anlage_id, '') AS anlage_id,
           COALESCE(v01.anlage_sub_id, 0) AS anlage_sub_id,
           CAST(CASE WHEN v01.anlage_id IS NULL THEN -1 ELSE v01.buchungskreis_id END AS SMALLINT) AS anlage_buchungskreis_id,
           v01.berichts_position_it_id,
           v01.berichts_position_invest_id,
           CASE WHEN v01.sparte_id IN (4,6,8) THEN 5 ELSE v01.sparte_id END sparte_id,
           COALESCE(v01.in_art_id, -1) AS in_art_id,
           v01.obligo_version_id,
           v01.obligo_wrg_typ_id,
           v01.dat_von,
           v01.dat_bis,
           COALESCE(kostenstelle_id, '') AS kostenstelle_id,
           v01.bestell_text,
           v01.betrag_plan,
           v01.bedarf_nr,
           v01.wrg_id,
           v01.betrag

  FROM dbp_view.v_obligo_per v01

  JOIN dbp_view.v_in_psp_element v02
  ON v01.psp_id = v02.psp_id
  AND v01.mandant_id = v02.mandant_id

  JOIN dbp_view.v_in_projekt v03
  ON v02.in_projekt_id = v03.in_projekt_id
  AND v02.mandant_id = v03.mandant_id

  JOIN dbp_view.v_mandant v100
  ON v01.mandant_id = v100.mandant_id

  WHERE
  --KRK DE02 in DE ausschließen
  (v01.krk_id <> 'DE02' OR v01.mandant_id <> 1)
  AND v01.psp_id <> -1 
  --Auszuschliessenden Kostenarten
  AND NOT TRIM(COLLATE(v01.kostenart_id,''), '0')   IN  ('912000', '979002', 'H912000', 'H979002' );