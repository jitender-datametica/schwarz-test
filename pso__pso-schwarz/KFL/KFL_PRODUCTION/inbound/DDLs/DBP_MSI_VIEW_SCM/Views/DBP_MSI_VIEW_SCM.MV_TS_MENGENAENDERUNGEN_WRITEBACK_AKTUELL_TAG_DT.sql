create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_TS_MENGENAENDERUNGEN_WRITEBACK_AKTUELL_TAG_DT(
	MANDANT_ID,
	AKTION_ID,
	OFFER_ID,
	DAT_AB,
	DAT_BIS,
	ART_ID,
	GP_ID,
	DAT_BELADUNG,
	KJWO,
	KJWO_WW,
	TAGE_BIS_AKTIONSSTART,
	GENEHMIGT_FG,
	MENGE_OHNE_BESTAND_GENEHMIGT_FG,
	MENGE_MIT_BESTAND_GENEHMIGT_FG,
	UTP_LIEFERANT_BESTAETIGT_FG,
	MANDANT_ID_VZ,
	AKTIONSZEITRAUM,
	COUNT_MAERKTE,
	COUNT_MAERKTE_VERGLEICH,
	ANZAHL_MAERKTE_AGG,
	ANZAHL_ARTIKELNEUANLAGE_AGG,
	ANZAHL_ARTIKELENTFERNUNG_AGG,
	GK_FG,
	TITEL_FG,
	RUECKSEITE_FG,
	FIXMENGE_FG,
	TV_FG,
	STILLE_AKTION_FG,
	MAX_BEST_GENERIERT_FG,
	AKTION_REIHENFOLGE_ZUKUNFT_NR,
	NUR_ONLINE_FG,
	PREIS_NORMAL,
	PREIS_AKTION,
	WERBEAENDERUNG_ARTIKELNEUANLAGE_FG,
	WERBEAENDERUNG_ARTIKELENTFERNUNG_FG,
	WERBEAENDERUNG_MARKTANZAHLERHOEHUNG_FG,
	WERBEAENDERUNG_MARKTANZAHLREDUKTION_FG,
	WERBEAENDERUNG_ABBILDUNGSAENDERUNG_FG,
	GESTEUERTE_PROGNOSE_FG,
	PROGNOSE_WERBEZEITRAUM_BME,
	BESTELLMENGE_FINAL_AME,
	BESTELLMENGE_OHNE_BESTAND_AME,
	BESTELLMENGE_MIT_BESTAND_AME,
	BESTELLMENGE_OHNE_BESTAND_AME_KOLLI,
	BESTELLMENGE_MIT_BESTAND_AME_KOLLI,
	WERBEAENDERUNG_MENGE_VORLAUF,
	PROJIZIERTER_BESTAND_VOR_WERBUNG_BME,
	PREIS_NORMAL_VORLAUF,
	PREIS_AKTION_VORLAUF,
	BESTELLUNG_LIEFERANT_MENGE,
	MENGE_ZULETZT_DC_PROMO,
	WERBEAENDERUNG_MENGE_UEBERTRAGEN,
	FIXMENGE_BME,
	FIXMENGE_WFL_BME,
	MENGE_MINDESTPLATZIERUNG_CLUSTER_1_AME,
	MENGE_MINDESTPLATZIERUNG_CLUSTER_2_AME,
	MENGE_MINDESTPLATZIERUNG_CLUSTER_3_AME,
	WFL_GEPRUEFT_FG,
	WFL_NUTZER_KOMMENTAR_TXT,
	WBS_COMPOUND_FG,
	WBS_COMPOUND_FG_DE,
	WBS_COMPOUND_FG_PL,
	WBS_COMPOUND_FG_BG,
	WBS_COMPOUND_FG_SK,
	WBS_COMPOUND_FG_RO,
	WBS_COMPOUND_FG_CZ,
	WBS_COMPOUND_FG_HR,
	RANK_AKTION_BELADUNG,
	AUSLIEFERUNGSGRUPPE_ID,
	ESTIMATION_ID,
	ESTIMATION_BEZ,
	ADJUSTMENT_ID,
	ADJUSTMENT_BEZ,
	TD_UPDATE,
	BONUSKAUF_PROMOTIONSTYP,
	WUP_COUNT_ANGEBOT,
	ART_COUNT_ANGEBOT,
	MULTI_OFFER_ID_FG,
	ESTIMATION_CHANGE_FG,
	ADJUSTMENT_CHANGE_FG,
	WFL_MENGE_GEPRUEFT_FG_CHANGE_FG,
	WFL_NUTZER_KOMMENTAR_TXT_CHANGE_FG,
	FIXMENGE_WFL_BME_CHANGE_FG,
	MENGE_MINDESTPLATZIERUNG_CLUSTER_1_AME_CHANGE_FG,
	MENGE_MINDESTPLATZIERUNG_CLUSTER_2_AME_CHANGE_FG,
	MENGE_MINDESTPLATZIERUNG_CLUSTER_3_AME_CHANGE_FG,
	MENGE_MIT_BESTAND_GENEHMIGT_FG_CHANGE_FG,
	MENGE_OHNE_BESTAND_GENEHMIGT_FG_CHANGE_FG,
	BEDARF_ESTIMATION_2_BME,
	BESTELLMENGE_ESTIMATION_2_OHNE_BESTAND_AME,
	BESTELLMENGE_ESTIMATION_2_MIT_BESTAND_AME
) as




