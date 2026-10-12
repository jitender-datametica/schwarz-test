create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_F_OBLIGO_2(
	MANDANT_ID,
	PSP_ID,
	PROJEKT_TYP_ID,
	GJ,
	BUCHUNGSPERIODE_ID,
	BUCHUNGSKREIS_ID,
	DAT_BUCH,
	DAT_BELEG,
	REF_BELEG_ID,
	REF_BELEG_POS_ID,
	KRK_ID,
	IN_LIEF_ID,
	BETRAG,
	AUFTRAG_ID,
	KOSTENART_ID,
	ANLAGE_ID,
	ANLAGE_SUB_ID,
	ANLAGE_BUCHUNGSKREIS_ID,
	BERICHTS_POSITION_IT_ID,
	BERICHTS_POSITION_INVEST_ID,
	SPARTE_ID,
	IN_ART_ID,
	OBLIGO_VERSION_ID,
	OBLIGO_WRG_TYP_ID,
	DAT_VON,
	DAT_BIS,
	KOSTENSTELLE_ID,
	BESTELL_TEXT,
	BETRAG_PLAN,
	BEDARF_NR
) as
    SELECT v01.mandant_id,
           v01.psp_id,
           projekt_typ_id,
           v01.gj,
           v01.buchungsperiode_id,
           buchungskreis_id,
           v01.dat_buch,
           v01.dat_beleg,
           v01.ref_beleg_id,
           v01.ref_beleg_pos_id,
           v01.krk_id,
           in_lief_id,
           CASE WHEN v400.wrg_typ_id = 1 THEN v01.betrag ELSE v01.betrag * umrechnungskurs END AS betrag,
           v01.auftrag_id,
           kostenart_id,
           anlage_id,
           anlage_sub_id,
           anlage_buchungskreis_id,
           v01.berichts_position_it_id,
           v01.berichts_position_invest_id,
           sparte_id,
           in_art_id,
           v01.obligo_version_id,
           v01.obligo_wrg_typ_id,
           v01.dat_von,
           v01.dat_bis,
           kostenstelle_id,
           v01.bestell_text,
           v01.betrag_plan,
           v01.bedarf_nr
           
  FROM  DBP_MSI_VIEW_IMS_MATERIALIZED.TBL_MV_F_OBLIGO_2 v01

  -- Ermittlung der eingestellter Währung
  CROSS JOIN  dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

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
   AND CURRENT_DATE BETWEEN v500.dat_von 
   AND v500.dat_bis;