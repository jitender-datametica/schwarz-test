CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_F_OBLIGO_IT_PROJEKTE_1
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

AS
   SELECT

   v01.mandant_id,
   it_psp_id,
   it_psp_id_char,
   it_plan_ebene_id,
   in_art_id,
   v01.gj,
   v01.buchungsperiode_id,
   buchungskreis_id,
   v01.dat_buch,
   v01.dat_beleg,
   v01.ref_beleg_id,
   v01.ref_beleg_pos_id,
   v01.krk_id,
   in_lief_id,
   CASE WHEN v400.wrg_typ_id = 1
    THEN v01.betrag
    ELSE v01.betrag * umrechnungskurs
   END AS it_projekte_obligo,
   kostenart_id,
   anlage_id,
   anlage_sub_id,
   anlage_buchungskreis_id,
   v01.berichts_position_it_id,
   berichts_position_it_rwi_id,
   sparte_id,
   v01.dat_von,
   v01.dat_bis,
   kostenstelle_id,
   v01.bestell_text,
   v01.betrag_plan,
   v01.bedarf_nr

   FROM  dbp_msi_view_ims.TBL_MV_F_OBLIGO_IT_PROJEKTE_1 v01

   -- Ermittlung der eingestellter Währung
   CROSS JOIN  dbp_msi.akt_msi_user_wrg_typ_zu_1 v200

   -- Ermittlung Kurstyp
   CROSS JOIN  dbp_msi.akt_msi_user_kurstyp_zu_1 v300

   JOIN  dbp_view.v_mandant_wrg_typ_zu_1 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   -- Umrechnung Standardkurs, Tageskurs
   JOIN dbp_view.v_kurs_1 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND CURRENT_DATE BETWEEN v500.dat_von AND v500.dat_bis
   
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
   ORDER BY v01.dat_von DESC NULLS LAST) =1
;