SELECT 
   v01.mandant_id
 , v01.aktion_id
 , v01.offer_id
 , v01.dat_ab
 , v01.dat_bis
 , v01.art_id
 , COALESCE((CASE WHEN v01.gp_id=0 THEN -1 ELSE v01.gp_id END),-1) AS gp_id_
 , v01.dat_beladung
 , v01.kjwo
 , v9.kjwo_ww
 , (v01.dat_ab - v01.dat_beladung) AS tage_bis_aktionsstart
 , CAST(COALESCE(v02.menge_ohne_bestand_genehmigt_fg,0) AS BYTEINT) AS genehmigt_fg
 , CAST(COALESCE(v02.menge_ohne_bestand_genehmigt_fg,0) AS BYTEINT) AS menge_ohne_bestand_genehmigt_fg
 , CAST(COALESCE(v02.menge_mit_bestand_genehmigt_fg,0) AS BYTEINT) AS menge_mit_bestand_genehmigt_fg
 , v01.utp_lieferant_bestaetigt_fg
 , CASE WHEN v01.wup_id_vz = 6140 THEN 4 ELSE v01.mandant_id_vz END AS mandant_id_vz
 , SUBSTR(TRIM(v01.kjwo),5,2) || '/' || SUBSTR(TRIM(v01.kjwo),1,4) || ' / ' || TO_CHAR(v01.dat_ab,'DD.MM.YYYY') || ' - ' || TO_CHAR(v01.dat_bis,'DD.MM.YYYY') AS aktionszeitraum
 , COUNT(DISTINCT CASE WHEN werbeaenderung_artikelentfernung_fg = 1 THEN NULL ELSE v01.wup_id END) AS count_maerkte 
 , COUNT(DISTINCT v01.wup_id) AS count_maerkte_vergleich  
 , SUM(count_maerkte_vergleich) OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.dat_ab, v01.dat_bis,v01.dat_beladung ) AS Anzahl_maerkte_agg 
 , SUM(SUM(V01.werbeaenderung_artikelneuanlage_fg))  OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.dat_ab, v01.dat_bis,v01.dat_beladung ) AS anzahl_artikelneuanlage_agg 
 , SUM(SUM(V01.werbeaenderung_artikelentfernung_fg))  OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.dat_ab, v01.dat_bis,v01.dat_beladung ) AS anzahl_artikelentfernung_agg       
  , MAX(COALESCE(v02.gk_fg, v01.gk_fg)) AS gk_fg_ 

 , MAX(v01.titel_fg) AS titel_fg
 , MAX(v01.rueckseite_fg) AS rueckseite_fg
 , MAX(v01.fixmenge_fg) AS fixmenge_fg
 , MAX(v01.tv_fg) AS tv_fg
 , MAX(v01.stille_aktion_fg) AS stille_aktion_fg
 , MAX(v01.best_generiert_fg) AS max_best_generiert_fg
 , MAX(v01.aktion_reihenfolge_zukunft_nr) AS aktion_reihenfolge_zukunft_nr
 , MAX(v01.nur_online_fg) AS nur_online_fg
 , AVG(COALESCE(v01.preis_normal,0)) AS preis_normal 
 , AVG(COALESCE(v01.preis_aktion,0)) AS preis_aktion
 
 , CASE WHEN anzahl_artikelneuanlage_agg = Anzahl_maerkte_agg THEN 1 ELSE 0 END AS werbeaenderung_artikelneuanlage_fg
 , CASE WHEN anzahl_artikelentfernung_agg = Anzahl_maerkte_agg THEN 1 ELSE 0 END AS werbeaenderung_artikelentfernung_fg

 , MAX(v01.werbeaenderung_marktanzahlerhoehung_fg) AS werbeaenderung_marktanzahlerhoehung_fg
 , MAX(v01.werbeaenderung_marktanzahlreduktion_fg) AS werbeaenderung_marktanzahlreduktion_fg
 , MAX(v01.werbeaenderung_abbildungsaenderung_fg) AS werbeaenderung_abbildungsaenderung_fg 
 , COALESCE(MAX(v01.gesteuerte_prognose_fg),0) AS gesteuerte_prognose_fg 
 , SUM(v01.prognose_werbezeitraum_bme) AS prognose_werbezeitraum_bme 
 , 0 AS bestellmenge_final_ame 
 , SUM(v01.bestellmenge_ohne_bestand_ame) AS bestellmenge_ohne_bestand_ame
 , SUM(v01.bestellmenge_mit_bestand_ame) AS bestellmenge_mit_bestand_ame 
 , SUM(v01.bestellmenge_ohne_bestand_ame * v01.kollifaktor) AS bestellmenge_ohne_bestand_ame_kolli
 , SUM(v01.bestellmenge_mit_bestand_ame * v01.kollifaktor) AS bestellmenge_mit_bestand_ame_kolli
 , SUM(v01.werbeaenderung_menge_vorlauf) AS werbeaenderung_menge_vorlauf
 , SUM(v01.projizierter_bestand_vor_werbung_bme) AS projizierter_bestand_vor_werbung_bme
 , AVG(COALESCE(v01.preis_normal_vorlauf,0)) AS preis_normal_vorlauf
 , AVG(COALESCE(v01.preis_aktion_vorlauf,0)) AS preis_aktion_vorlauf
 , SUM(v01.bestellung_lieferant_menge) AS bestellung_lieferant_menge
 , SUM(v01.menge_zuletzt_dc_promo) AS menge_zuletzt_dc_promo  
 , SUM(v02.werbeaenderung_menge_uebertragen) AS werbeaenderung_menge_uebertragen
 , AVG (v01.fixmenge_bme) fixmenge_bme
 , AVG (COALESCE(COALESCE(v02.fixmenge_wfl_bme,v01.fixmenge_wfl_bme),NULL))/ MAX(NULLIFZERO (v06.gp_count))
 
 , COALESCE(COALESCE(AVG(v02.menge_mindestplatzierung_cluster_1_ame),MAX(CASE WHEN v01.min_platzierung_markt_cluster_id=1 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE NULL END)),NULL) / MAX(CASE WHEN v01.min_platzierung_markt_cluster_id=1 THEN NULLIFZERO (v06.gp_count) ELSE NULL END) AS menge_mindestplatzierung_cluster_1_ame_
 , COALESCE(COALESCE(AVG(v02.menge_mindestplatzierung_cluster_2_ame),MAX(CASE WHEN v01.min_platzierung_markt_cluster_id=2 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE NULL END)),NULL) / MAX(CASE WHEN v01.min_platzierung_markt_cluster_id=2 THEN NULLIFZERO (v06.gp_count) ELSE NULL END)  AS menge_mindestplatzierung_cluster_2_ame_
 , COALESCE(COALESCE(AVG(v02.menge_mindestplatzierung_cluster_3_ame),MAX(CASE WHEN v01.min_platzierung_markt_cluster_id=3 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE NULL END)),NULL) / MAX(CASE WHEN v01.min_platzierung_markt_cluster_id=3 THEN NULLIFZERO (v06.gp_count) ELSE NULL END) AS menge_mindestplatzierung_cluster_3_ame_
 , COALESCE(v02.wfl_menge_geprueft_fg,COALESCE(v01.wfl_menge_geprueft_fg,0)) AS wfl_geprueft_fg
 , CASE WHEN (COALESCE(CASE WHEN v02.wfl_nutzer_kommentar_txt= '-' 
                           THEN '' 
                           ELSE v02.wfl_nutzer_kommentar_txt END,MAX(CASE WHEN v01.wfl_nutzer_kommentar_txt= '-' THEN NULL ELSE v01.wfl_nutzer_kommentar_txt END)))='' THEN NULL ELSE 
         COALESCE(CASE WHEN v02.wfl_nutzer_kommentar_txt= '-' THEN '' ELSE v02.wfl_nutzer_kommentar_txt END,MAX(CASE WHEN v01.wfl_nutzer_kommentar_txt= '-' THEN NULL ELSE v01.wfl_nutzer_kommentar_txt END)) END  wfl_nutzer_kommentar_txt_
