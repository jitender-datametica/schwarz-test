create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_LIEFERANTENMANAGEMENT_2(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	DAT_BUCH,
	ENDLIEF_FG,
	ENDLIEF_FG_EKPO,
	ZEIT_ENDLIEF_FG,
	BEST_MENGE_ORIG_FG,
	ANNAHMEVERWEIGERUNG_ID,
	NB_ID,
	ART_ID,
	BELEG_GP_ID,
	WUP_ID,
	BESTELLART_ID,
	DAT_BEST_BELEG,
	DAT_LIEF_WUNSCH,
	DAT_LIEF_BEWERTUNG,
	MENGE_LIEF,
	BETRAG_LAGERBEW_EK_N,
	BETRAG_BEST_EK_N,
	MENGE_BEST_BME,
	MENGE_BEST_ORIG,
	MENGE_BEST_KOLLI_ORIG,
	MENGE_IST_KOLLI_ORIG,
	LAGERORT_ID,
	GP_ID,
	LOESCH_FG_EKKO,
	LOESCH_FG_EKPO,
	SELBSTABHOL_FG,
	ANZAHL_LIEF,
	ANZAHL_LIEF_POS,
	LAGER_BEWART_ID,
	MENGE_GESAMT,
	KOLLIFAKTOR,
	MENGE_IWT,
	MENGE_WERBUNG,
	MENGE_NONWBS,
	MENGE_NORMAL,
	WERBUNG_FG,
	WRG_ID,
	VK_NETTO_LIEF_SOLL,
	VK_NETTO_LIEF_IST,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI,
	MENGE_LIEF_IST_KOLLI_KUM,
	FEHLLIEFERUNG_MENGE,
	FEHLLIEFERUNG_MENGE_LAST_VALUE,
	FEHLLIEFERUNG_MENGE_CASE,
	SOLL_IST_LIEFERDATUM_DIFF,
	SOLL_IST_LIEFERDATUM_DIFF_SALDO,
	IWT_ID,
	NEUER_ARTIKEL_FG,
	PLANLIEFERZEIT,
	GP_TEILSORTIMENT_ID,
	REICHWEITE,
	GP_DISPO_MULTI_ID,
	RATIO,
	BEDARFSNUMMER,
	MENGE_WERBUNG_OFFEN_KUM,
	MENGE_LIEF_OFFEN_KUM,
	MENGE_LIEF_IST_WERBUNG_CALC,
	MENGE_LIEF_IST_NORMAL_CALC,
	MENGE_LIEF_IST_BEVORRATUNG_CALC,
	MENGE_LIEF_IST_IWT_CALC,
	MENGE_OFFEN_VOR_DIESER_LIEFERUNG
) as
SELECT 
v01.mandant_id
,v01.best_beleg_id
,v01.best_beleg_pos_id
,v01.DAT_BUCH
,v01.ENDLIEF_FG
,v01.endlief_fg_ekpo
,v01.ZEIT_ENDLIEF_FG
,v01.BEST_MENGE_ORIG_FG AS BEST_MENGE_ORIG_FG_ 
,v01.annahmeverweigerung_id
,v01.nb_id
,v01.art_id
,v01.beleg_gp_id
,v01.wup_id
,v01.bestellart_id
,v01.dat_best_beleg
,v01.dat_lief_wunsch
,v01.dat_lief_bewertung
,v01.menge_lief
,v01.betrag_lagerbew_ek_n
,v01.betrag_best_ek_n
,v01.menge_best_bme
,v01.menge_best_orig
,v01.menge_best_kolli_orig
,v01.menge_ist_kolli_orig
,v01.lagerort_id
,v01.gp_id
,v01.loesch_fg_ekko
,v01.loesch_fg_ekpo
,v01.selbstabhol_fg
,v01.anzahl_lief
,v01.anzahl_lief_pos
,v01.lager_bewart_id
,v01.MENGE_GESAMT
,v01.KOLLIFAKTOR
,v01.MENGE_IWT
,v01.MENGE_WERBUNG
,v01.MENGE_NONWBS
,v01.MENGE_NORMAL
,v01.werbung_fg
,CASE WHEN user_wrg.wrg_typ_id=0 THEN 'EUR' ELSE v01.wrg_id END AS wrg_id
,CASE WHEN user_wrg.wrg_typ_id=0 THEN v01.vk_netto_lief_soll*kurs.umrechnungskurs ELSE  v01.vk_netto_lief_soll END  AS vk_netto_lief_soll  
,CASE WHEN user_wrg.wrg_typ_id=0 THEN  v01.vk_netto_lief_ist*kurs.umrechnungskurs ELSE  v01.vk_netto_lief_ist END  AS vk_netto_lief_ist 
,v01.menge_lief_soll_kolli
,v01.menge_lief_ist_kolli
,SUM(menge_lief_ist_kolli) OVER (PARTITION BY v01.mandant_id, v01.best_beleg_id, v01.best_beleg_pos_id,
    v01.wup_id, v01.nb_id, v01.art_id ORDER BY v01.dat_buch, v01.lager_bewart_id
             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS menge_lief_ist_kolli_kum
,menge_lief_ist_kolli_kum - v01.menge_lief_soll_kolli  AS fehllieferung_menge           
,CASE WHEN ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.best_beleg_id,v01.best_beleg_pos_id,
    v01.wup_id, v01.nb_id, v01.art_id ORDER BY v01.dat_buch DESC, v01.lager_bewart_id DESC)= 1 THEN CASE WHEN (menge_lief_ist_kolli_kum - v01.menge_lief_soll_kolli)>0 THEN 0 ELSE (menge_lief_ist_kolli_kum - v01.menge_lief_soll_kolli) END
    ELSE 0 END AS fehllieferung_menge_last_value 
