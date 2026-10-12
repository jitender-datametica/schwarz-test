create or replace view DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_IST_KOSTEN_DET_1(
	MANDANT_ID,
	PSP_ID,
	GJ,
	BUCHUNGSPERIODE_ID,
	KRK_ID,
	SOLL_HABEN_KZ,
	KOSTENART_ID,
	DAT_BELEG,
	BELEG_ID,
	BELEG_POS_ID,
	BETRAG,
	WRG_ID,
	WRG_TYP_ID,
	GESCHAEFTSBEREICH_ID,
	BELEG_BEZ,
	IN_LIEF_ID,
	NEBENKONTIERUNG_ID,
	NEBENKONTIERUNGSART_ID,
	BERICHTS_POSITION_IT_ID,
	BERICHTS_POSITION_INVEST_ID,
	SPARTE_ID,
	AUFTRAG_ID,
	IN_ART_ID,
	BUCHUNGSKREIS_ID,
	ANLAGE_ID,
	ANLAGE_SUB_ID,
	DAT_BUCH,
	MENGE,
	MENGE_EINH_ID,
	KOSTENSTELLE_ID,
	GEGENKONTO_ID,
	GEGENKONTOART_ID,
	REF_BELEG_ID,
	REF_FI_BELEG_ID,
	IN_FI_BELEGKOPFTEXT,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	PARTNER_OBJEKTART_ID,
	PARTNER_OBJEKT_ID,
	BESTELL_TEXT,
	REF_BUCHUNGSKREIS_ID,
	BELEGART_ID,
	BELASTUNGS_KZ,
	REF_VORGANG_ID,
	CO_LEISTUNGSART_ID
) as
   SELECT
   v01.mandant_id, v01.psp_id, v01.gj, v01.buchungsperiode_id, v01.krk_id, v01.soll_haben_kz, v01.kostenart_id, v01.dat_beleg, v01.beleg_id, v01.beleg_pos_id, CASE WHEN v03.wrg_typ_id = 0
   THEN (v01.betrag * v02.umrechnungskurs)
   ELSE v01.betrag
   END AS betrag, v03.wrg_id, v03.wrg_typ_id, v01.geschaeftsbereich_id, v01.beleg_bez, v01.in_lief_id, v01.nebenkontierung_id, COALESCE(v01.nebenkontierungsart_id,'') AS nebenkontierungsart_id, v01.berichts_position_it_id, v01.berichts_position_invest_id, v01.sparte_id, v01.auftrag_id, v01.in_art_id, v01.buchungskreis_id, v01.anlage_id, v01.anlage_sub_id, v01.dat_buch, v01.menge, v01.menge_einh_id, v01.kostenstelle_id, v01.gegenkonto_id, v01.gegenkontoart_id, v01.ref_beleg_id, v01.ref_fi_beleg_id, v01.in_fi_belegkopftext, v01.best_beleg_id, v01.best_beleg_pos_id, v01.partner_objektart_id, v01.partner_objekt_id, v01.bestell_text, v01.ref_buchungskreis_id, v01.belegart_id, v01.belastungs_kz, v01.ref_vorgang_id, v01.co_leistungsart_id
   FROM dbp_view.v_ist_kosten_det_1 v01

   JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_kurs_1 v02
   ON v01.wrg_id = v02.von_wrg_id

   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03
   ON v01.mandant_id = v03.mandant_id
   WHERE extract(year from v01.dat_buch) >= year(current_timestamp) - 2;