,wbs_compound_fg	
,wbs_compound_fg_de										
,wbs_compound_fg_pl
,wbs_compound_fg_bg						   
,wbs_compound_fg_sk
,wbs_compound_fg_ro               
,wbs_compound_fg_cz
,wbs_compound_fg_hr
 ,DENSE_RANK() OVER (PARTITION BY  v01.art_id, v01.mandant_id_vz ORDER BY v01.dat_beladung DESC NULLS LAST) AS rank_aktion_beladung
 ,v01.ausliefergruppe_id
 ,COALESCE(v02.estimation_id,v01.estimation_id) AS estimation_id_
 ,v03.estimation_bez
 ,COALESCE(COALESCE(v02.adjustment_id,v01.adjustment_id),0) AS adjustment_id_
 ,v03a.adjustment_bez
 ,DATE(v02.td_update)
 ,MAX(v01.bonuskauf_promotionstyp_liste_txt) AS bonuskauf_promotionstyp
 ,MAX(v05a.wup_count_angebot) AS wup_count_angebot
 ,MAX(v05a.art_count_angebot) AS art_count_angebot 
 ,MAX(v01.multi_offer_id_fg) AS multi_offer_id_fg
,MAX(CASE WHEN v01.estimation_id<>v02.estimation_id AND DATE(v02.td_update) = CURRENT_DATE THEN 1 ELSE 0 END) estimation_change_fg
 ,MAX(CASE WHEN ZEROIFNULL(v01.adjustment_id)<>v02.adjustment_id AND DATE(v02.td_update) = CURRENT_DATE THEN 1 ELSE 0 END) adjustment_change_fg
 ,MAX(CASE WHEN v01.wfl_menge_geprueft_fg<>v02.wfl_menge_geprueft_fg AND DATE(v02.td_update) = CURRENT_DATE THEN 1 ELSE 0 END) wfl_menge_geprueft_fg_change_fg
 ,MAX(CASE WHEN COALESCE(v01.wfl_nutzer_kommentar_txt,'-')<>v02.wfl_nutzer_kommentar_txt AND DATE(v02.td_update) = CURRENT_DATE THEN 1 ELSE 0 END) wfl_nutzer_kommentar_txt_change_fg
 ,MAX(CASE WHEN v01.fixmenge_wfl_bme<>v02.fixmenge_wfl_bme AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) fixmenge_wfl_bme_change_fg
