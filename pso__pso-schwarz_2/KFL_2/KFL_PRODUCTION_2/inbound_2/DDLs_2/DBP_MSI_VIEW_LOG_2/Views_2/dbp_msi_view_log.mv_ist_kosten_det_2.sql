CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IST_KOSTEN_DET_2(
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
	REFERENZ_AUFTRAG_ID,
	LEISTUNGSART_REFERENZBELEG,
	FOLGEAUFTRAG_FG,
	KOSTENSTELLE_ID_AUFTRAG,
	VERANTW_ARBEITSPLATZ_NAME,
	STANDORT_ID,
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
	CO_LEISTUNGSART_ID,
	AUFTRAGSART_ID,
	WERK_ID,
	FLAECHE_QM,
	TP_OBJEKT_ID,
	AUFTRAG_KURZTEXT,
	STORNO_FG,
	TECHN_PLATZ_ID
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial
--2022-12-19, AP0133256,SPEC0166769,dknop, adding flaeche_qm
--2023-02-07, AP0133256,SPEC0166769,dknop, adding auftragsart_id 
--2023-03-13, dknop, adding storno_fg
--2024-02-19, dknop, adding TECHN_PLATZ_ID
--2024-03-11, updating definition of flaeche_qm
--2024-03-12, dknop, correcting joint to dbp_msi_view_log.v_ts_in_werk_flaeche_per_2
--2024-03-12, dknop, updating definition of tp_objekt_id to avoid duplications
--2024-08-27, AP0226234,SPEC0255818, dknop, change tp_objekt_id source from v_in_instandhaltung_objekt_qual_2 to v_in_instandhaltung_2, adding REFERENZ_AUFTRAG_ID, LEISTUNGSART_REFERENZBELEG, FOLGEAUFTRAG_FG,KOSTENSTELLE_ID,VERANTW_ARBEITSPLATZ_NAME,STANDORT_ID,
--2024-12-13, dknop, removing try_cast from standort_id definition and changing it to CHAR from INTEGER
--2025-04-15, dknop, correcting join to v_in_instandhaltung_2 for referenz_auftrag_id
 SELECT
    v01.mandant_id
   ,v01.psp_id
   ,v01.gj
   ,v01.buchungsperiode_id
   ,v01.krk_id
   ,v01.soll_haben_kz
   ,v01.kostenart_id
   ,v01.dat_beleg
   ,v01.beleg_id
   ,v01.beleg_pos_id
   ,CASE WHEN v03.wrg_typ_id = 0 THEN (v01.betrag * v02.umrechnungskurs)
          ELSE v01.betrag END AS betrag
   ,v03.wrg_id
   ,v03.wrg_typ_id
   ,v01.geschaeftsbereich_id
   ,v01.beleg_bez
   ,v01.in_lief_id
   ,v01.nebenkontierung_id
   ,COALESCE(v01.nebenkontierungsart_id,'') AS nebenkontierungsart_id
   ,v01.berichts_position_it_id
   ,v01.berichts_position_invest_id
   ,v01.sparte_id
   ,v01.auftrag_id
   ,v05.referenz_auftrag_id AS referenzbeleg
   ,v07b.instandhaltung_leistungsart_id AS leistungsart_referenzbeleg
   ,CASE WHEN COALESCE(v07.instandhaltung_leistungsart_id,v07a.instandhaltung_leistungsart_id) = '003' AND v07b.instandhaltung_leistungsart_id IN ('001','002','012', '019') THEN 1 ELSE 0 END AS folgeauftrag_fg
   ,v05.kostenstelle_id AS kostenstelle_id_auftrag
   ,v05.verantw_arbeitsplatz_name
   ,COALESCE(COALESCE(CAST(v09.aktuell_wup_id AS VARCHAR), v05.standort_id),'-1')  AS standort_id
   ,v01.in_art_id
   ,v01.buchungskreis_id
   ,COALESCE(v01.anlage_id,'-1') AS anlage_id
   ,v01.anlage_sub_id
   ,v01.dat_buch
   ,v01.menge
   ,v01.menge_einh_id
  -- ,COALESCE(CASE WHEN v01.kostenstelle_id = '' THEN NULL ELSE v01.kostenstelle_id END,'-1') AS kostenstelle_id
   ,COALESCE(CASE WHEN v01.kostenstelle_id = '' THEN NULL ELSE v01.kostenstelle_id END,'') AS kostenstelle_id
   ,v01.gegenkonto_id
   ,v01.gegenkontoart_id
   ,v01.ref_beleg_id
   ,v01.ref_fi_beleg_id
   ,v01.in_fi_belegkopftext
   ,v01.best_beleg_id
   ,v01.best_beleg_pos_id
   ,v01.partner_objektart_id
   ,v01.partner_objekt_id
   ,v01.bestell_text
   ,v01.ref_buchungskreis_id
   ,v01.belegart_id
   ,v01.belastungs_kz
   ,v01.ref_vorgang_id
   ,CASE WHEN v01.co_leistungsart_id='' THEN '-1' ELSE v01.co_leistungsart_id END AS co_leistungsart_id
   ,v05.auftragsart_id 
   ,v05.werk_id 
   ,CASE WHEN v05.auftragsart_id IN ('CS76', 'CS77', 'CS46', 'CS47') THEN v06.flaeche_qm ELSE NULL END AS flaeche_qm
   ,COALESCE(COALESCE(v07.tp_objekt_id,v07a.tp_objekt_id),'-1') AS tp_objekt_id
   ,v05.auftrag_kurztext
   ,COALESCE (v08.storno_fg,0)
   ,COALESCE (v05.techn_platz_id,'-1')
   FROM dbp_view.v_ist_kosten_det_2 v01

   LEFT JOIN dbp_msi_view_log.mv_kurs_2 v02
   ON v01.wrg_id = v02.von_wrg_id
   INNER JOIN dbp_view.v_mandant_wrg_typ_zu_2 v03 ON v01.mandant_id=v03.mandant_id  
   INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v04 ON v03.wrg_typ_id = v04.wrg_typ_id
   
   
   LEFT JOIN dbp_view.v_in_auftrag_2 v05
    ON v01.mandant_id=v05.mandant_id
   AND v01.auftrag_id=v05.auftrag_id
   
   LEFT JOIN dbp_msi_view_log.v_ts_in_werk_flaeche_per_2 v06
   ON v05.mandant_id=v06.mandant_id
   AND v05.werk_id=v06.werk_id
   AND v06.gebaeude_bez ILIKE 'TOTAL'
   AND v01.dat_buch BETWEEN v06.dat_von AND v06.dat_bis

   LEFT JOIN dbp_view.v_in_instandhaltung_2 v07
   ON v01.auftrag_id = v07.auftrag_id
   AND v01.mandant_id = v07.mandant_id
   AND v07.tp_objekt_id<>0
  
   LEFT JOIN dbp_view.v_in_instandhaltung_2 v07a
   ON v01.auftrag_id = v07a.auftrag_id
   AND v01.mandant_id = v07a.mandant_id
    AND v07a.tp_objekt_id=0 
 
   LEFT JOIN dbp_view.v_in_instandhaltung_2 v07b
   ON v05.referenz_auftrag_id  = v07b.auftrag_id
   AND v05.mandant_id = v07b.mandant_id
  
   LEFT JOIN  dbp_data.wup_2 v09
   ON  TRY_CAST(v05.standort_id AS INTEGER) = v09.wup_id
   AND v05.mandant_id = v09.mandant_id
   
   LEFT JOIN (SELECT DISTINCT auftrag_id, mandant_id, dat_buch, storno_fg FROM dbp_view.v_in_auftrag_rm_2) v08
   ON v01.auftrag_id=v08.auftrag_id
   AND v01.mandant_id=v08.mandant_id
   AND v01.dat_buch=v08.dat_buch
   
  WHERE EXTRACT(YEAR FROM v01.dat_buch) >= YEAR(CURRENT_TIMESTAMP) - 2  
   ;