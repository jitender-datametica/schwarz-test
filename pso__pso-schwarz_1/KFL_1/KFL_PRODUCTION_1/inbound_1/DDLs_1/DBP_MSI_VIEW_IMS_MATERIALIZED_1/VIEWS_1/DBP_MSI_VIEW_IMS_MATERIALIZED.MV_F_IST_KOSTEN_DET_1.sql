create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_F_IST_KOSTEN_DET_1(
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
) as
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

FROM DBP_MSI_VIEW_IMS_MATERIALIZED.TBL_MV_F_IST_KOSTEN_DET_1 v01


CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200


CROSS JOIN  dbp_msi.akt_msi_user_kurstyp_zu_1 v300

JOIN  dbp_view.v_mandant_wrg_typ_zu_1 v400
  ON v01.mandant_id = v400.mandant_id  
  AND v200.wrg_typ_id = v400.wrg_typ_id


JOIN   dbp_view.v_kurs_1 v500
  ON v300.kurstyp_id = v500.kurstyp_id
  AND v01.wrg_id = v500.von_wrg_id
  AND v500.nach_wrg_id ='EUR'
  AND CURRENT_DATE BETWEEN v500.dat_von AND v500.dat_bis;