,MAX(CASE WHEN CASE WHEN v01.min_platzierung_markt_cluster_id=1 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE 0 END
<> COALESCE(v02.menge_mindestplatzierung_cluster_1_ame,0) AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) AS menge_mindestplatzierung_cluster_1_ame_change_fg
 ,MAX(CASE WHEN CASE WHEN v01.min_platzierung_markt_cluster_id=2 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE 0 END 
<> COALESCE(v02.menge_mindestplatzierung_cluster_2_ame,0) AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) AS menge_mindestplatzierung_cluster_2_ame_change_fg
 ,MAX(CASE WHEN CASE WHEN v01.min_platzierung_markt_cluster_id=3 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE 0 END 
<> COALESCE(v02.menge_mindestplatzierung_cluster_3_ame,0) AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) AS menge_mindestplatzierung_cluster_3_ame_change_fg
 
 ,MAX(CASE WHEN v02.menge_mit_bestand_genehmigt_fg = 1 AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) AS menge_mit_bestand_genehmigt_fg_change_fg
 ,MAX(CASE WHEN v02.menge_ohne_bestand_genehmigt_fg = 1 AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) AS menge_ohne_bestand_genehmigt_fg_change_fg
 , SUM(v01.bedarf_estimation_id_2_bme) AS bedarf_estimation_2_bme
 , SUM(v01.bestellmenge_estimation_id_2_ohne_bestand_ame) AS bestellmenge_estimation_2_ohne_bestand_ame
 , SUM(v01.bestellmenge_estimation_id_2_mit_bestand_ame) AS bestellmenge_estimation_2_mit_bestand_ame

