CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.TBL_MV_F_OBLIGO_IT_PROJEKTE_1 AS
    -- 02.04.2013 AL Init
    -- 22.04.2013 AL Einschränkung auf IT Projekte PSP Elemente aufgenommen
    -- 29.05.2013 AL AL Logik für It Plan Ebene ID
    -- 03.06.2013 AL Abbildung Analyseprojekte- Kosten Analyseprojekte werden in Hauptprojekt uaf die Berichtsposition 11 gemappt
    -- 13.06.2013 twie: buchungskreis_id hinzugefügt sowie anlage_buchungskreis_id diese ist leer wenn keine anlage_1 vorhanden
    -- 22.08.2013 twie: kostenstelle_id ausgeben
    -- 17.09.2013 AL berichts_position_it_rwi_id aufgenommen
    -- 17.02.2014 twie: Analyseprojekte wieder ausbauen, wird nicht mehr verwendet
    -- 12.06.2014 twie: kostenart_id 48011 ausschließen
    -- 27.08.2014 twie: neu bestell_text, betrag_plan
    -- 29.08.2014 twie: Dummy_1 für buchungskreis_id
    -- 02.12.2014 twie: krk_id DE02 in DE ausschließen
    -- 13.07.2016 twie SPEC0012030 Filter auf ims_projekt_typ_id
    -- 11.04.2017 twie: SPEC0020157 neues Feld bedarf_nr
    -- 26.03.2018 twie: NSR0127115 kostenart_id 48011 nicht mehr ausfiltern

   SELECT

   v01.mandant_id,
   v01.psp_id AS it_psp_id,
   psp_id_char AS it_psp_id_char,
   --Falls Sparte Zentrale Int (KI) oder KIS, dann bei Länder unter KI (Kaufland International ohne Land_1 Zuordnung)
   CASE
    WHEN v01.sparte_id  IN (6,8)  THEN 1
    WHEN v01.mandant_id =1 THEN 2
    WHEN v01.mandant_id =2 THEN 3
    WHEN v01.mandant_id =3 THEN 6
    WHEN v01.mandant_id =5 THEN 4
    WHEN v01.mandant_id =6 THEN 5
    WHEN v01.mandant_id =7 THEN 7
    WHEN v01.mandant_id=8 THEN 8
    END it_plan_ebene_id,
   COALESCE(v01.in_art_id, -1) in_art_id,
   v01.gj,
   v01.buchungsperiode_id,
   COALESCE(v01.buchungskreis_id, -1) AS buchungskreis_id,
   v01.dat_buch,
   v01.dat_beleg,
   v01.ref_beleg_id,
   v01.ref_beleg_pos_id,
   v01.krk_id,
   COALESCE(v01.in_lief_id,-1) AS in_lief_id,
   LTRIM(COLLATE(v01.kostenart_id,''),'0') AS kostenart_id,
   COALESCE(v01.anlage_id, '') AS anlage_id,
   COALESCE(v01.anlage_sub_id, 0) AS anlage_sub_id,
   CAST(CASE WHEN v01.anlage_id IS NULL THEN -1
    ELSE v01.buchungskreis_id
    END AS SMALLINT) AS anlage_buchungskreis_id,
   v01.berichts_position_it_id,
   berichts_position_it_id AS berichts_position_it_rwi_id,
   -- KI zu der Zentrale hinzufügen
   CASE WHEN  v01.sparte_id = 8 THEN 5
    ELSE sparte_id
    END sparte_id,
   v01.dat_von,
   v01.dat_bis,
   COALESCE(kostenstelle_id, '') AS kostenstelle_id,
   v01.bestell_text,
   v01.betrag_plan,
   v01.bedarf_nr,
   v01.wrg_id,
   v01.Betrag,
   v01.obligo_version_id,
   v01.obligo_wrg_typ_id,
   v01.ref_belegart_id,
   v01.ref_termin_pos_id,
   v01.ref_kontierung_id,
   v01.ref_objektart_id

   FROM dbp_view.v_obligo_per_1 v01

   JOIN dbp_view.v_in_psp_element_1 v02
   ON v01.psp_id = v02.psp_id AND
   v01.mandant_id = v02.mandant_id

   --zur Ermittlung Projekttyp
   JOIN dbp_view.v_in_projekt_1 v03
   ON v02.in_projekt_id = v03.in_projekt_id AND
   v02.mandant_id = v03.mandant_id

   /*LEFT JOIN  dbp_view.v_it_projekt_1 v03
   -- Bei IT Prtojektnummer PSP ID ist immer identisch mit der Projektnummer
   ON v02.psp_id_char = v03.it_projekt_analyse_id */

   JOIN dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id

   WHERE

   --KRK DE02 in DE ausschließen
   (v01.krk_id <> 'DE02' OR v01.mandant_id <> 1) AND

   -- IT Projekte
   v03.ims_projekt_typ_id = 'P'  AND

   --Neue Projekte nur statistisch
   v02.statistisch_fg  = 1 AND

   --Auszuschliessenden Kostenarten
   NOT (COLLATE(v01.kostenart_id,'') LIKE ANY ('912000', '979002', 'H912000', 'H979002' ))

   QUALIFY  RANK() OVER
   (
   PARTITION BY
    v01.mandant_id
   ,v01.krk_id
   ,v01.obligo_version_id
   ,v01.obligo_wrg_typ_id
   ,v01.ref_beleg_id
   ,v01.ref_beleg_pos_id
   ,v01.ref_belegart_id
   ,v01.ref_termin_pos_id
   ,v01.ref_kontierung_id
   ,v01.ref_objektart_id
   ,v01.dat_bis
   ORDER BY v01.dat_von DESC NULLS LAST) =1   ;