,CASE WHEN v01.endlief_fg IN (-1,-2) AND v01.zeit_endlief_fg<>-1  THEN fehllieferung_menge ELSE 0 END AS fehllieferung_menge_case 
,v01.soll_ist_lieferdatum_diff_abs
,v01.soll_ist_lieferdatum_diff
,v01.iwt_id
,v01.neuer_artikel_fg
,v01.planlieferzeit
,v01.gp_teilsortiment_id
,v01.reichweite
,v01.gp_dispo_multi_id
,v01.ratio
,v01.bedarfsnummer
,v01.menge_werbung-menge_lief_ist_kolli_kum AS menge_werbung_offen_kum
,menge_lief_soll_kolli - menge_lief_ist_kolli_kum AS menge_lief_offen_kum    
,CASE WHEN menge_werbung_offen_kum > 0 THEN menge_lief_ist_kolli ELSE menge_lief_ist_kolli + menge_werbung_offen_kum END
  AS menge_lief_ist_werbung_calc
, menge_lief_ist_kolli - menge_lief_ist_werbung_calc    AS menge_lief_ist_normal_calc
, menge_lief_ist_kolli - menge_lief_ist_werbung_calc  - menge_lief_ist_normal_calc  AS menge_lief_ist_bevorratung_calc 
, menge_lief_ist_kolli - menge_lief_ist_werbung_calc  - menge_lief_ist_normal_calc  - menge_lief_ist_bevorratung_calc AS menge_lief_ist_iwt_calc  
,CASE WHEN menge_lief_soll_kolli-(menge_lief_ist_kolli_kum-menge_lief_ist_kolli) < 0 THEN 0 ELSE menge_lief_soll_kolli-(menge_lief_ist_kolli_kum-menge_lief_ist_kolli) END AS menge_offen_vor_dieser_lieferung

FROM DBP_MSI_VIEW_SCM.MV_DT_LIEFERANTENMANAGEMENT_2 v01

JOIN dbp_msi_view_scm.mv_kurs_2 kurs_2
ON v01.wrg_id = kurs.von_wrg_id

CROSS JOIN dbp_msi_view_scm.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 user_wrg 
;
