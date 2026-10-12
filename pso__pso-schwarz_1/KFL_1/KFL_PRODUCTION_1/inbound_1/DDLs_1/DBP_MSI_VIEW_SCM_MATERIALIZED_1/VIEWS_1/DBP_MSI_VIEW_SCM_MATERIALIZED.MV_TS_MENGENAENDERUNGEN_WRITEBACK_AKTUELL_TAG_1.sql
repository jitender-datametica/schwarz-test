create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_MENGENAENDERUNGEN_WRITEBACK_AKTUELL_TAG_1(
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





























































WITH  
pmr_counts AS (
    SELECT 
        v05bb.mandant_id,
        v05bb.dat_von,
        v05bb.dat_bis,
        v05bb.art_id,
        v05bb.wup_id,
        v05bb.nb_id,
        LISTAGG(distinct_wup_count, '|') WITHIN GROUP (ORDER BY distinct_wup_count) AS wup_count_angebot,
        LISTAGG(distinct_art_count, '|') WITHIN GROUP (ORDER BY distinct_art_count) AS art_count_angebot
    FROM (
        SELECT 
            v05b.mandant_id,
            v05b.dat_von,
            v05b.dat_bis,
            v05b.angebot_id,
            v05b.art_id,
            v05b.wup_id,
            v05b.nb_id,
            COUNT(DISTINCT v05b.wup_id) OVER (PARTITION BY v05b.art_id, v05b.mandant_id, v05b.dat_von, v05b.dat_bis, v05b.angebot_id) AS distinct_wup_count,
            COUNT(DISTINCT v05b.art_id) OVER (PARTITION BY v05b.mandant_id, v05b.dat_von, v05b.dat_bis, v05b.angebot_id) AS distinct_art_count
        FROM 
            dbp_view.v_pmr_angebot_art_wup_zu_1 v05b
        WHERE 
            v05b.dat_von >= CURRENT_DATE
        GROUP BY 
            v05b.mandant_id,  
            v05b.dat_von, 
            v05b.dat_bis,
            v05b.angebot_id,
            v05b.art_id,
            v05b.wup_id,
            v05b.nb_id
    ) v05bb
    GROUP BY 
        v05bb.mandant_id,
        v05bb.dat_von,
        v05bb.dat_bis,
        v05bb.art_id,
        v05bb.wup_id,
        v05bb.nb_id
),

GP_count AS (SELECT 
 v01.mandant_id
,v01.art_id
,v01.dat_ab AS dat_von
,v01.dat_bis
,v01.min_platzierung_markt_cluster_id
,v01.dat_beladung
,COUNT (DISTINCT v01.gp_id) AS gp_count
FROM dbp_view.v_wbs_werbeaenderungen_1 v01

WHERE  v01.dat_beladung = CURRENT_DATE 
GROUP BY 
 v01.mandant_id
,v01.art_id
,v01.dat_ab
,v01.dat_bis
,v01.dat_beladung
,v01.min_platzierung_markt_cluster_id)
    
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
 , COALESCE(v01.utp_lieferant_bestaetigt_fg,0)
 , CASE WHEN v01.wup_id_vz = 6140 THEN 4 ELSE v01.mandant_id_vz END AS mandant_id_vz
 , SUBSTR(TRIM(v01.kjwo),5,2) || '/' || SUBSTR(TRIM(v01.kjwo),1,4) || ' / ' || TO_CHAR(v01.dat_ab,'DD.MM.YYYY') || ' - ' || TO_CHAR(v01.dat_bis,'DD.MM.YYYY') AS aktionszeitraum
 , COUNT(DISTINCT CASE WHEN werbeaenderung_artikelentfernung_fg = 1 THEN NULL ELSE v01.wup_id END) AS count_maerkte 
 , COUNT(DISTINCT v01.wup_id) AS count_maerkte_vergleich  
 , SUM(count_maerkte_vergleich) OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.dat_ab, v01.dat_bis,v01.dat_beladung ) AS Anzahl_maerkte_agg 
 , SUM(SUM(CASE WHEN spr_id=22 THEN V01.werbeaenderung_artikelneuanlage_fg ELSE NULL END))  OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.dat_ab, v01.dat_bis,v01.dat_beladung ) AS anzahl_artikelneuanlage_agg 
 , SUM(SUM(CASE WHEN spr_id=22 THEN V01.werbeaenderung_artikelentfernung_fg ELSE NULL END))  OVER (PARTITION BY v01.mandant_id, v01.art_id, v01.dat_ab, v01.dat_bis,v01.dat_beladung ) AS anzahl_artikelentfernung_agg       
 , COALESCE(v02.gk_fg, v01.gk_fg) AS gk_fg_
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
 , SUM(CASE WHEN spr_id=22 THEN v01.prognose_werbezeitraum_bme ELSE NULL END) AS prognose_werbezeitraum_bme 
 , 0 AS bestellmenge_final_ame 
 , SUM(CASE WHEN spr_id=22 THEN v01.bestellmenge_ohne_bestand_ame ELSE NULL END) AS bestellmenge_ohne_bestand_ame
 , SUM(CASE WHEN spr_id=22 THEN v01.bestellmenge_mit_bestand_ame ELSE NULL END) AS bestellmenge_mit_bestand_ame 
 , SUM(CASE WHEN spr_id=22 THEN v01.bestellmenge_ohne_bestand_ame * v01.kollifaktor ELSE NULL END) AS bestellmenge_ohne_bestand_ame_kolli
 , SUM(CASE WHEN spr_id=22 THEN v01.bestellmenge_mit_bestand_ame * v01.kollifaktor ELSE NULL END) AS bestellmenge_mit_bestand_ame_kolli
 , SUM(CASE WHEN spr_id=22 THEN v01.werbeaenderung_menge_vorlauf ELSE NULL END) AS werbeaenderung_menge_vorlauf
 , SUM(CASE WHEN spr_id=22 THEN v01.projizierter_bestand_vor_werbung_bme ELSE NULL END) AS projizierter_bestand_vor_werbung_bme
 , AVG(COALESCE(v01.preis_normal_vorlauf,0)) AS preis_normal_vorlauf
 , AVG(COALESCE(v01.preis_aktion_vorlauf,0)) AS preis_aktion_vorlauf
 , SUM(CASE WHEN spr_id=22 THEN v01.bestellung_lieferant_menge ELSE NULL END) AS bestellung_lieferant_menge
 , SUM(CASE WHEN spr_id=22 THEN v01.menge_zuletzt_dc_promo ELSE NULL END) AS menge_zuletzt_dc_promo  
 , SUM(CASE WHEN spr_id=22 THEN v02.werbeaenderung_menge_uebertragen ELSE NULL END) AS werbeaenderung_menge_uebertragen
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
 ,CONCAT( MAX( CASE WHEN werbeaenderung_werbethema_fg<>0 THEN 
              CASE WHEN spr_id=22 THEN'| Werbethema' END ELSE '' END),
         MAX( CASE WHEN werbeaenderung_sonstiges_fg<>0 THEN                        
               CASE WHEN spr_id=22 THEN'| Sonstiges' END ELSE '' END),   
		 MAX( CASE WHEN werbeaenderung_radio_tv_billboard_fg<>0 THEN           
               CASE WHEN spr_id=22 THEN'| Radio TV Billboard' END ELSE '' END),	  
		 MAX( CASE WHEN werbeaenderung_normalpreisreduktion_fg<>0 THEN              
               CASE WHEN spr_id=22 THEN'| Normalpreisreduktion' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_normalpreiserhoehung_fg<>0 THEN              
               CASE WHEN spr_id=22 THEN'| Normalpreiserhöhung' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_marktanzahlreduktion_fg<>0 THEN              
               CASE WHEN spr_id=22 THEN'| Marktanzahlreduktion' END ELSE '' END),	   
		 MAX( CASE WHEN werbeaenderung_marktanzahlerhoehung_fg<>0 THEN              
               CASE WHEN spr_id=22 THEN'| Marktanzahlerhöhung' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_kolliinhaltsaenderung_fg<>0 THEN             
               CASE WHEN spr_id=22 THEN'| Kolliinhaltsänderung' END ELSE '' END), 
		 MIN( CASE WHEN werbeaenderung_artikelneuanlage_fg<>0 THEN                  
               CASE WHEN spr_id=22 THEN'| Artikelneuanlage' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=22 THEN'| Artikelentfernung' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreisreduktion_fg<>0 THEN             
               CASE WHEN spr_id=22 THEN'| Angebotspreisreduktion' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreiserhoehung_fg<>0 THEN             
               CASE WHEN spr_id=22 THEN'| Angebotspreiserhöhung' END ELSE '' END),	
		 MAX(  CASE WHEN werbeaenderung_abbildungsaenderung_fg<>0 THEN                
               CASE WHEN spr_id=22 THEN'| Abbildungsänderung' END ELSE '' END),		
		 MAX( CASE WHEN gesteuerte_prognose_fg<>0 THEN                              
               CASE WHEN spr_id=22 THEN'| Prognosesteuerung' END ELSE '' END),	
    	 MAX( CASE WHEN rabattaenderung_fg<>0 THEN                                   
               CASE WHEN spr_id=22 THEN'| Rabattänderung' END ELSE '' END),	
		 MAX(  CASE WHEN werbelistung_aenderung_fg<>0 THEN                            
               CASE WHEN spr_id=22 THEN'| Werbelistungsänderung' END ELSE '' END),	
		 MAX( CASE WHEN aktion_reihenfolge_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| Aktionsreihenfolgeänderung' END ELSE '' END),		
   		 MAX( CASE WHEN posten_kz_sap_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| Postenänderung' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| KDN/KDP Änderung' END ELSE '' END),
         MAX( CASE WHEN  werbeaenderung_bonuskauf_promotionstyp_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| AKART' END ELSE '' END)
			   ) AS wbs_compound_fg	
,CONCAT( MAX( CASE WHEN werbeaenderung_werbethema_fg<>0 THEN 
              CASE WHEN spr_id=22 THEN'| Werbethema' END ELSE '' END),
         MAX( CASE WHEN werbeaenderung_sonstiges_fg<>0 THEN                        
               CASE WHEN spr_id=22 THEN'| Sonstiges' END ELSE '' END),   
		 MAX( CASE WHEN werbeaenderung_radio_tv_billboard_fg<>0 THEN           
               CASE WHEN spr_id=22 THEN'| Radio TV Billboard' END ELSE '' END),	  
		 MAX( CASE WHEN werbeaenderung_normalpreisreduktion_fg<>0 THEN              
               CASE WHEN spr_id=22 THEN'| Normalpreisreduktion' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_normalpreiserhoehung_fg<>0 THEN              
               CASE WHEN spr_id=22 THEN'| Normalpreiserhöhung' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_marktanzahlreduktion_fg<>0 THEN              
               CASE WHEN spr_id=22 THEN'| Marktanzahlreduktion' END ELSE '' END),	   
		 MAX( CASE WHEN werbeaenderung_marktanzahlerhoehung_fg<>0 THEN              
               CASE WHEN spr_id=22 THEN'| Marktanzahlerhöhung' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_kolliinhaltsaenderung_fg<>0 THEN             
               CASE WHEN spr_id=22 THEN'| Kolliinhaltsänderung' END ELSE '' END), 
		 MIN( CASE WHEN werbeaenderung_artikelneuanlage_fg<>0 THEN                  
               CASE WHEN spr_id=22 THEN'| Artikelneuanlage' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=22 THEN'| Artikelentfernung' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreisreduktion_fg<>0 THEN             
               CASE WHEN spr_id=22 THEN'| Angebotspreisreduktion' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreiserhoehung_fg<>0 THEN             
               CASE WHEN spr_id=22 THEN'| Angebotspreiserhöhung' END ELSE '' END),	
		 MAX(  CASE WHEN werbeaenderung_abbildungsaenderung_fg<>0 THEN                
               CASE WHEN spr_id=22 THEN'| Abbildungsänderung' END ELSE '' END),		
		 MAX( CASE WHEN gesteuerte_prognose_fg<>0 THEN                              
               CASE WHEN spr_id=22 THEN'| Prognosesteuerung' END ELSE '' END),	
    	 MAX( CASE WHEN rabattaenderung_fg<>0 THEN                                   
               CASE WHEN spr_id=22 THEN'| Rabattänderung' END ELSE '' END),	
		 MAX(  CASE WHEN werbelistung_aenderung_fg<>0 THEN                            
               CASE WHEN spr_id=22 THEN'| Werbelistungsänderung' END ELSE '' END),	
		 MAX( CASE WHEN aktion_reihenfolge_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| Aktionsreihenfolgeänderung' END ELSE '' END),
		 MAX( CASE WHEN posten_kz_sap_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| Postenänderung' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| KDN/KDP Änderung' END ELSE '' END),
         MAX( CASE WHEN  werbeaenderung_bonuskauf_promotionstyp_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| AKART' END ELSE '' END)
			   ) AS wbs_compound_fg_de										
 ,CONCAT( MAX( CASE WHEN werbeaenderung_werbethema_fg<>0 THEN 
              CASE WHEN spr_id=90 THEN'| Temat promocji' END ELSE '' END),
         MAX( CASE WHEN werbeaenderung_sonstiges_fg<>0 THEN                        
               CASE WHEN spr_id=90 THEN'| Inne' END ELSE '' END),   
		 MAX( CASE WHEN werbeaenderung_radio_tv_billboard_fg<>0 THEN           
               CASE WHEN spr_id=90 THEN'| Radio TV billboard' END ELSE '' END),	  
		 MAX( CASE WHEN werbeaenderung_normalpreisreduktion_fg<>0 THEN              
               CASE WHEN spr_id=90 THEN'| Obniżka ceny standardowej' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_normalpreiserhoehung_fg<>0 THEN              
               CASE WHEN spr_id=90 THEN'| Wzrost ceny standardowej' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_marktanzahlreduktion_fg<>0 THEN              
               CASE WHEN spr_id=90 THEN'| Redukcja liczby sklepów' END ELSE '' END),	   
		 MAX( CASE WHEN werbeaenderung_marktanzahlerhoehung_fg<>0 THEN              
               CASE WHEN spr_id=90 THEN'| Wzrost liczby sklepów' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_kolliinhaltsaenderung_fg<>0 THEN             
               CASE WHEN spr_id=90 THEN'| Koli zmiana' END ELSE '' END), 
		 MIN( CASE WHEN werbeaenderung_artikelneuanlage_fg<>0 THEN                  
               CASE WHEN spr_id=90 THEN'| Artykuł in' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=90 THEN'| Artykuł out' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreisreduktion_fg<>0 THEN             
               CASE WHEN spr_id=90 THEN'| Obniżka ceny promocyjnej' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreiserhoehung_fg<>0 THEN             
               CASE WHEN spr_id=90 THEN'| Wzrost ceny promocyjnej' END ELSE '' END),	
		 MAX(  CASE WHEN werbeaenderung_abbildungsaenderung_fg<>0 THEN                
               CASE WHEN spr_id=90 THEN'| Pano zmiana' END ELSE '' END),	
		 MAX( CASE WHEN gesteuerte_prognose_fg<>0 THEN                              
               CASE WHEN spr_id=90 THEN'| Kontrola prognozy' END ELSE '' END),	
    	 MAX( CASE WHEN rabattaenderung_fg<>0 THEN                                   
               CASE WHEN spr_id=90 THEN'| Zmiana rabatu' END ELSE '' END),	
		 MAX(  CASE WHEN werbelistung_aenderung_fg<>0 THEN                            
               CASE WHEN spr_id=90 THEN'| Zmiana zalistowania promo' END ELSE '' END),	
		 MAX( CASE WHEN aktion_reihenfolge_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=90 THEN'| Zmiana rangi promo' END ELSE '' END),
	     MAX( CASE WHEN posten_kz_sap_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=90 THEN'| Zmiana Posten' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=90 THEN'| Zmiana KDN/KDP' END ELSE '' END),
         MAX( CASE WHEN  werbeaenderung_bonuskauf_promotionstyp_fg<>0 THEN                      
               CASE WHEN spr_id=90 THEN'| AKART' END ELSE '' END)
			   ) AS wbs_compound_fg_pl
 ,CONCAT( MAX( CASE WHEN werbeaenderung_werbethema_fg<>0 THEN 
              CASE WHEN spr_id=18 THEN'| Промо тема' END ELSE '' END),
         MAX( CASE WHEN werbeaenderung_sonstiges_fg<>0 THEN                        
               CASE WHEN spr_id=18 THEN'| Други' END ELSE '' END),   
		 MAX( CASE WHEN werbeaenderung_radio_tv_billboard_fg<>0 THEN           
               CASE WHEN spr_id=18 THEN'| Radio TV билборд' END ELSE '' END),	  
		 MAX( CASE WHEN werbeaenderung_normalpreisreduktion_fg<>0 THEN              
               CASE WHEN spr_id=18 THEN'| Намаление на стандартна цена' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_normalpreiserhoehung_fg<>0 THEN              
               CASE WHEN spr_id=18 THEN'| Увеличение на стандартна цена'  END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_marktanzahlreduktion_fg<>0 THEN              
               CASE WHEN spr_id=18 THEN'| Намаляване броя на магазините' END ELSE '' END),	   
		 MAX( CASE WHEN werbeaenderung_marktanzahlerhoehung_fg<>0 THEN              
               CASE WHEN spr_id=18 THEN'| Увеличаване броя на магазините' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_kolliinhaltsaenderung_fg<>0 THEN             
               CASE WHEN spr_id=18 THEN'| Промяна на Колифактор' END ELSE '' END), 
		 MIN( CASE WHEN werbeaenderung_artikelneuanlage_fg<>0 THEN                  
               CASE WHEN spr_id=18 THEN'| Артикул добавен' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=18 THEN'| Артикул OUT' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreisreduktion_fg<>0 THEN             
               CASE WHEN spr_id=18 THEN'| Намаление на акционна цена' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreiserhoehung_fg<>0 THEN             
               CASE WHEN spr_id=18 THEN'| Увеличение на акционна цена' END ELSE '' END),	
		 MAX(  CASE WHEN werbeaenderung_abbildungsaenderung_fg<>0 THEN                
               CASE WHEN spr_id=18 THEN'| Промяна на пано' END ELSE '' END),	
		 MAX( CASE WHEN gesteuerte_prognose_fg<>0 THEN                              
               CASE WHEN spr_id=18 THEN'| Контрол на прогнозата' END ELSE '' END),	
    	 MAX( CASE WHEN rabattaenderung_fg<>0 THEN                                   
               CASE WHEN spr_id=18 THEN'| Промяна на отстъпката' END ELSE '' END),	
		 MAX(  CASE WHEN werbelistung_aenderung_fg<>0 THEN                            
               CASE WHEN spr_id=18 THEN'| Промяна в промо листинга' END ELSE '' END),	
		 MAX( CASE WHEN aktion_reihenfolge_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=18 THEN'| Промяна в промоционалния ранк' END ELSE '' END),
		 MAX( CASE WHEN posten_kz_sap_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=18 THEN'| Posten промяна' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=18 THEN'| KDN/KDP промяна' END ELSE '' END),
         MAX( CASE WHEN  werbeaenderung_bonuskauf_promotionstyp_fg<>0 THEN                      
               CASE WHEN spr_id=18 THEN'| AKART' END ELSE '' END)
			   ) AS wbs_compound_fg_bg						   
,CONCAT( MAX( CASE WHEN werbeaenderung_werbethema_fg<>0 THEN 
              CASE WHEN spr_id=108 THEN'| Téma akcie' END ELSE '' END),
         MAX( CASE WHEN werbeaenderung_sonstiges_fg<>0 THEN                        
               CASE WHEN spr_id=108 THEN'| Iné' END ELSE '' END),   
		 MAX( CASE WHEN werbeaenderung_radio_tv_billboard_fg<>0 THEN           
               CASE WHEN spr_id=108 THEN'| Rádio TV Billboard' END ELSE '' END),	  
		 MAX( CASE WHEN werbeaenderung_normalpreisreduktion_fg<>0 THEN              
               CASE WHEN spr_id=108 THEN'| Zníženie PC' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_normalpreiserhoehung_fg<>0 THEN              
               CASE WHEN spr_id=108 THEN'| Zvýšenie PC' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_marktanzahlreduktion_fg<>0 THEN              
               CASE WHEN spr_id=108 THEN'| Zníženie počtu filiálok' END ELSE '' END),	   
		 MAX( CASE WHEN werbeaenderung_marktanzahlerhoehung_fg<>0 THEN              
               CASE WHEN spr_id=108 THEN'| Zvýšenie počtu filiálok' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_kolliinhaltsaenderung_fg<>0 THEN             
               CASE WHEN spr_id=108 THEN'| Zmena Kolli' END ELSE '' END), 
		 MIN( CASE WHEN werbeaenderung_artikelneuanlage_fg<>0 THEN                  
               CASE WHEN spr_id=108 THEN'| Artikel_1 IN' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=108 THEN'| Artikel_1 OUT' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreisreduktion_fg<>0 THEN             
               CASE WHEN spr_id=108 THEN'| Zníženie APC' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreiserhoehung_fg<>0 THEN             
               CASE WHEN spr_id=108 THEN'| Zvýšenie APC' END ELSE '' END),	
		 MAX(  CASE WHEN werbeaenderung_abbildungsaenderung_fg<>0 THEN                
               CASE WHEN spr_id=108 THEN'| Zmena pano' END ELSE '' END),		
		 MAX( CASE WHEN gesteuerte_prognose_fg<>0 THEN                              
               CASE WHEN spr_id=108 THEN'| Kontrola FC' END ELSE '' END),	
    	 MAX( CASE WHEN rabattaenderung_fg<>0 THEN                                   
               CASE WHEN spr_id=108 THEN'| Zmena zľavy' END ELSE '' END),	
		 MAX(  CASE WHEN werbelistung_aenderung_fg<>0 THEN                            
               CASE WHEN spr_id=108 THEN'| Zmena listovania  do akcie' END ELSE '' END),	
		 MAX( CASE WHEN aktion_reihenfolge_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=108 THEN'| Zmena obdobia akcie' END ELSE '' END),
	     MAX( CASE WHEN posten_kz_sap_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=108 THEN'| Posten zmena' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=108 THEN'| KDN/KDP zmena' END ELSE '' END),
         MAX( CASE WHEN  werbeaenderung_bonuskauf_promotionstyp_fg<>0 THEN                      
               CASE WHEN spr_id=108 THEN'| AKART' END ELSE '' END)
			   ) AS wbs_compound_fg_sk
,CONCAT( MAX( CASE WHEN werbeaenderung_werbethema_fg<>0 THEN 
              CASE WHEN spr_id=95 THEN'| Tema promotie' END ELSE '' END),
         MAX( CASE WHEN werbeaenderung_sonstiges_fg<>0 THEN                        
               CASE WHEN spr_id=95 THEN'| Altele' END ELSE '' END),   
		 MAX( CASE WHEN werbeaenderung_radio_tv_billboard_fg<>0 THEN           
               CASE WHEN spr_id=95 THEN'| Panou publicitar Radio TV' END ELSE '' END),	  
		 MAX( CASE WHEN werbeaenderung_normalpreisreduktion_fg<>0 THEN              
               CASE WHEN spr_id=95 THEN'| Reducere normala de pret' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_normalpreiserhoehung_fg<>0 THEN              
               CASE WHEN spr_id=95 THEN'| Crestere normala de pret' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_marktanzahlreduktion_fg<>0 THEN              
               CASE WHEN spr_id=95 THEN'| Reducerea numarului de filiale' END ELSE '' END),	   
		 MAX( CASE WHEN werbeaenderung_marktanzahlerhoehung_fg<>0 THEN              
               CASE WHEN spr_id=95 THEN'| Cresterea numarului de filiale' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_kolliinhaltsaenderung_fg<>0 THEN             
               CASE WHEN spr_id=95 THEN'| Modificare Kolli' END ELSE '' END), 
		 MIN( CASE WHEN werbeaenderung_artikelneuanlage_fg<>0 THEN                  
               CASE WHEN spr_id=95 THEN'| Articol IN' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=95 THEN'| Articol OUT' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreisreduktion_fg<>0 THEN             
               CASE WHEN spr_id=95 THEN'| Reducerea pretului de promo' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreiserhoehung_fg<>0 THEN             
               CASE WHEN spr_id=95 THEN'| Cresterea pretrului de promo' END ELSE '' END),	
		 MAX(  CASE WHEN werbeaenderung_abbildungsaenderung_fg<>0 THEN                
               CASE WHEN spr_id=95 THEN'| Pano schimbare' END ELSE '' END),		
		 MAX( CASE WHEN gesteuerte_prognose_fg<>0 THEN                              
               CASE WHEN spr_id=95 THEN'| Forecast control' END ELSE '' END),	
    	 MAX( CASE WHEN rabattaenderung_fg<>0 THEN                                   
               CASE WHEN spr_id=95 THEN'| Modificare discount' END ELSE '' END),	
		 MAX(  CASE WHEN werbelistung_aenderung_fg<>0 THEN                            
               CASE WHEN spr_id=95 THEN'| Modificare listare promo' END ELSE '' END),	
		 MAX( CASE WHEN aktion_reihenfolge_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=95 THEN'| Modificare rang promo' END ELSE '' END),
		 MAX( CASE WHEN posten_kz_sap_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=95 THEN'| Modificare Posten' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=95 THEN'| Modificare KDN/KDP' END ELSE '' END),
         MAX( CASE WHEN  werbeaenderung_bonuskauf_promotionstyp_fg<>0 THEN                      
               CASE WHEN spr_id=95 THEN'| AKART' END ELSE '' END)
			   ) AS wbs_compound_fg_ro               
,CONCAT( MAX( CASE WHEN werbeaenderung_werbethema_fg<>0 THEN 
              CASE WHEN spr_id=124 THEN'| Téma akce' END ELSE '' END),
         MAX( CASE WHEN werbeaenderung_sonstiges_fg<>0 THEN                        
               CASE WHEN spr_id=124 THEN'| Jiné' END ELSE '' END),   
		 MAX( CASE WHEN werbeaenderung_radio_tv_billboard_fg<>0 THEN           
               CASE WHEN spr_id=124 THEN'| Rádio TV billboard' END ELSE '' END),	  
		 MAX( CASE WHEN werbeaenderung_normalpreisreduktion_fg<>0 THEN              
               CASE WHEN spr_id=124 THEN'| Snížení normální ceny' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_normalpreiserhoehung_fg<>0 THEN              
               CASE WHEN spr_id=124 THEN'| Zvýšení normální ceny' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_marktanzahlreduktion_fg<>0 THEN              
               CASE WHEN spr_id=124 THEN'| Snížení počtu filiálek' END ELSE '' END),	   
		 MAX( CASE WHEN werbeaenderung_marktanzahlerhoehung_fg<>0 THEN              
               CASE WHEN spr_id=124 THEN'| Zvýšení počtu filiálek' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_kolliinhaltsaenderung_fg<>0 THEN             
               CASE WHEN spr_id=124 THEN'| Změna kolli' END ELSE '' END), 
		 MIN( CASE WHEN werbeaenderung_artikelneuanlage_fg<>0 THEN                  
               CASE WHEN spr_id=124 THEN'| Zadání nového artiklu' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=124 THEN'|Odebrání artiklu' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreisreduktion_fg<>0 THEN             
               CASE WHEN spr_id=124 THEN'| Snížení akční ceny de promo' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreiserhoehung_fg<>0 THEN             
               CASE WHEN spr_id=124 THEN'| Zvýšení akční ceny' END ELSE '' END),	
		 MAX(  CASE WHEN werbeaenderung_abbildungsaenderung_fg<>0 THEN                
               CASE WHEN spr_id=124 THEN'| Ilustrační změna' END ELSE '' END),		
		 MAX( CASE WHEN gesteuerte_prognose_fg<>0 THEN                              
               CASE WHEN spr_id=124 THEN'| Kontrola prognózy' END ELSE '' END),	
    	 MAX( CASE WHEN rabattaenderung_fg<>0 THEN                                   
               CASE WHEN spr_id=124 THEN'| Změna slevy' END ELSE '' END),	
		 MAX(  CASE WHEN werbelistung_aenderung_fg<>0 THEN                            
               CASE WHEN spr_id=124 THEN'| Změna listování do akce' END ELSE '' END),	
		 MAX( CASE WHEN aktion_reihenfolge_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=124 THEN'| Změna pořadí akce' END ELSE '' END),
		 MAX( CASE WHEN posten_kz_sap_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=124 THEN'| Posten Change' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=124 THEN'| KDN/KDP Change' END ELSE '' END),
         MAX( CASE WHEN  werbeaenderung_bonuskauf_promotionstyp_fg<>0 THEN                      
               CASE WHEN spr_id=124 THEN'| AKART' END ELSE '' END)
			   ) AS wbs_compound_fg_cz
,CONCAT( MAX( CASE WHEN werbeaenderung_werbethema_fg<>0 THEN 
              CASE WHEN spr_id=65 THEN'| tema akcije' END ELSE '' END),
         MAX( CASE WHEN werbeaenderung_sonstiges_fg<>0 THEN                        
               CASE WHEN spr_id=65 THEN'| ostalo' END ELSE '' END),   
		 MAX( CASE WHEN werbeaenderung_radio_tv_billboard_fg<>0 THEN           
               CASE WHEN spr_id=65 THEN'| Radio, TV, ostala oglašavanja' END ELSE '' END),	  
		 MAX( CASE WHEN werbeaenderung_normalpreisreduktion_fg<>0 THEN              
               CASE WHEN spr_id=65 THEN'| sniženje normalne MPC' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_normalpreiserhoehung_fg<>0 THEN              
               CASE WHEN spr_id=65 THEN'| povećanje normalne MPC' END ELSE '' END),
		 MAX( CASE WHEN werbeaenderung_marktanzahlreduktion_fg<>0 THEN              
               CASE WHEN spr_id=65 THEN'| smanjenje broja poslovnica' END ELSE '' END),	   
		 MAX( CASE WHEN werbeaenderung_marktanzahlerhoehung_fg<>0 THEN              
               CASE WHEN spr_id=65 THEN'| povećanje broja poslovnica' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_kolliinhaltsaenderung_fg<>0 THEN             
               CASE WHEN spr_id=65 THEN'| promjena pakiranja kolija' END ELSE '' END), 
		 MIN( CASE WHEN werbeaenderung_artikelneuanlage_fg<>0 THEN                  
               CASE WHEN spr_id=65 THEN'| artikl ulazi' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=65 THEN'| artikl izlazi' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreisreduktion_fg<>0 THEN             
               CASE WHEN spr_id=65 THEN'| sniženje akcijske MPC' END ELSE '' END),	
		 MAX( CASE WHEN werbeaenderung_angebotspreiserhoehung_fg<>0 THEN             
               CASE WHEN spr_id=65 THEN'| povećanje akcijske MPC' END ELSE '' END),	
		 MAX(  CASE WHEN werbeaenderung_abbildungsaenderung_fg<>0 THEN                
               CASE WHEN spr_id=65 THEN'| promjena pozicije u akciji' END ELSE '' END),	
		 MAX( CASE WHEN gesteuerte_prognose_fg<>0 THEN                              
               CASE WHEN spr_id=65 THEN'| kontrola prognoze' END ELSE '' END),	
    	 MAX( CASE WHEN rabattaenderung_fg<>0 THEN                                   
               CASE WHEN spr_id=65 THEN'| promjena % sniženja cijene' END ELSE '' END),	
		 MAX(  CASE WHEN werbelistung_aenderung_fg<>0 THEN                            
               CASE WHEN spr_id=65 THEN'| promjena broja poslovnica u akciji' END ELSE '' END),	
		 MAX( CASE WHEN aktion_reihenfolge_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=65 THEN'| promjena redoslijeda akcije u nizu' END ELSE '' END),
		 MAX( CASE WHEN posten_kz_sap_aenderung_fg<>0 THEN                      
               CASE WHEN spr_id=65 THEN'| Posten promjena' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=65 THEN'| KDN/KDP promjena' END ELSE '' END),
         MAX( CASE WHEN  werbeaenderung_bonuskauf_promotionstyp_fg<>0 THEN                      
               CASE WHEN spr_id=65 THEN'| AKART' END ELSE '' END)
			   ) AS wbs_compound_fg_hr
 ,DENSE_RANK() OVER (PARTITION BY  v01.art_id, v01.mandant_id_vz ORDER BY v01.dat_beladung DESC NULLS LAST) AS rank_aktion_beladung
 ,v01.ausliefergruppe_id
 ,COALESCE(v02.estimation_id,v01.estimation_id) AS estimation_id_
 ,v03.estimation_bez
 ,COALESCE(COALESCE(v02.adjustment_id, v01.adjustment_id),0) AS adjustment_id_
 ,v03a.adjustment_bez
 ,DATE(v02.td_update)
 
 ,MAX(v01.bonuskauf_promotionstyp_liste_txt) AS bonuskauf_promotionstyp
 ,MAX(v05a.wup_count_angebot) AS wup_count_angebot
 ,MAX(v05a.art_count_angebot) AS art_count_angebot 
 ,MAX(v01.multi_offer_id_fg) AS multi_offer_id_fg
 ,CASE WHEN v01.estimation_id<>v02.estimation_id AND DATE(v02.td_update) = CURRENT_DATE THEN 1 ELSE 0 END estimation_change_fg
 ,CASE WHEN ZEROIFNULL(v01.adjustment_id)<>v02.adjustment_id AND DATE(v02.td_update) = CURRENT_DATE THEN 1 ELSE 0 END adjustment_change_fg
 ,CASE WHEN v01.wfl_menge_geprueft_fg<>v02.wfl_menge_geprueft_fg AND DATE(v02.td_update) = CURRENT_DATE THEN 1 ELSE 0 END wfl_menge_geprueft_fg_change_fg
 ,CASE WHEN COALESCE(v01.wfl_nutzer_kommentar_txt,'-')<>v02.wfl_nutzer_kommentar_txt AND DATE(v02.td_update) = CURRENT_DATE THEN 1 ELSE 0 END wfl_nutzer_kommentar_txt_change_fg
 ,CASE WHEN v01.fixmenge_wfl_bme<>v02.fixmenge_wfl_bme AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END fixmenge_wfl_bme_change_fg
,MAX(CASE WHEN CASE WHEN v01.min_platzierung_markt_cluster_id=1 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE 0 END
<> COALESCE(v02.menge_mindestplatzierung_cluster_1_ame,0) AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) AS menge_mindestplatzierung_cluster_1_ame_change_fg
 ,MAX(CASE WHEN CASE WHEN v01.min_platzierung_markt_cluster_id=2 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE 0 END 
<> COALESCE(v02.menge_mindestplatzierung_cluster_2_ame,0) AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) AS menge_mindestplatzierung_cluster_2_ame_change_fg
 ,MAX(CASE WHEN CASE WHEN v01.min_platzierung_markt_cluster_id=3 THEN v01.menge_mindestplatzierung_bme/v01.kollifaktor ELSE 0 END 
<> COALESCE(v02.menge_mindestplatzierung_cluster_3_ame,0) AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END) AS menge_mindestplatzierung_cluster_3_ame_change_fg
 
 ,CASE WHEN v02.menge_mit_bestand_genehmigt_fg = 1 AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END AS menge_mit_bestand_genehmigt_fg_change_fg
 ,CASE WHEN v02.menge_ohne_bestand_genehmigt_fg = 1 AND DATE(v02.td_update)=CURRENT_DATE THEN 1 ELSE 0 END AS menge_ohne_bestand_genehmigt_fg_change_fg
 , SUM(CASE WHEN spr_id=22 THEN v01.bedarf_estimation_id_2_bme ELSE NULL END) AS bedarf_estimation_2_bme
 , SUM(CASE WHEN spr_id=22 THEN v01.bestellmenge_estimation_id_2_ohne_bestand_ame ELSE NULL END) AS bestellmenge_estimation_2_ohne_bestand_ame
 , SUM(CASE WHEN spr_id=22 THEN v01.bestellmenge_estimation_id_2_mit_bestand_ame ELSE NULL END) AS bestellmenge_estimation_2_mit_bestand_ame

FROM dbp_view.v_wbs_werbeaenderungen_1 v01
 
LEFT JOIN dbp_view.v_ts_mengenaenderungen_writeback_1 v02
ON (v01.mandant_id = v02.mandant_id
	AND v01.aktion_id = v02.aktion_id
    AND v01.offer_id = v02.angebot_id
    AND v01.dat_ab = v02.dat_von
    AND v01.dat_bis = v02.dat_bis
    AND v01.art_id = v02.art_id
    AND v01.dat_beladung = v02.dat_beladung)
         
LEFT JOIN pmr_counts v05a
ON v01.mandant_id = v05a.mandant_id 
           AND v01.dat_ab = v05a.dat_von
           AND v01.dat_bis = v05a.dat_bis 
           AND v01.art_id = v05a.art_id
           AND v01.wup_id = v05a.wup_id
           AND v01.nb_id = v05a.nb_id

LEFT JOIN GP_count v06
ON v01.mandant_id = v06.mandant_id 
           AND v01.dat_ab = v06.dat_von
           AND v01.dat_bis = v06.dat_bis 
           AND v01.art_id = v06.art_id
           AND v01.min_platzierung_markt_cluster_id = v06.min_platzierung_markt_cluster_id
           
LEFT JOIN dbp_view.v_wbs_l_estimation_1 v03
ON  estimation_id_ = v03.estimation_id
AND v01.mandant_id = v03.mandant_id							 

LEFT JOIN dbp_view.v_wbs_l_adjustment_1 v03a
ON  adjustment_id_ = v03a.adjustment_id
AND v01.mandant_id = v03a.mandant_id	

LEFT JOIN dbp_view.v_werbewoche_kl_1 v9
ON v01.mandant_id = v9.mandant_id
AND v01.dat_ab = v9.dat

JOIN  dbp_view.v_spr_1 spr_1
ON spr_id IN (22, 124, 108, 65, 90,95,18)

WHERE v01.dat_beladung = CURRENT_DATE AND v01.dat_ab>=CURRENT_DATE AND werbeaenderung_artikelentfernung_fg = 0 
																										  
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
    , COALESCE(v01.utp_lieferant_bestaetigt_fg,0)
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
    , estimation_change_fg
    , adjustment_change_fg
    , wfl_menge_geprueft_fg_change_fg
    , wfl_nutzer_kommentar_txt_change_fg
    , fixmenge_wfl_bme_change_fg											   
    , menge_mit_bestand_genehmigt_fg_change_fg
    , menge_ohne_bestand_genehmigt_fg_change_fg
    ,gk_fg_;