FROM dbp_view.v_wbs_werbeaenderungen v01 
 
LEFT JOIN dbp_view.v_ts_mengenaenderungen_writeback v02
ON (v01.mandant_id = v02.mandant_id
	AND v01.aktion_id = v02.aktion_id
    AND v01.offer_id = v02.angebot_id
    AND v01.dat_ab = v02.dat_von
    AND v01.dat_bis = v02.dat_bis
    AND v01.art_id = v02.art_id
    AND v01.dat_beladung = v02.dat_beladung)
   

LEFT JOIN DBP_MSI_VIEW_SCM.MV_DT_WERBEAENDERUNG_ZUM_VORTAG v07
ON v01.mandant_id = v07.mandant_id 
           AND v01.dat_ab = v07.dat_ab
           AND v01.dat_bis = v07.dat_bis 
           AND v01.art_id = v07.art_id
           AND v01.offer_id = v07.offer_id
           AND v01.aktion_id = v07.aktion_id
           







       
LEFT JOIN DBP_MSI_VIEW_SCM.MV_DT_PMR_COUNTS v05a
ON v01.mandant_id = v05a.mandant_id 
           AND v01.dat_ab = v05a.dat_von
           AND v01.dat_bis = v05a.dat_bis 
           AND v01.art_id = v05a.art_id
           AND v01.wup_id = v05a.wup_id
           AND v01.nb_id = v05a.nb_id

LEFT JOIN DBP_MSI_VIEW_SCM.MV_DT_GP_COUNTS v06
ON v01.mandant_id = v06.mandant_id 
           AND v01.dat_ab = v06.dat_von
           AND v01.dat_bis = v06.dat_bis 
           AND v01.art_id = v06.art_id
           AND v01.min_platzierung_markt_cluster_id = v06.min_platzierung_markt_cluster_id
           
LEFT JOIN dbp_view.v_wbs_l_estimation v03
ON  estimation_id_ = v03.estimation_id
AND v01.mandant_id = v03.mandant_id							 

LEFT JOIN dbp_view.v_wbs_l_adjustment v03a
ON  adjustment_id_ = v03a.adjustment_id
AND v01.mandant_id = v03a.mandant_id	

JOIN dbp_view.v_werbewoche_kl v9 
ON v01.mandant_id = v9.mandant_id
AND v01.dat_ab = v9.dat


WHERE v01.dat_beladung = CURRENT_DATE AND werbeaenderung_artikelentfernung_fg = 0
																										  
GROUP BY v01.mandant_id
						   
    , v01.aktion_id
    , v01.offer_id
    , gp_id_
    , v01.dat_ab
    , v01.dat_bis
    , v01.art_id
    , v01.dat_beladung
    , v01.kjwo
	, (v01.dat_ab - v01.dat_beladung)
    , CAST(COALESCE(v02.menge_ohne_bestand_genehmigt_fg,0) AS BYTEINT) 
    , CAST(COALESCE(v02.menge_mit_bestand_genehmigt_fg,0) AS BYTEINT)
    , UTP_LIEFERANT_BESTAETIGT_FG
    , CASE WHEN v01.wup_id_vz = 6140 THEN 4 ELSE v01.mandant_id_vz END
    , v01.mandant_id_vz
    , wfl_geprueft_fg
    , v02.wfl_nutzer_kommentar_txt
    , v01.ausliefergruppe_id
    , estimation_id_
    , v03.estimation_bez
    , adjustment_id_
    , v03a.adjustment_bez
    , v9.kjwo_ww
    , v02.td_update
    ,wbs_compound_fg	
,wbs_compound_fg_de										
,wbs_compound_fg_pl
,wbs_compound_fg_bg						   
,wbs_compound_fg_sk
,wbs_compound_fg_ro               
,wbs_compound_fg_cz
,wbs_compound_fg_hr
    ;
