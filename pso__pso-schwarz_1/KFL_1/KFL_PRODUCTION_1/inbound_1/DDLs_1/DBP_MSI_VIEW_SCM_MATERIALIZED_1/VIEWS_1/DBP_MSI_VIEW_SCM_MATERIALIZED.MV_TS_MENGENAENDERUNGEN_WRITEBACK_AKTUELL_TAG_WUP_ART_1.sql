create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_MENGENAENDERUNGEN_WRITEBACK_AKTUELL_TAG_WUP_ART_1(
	MANDANT_ID,
	WUP_ID,
	WUP_ID_VZ,
	NB_ID,
	NB_ID_VZ,
	AKTION_ID,
	OFFER_ID,
	DAT_AB,
	DAT_BIS,
	ART_ID,
	GP_ID,
	DAT_BELADUNG,
	KJWO,
	KJWO_WW,
	MANDANT_ID_VZ,
	MENGE_OHNE_BESTAND_GENEHMIGT_FG,
	MENGE_MIT_BESTAND_GENEHMIGT_FG,
	GK_FG,
	TITEL_FG,
	RUECKSEITE_FG,
	FIXMENGE_FG,
	TV_FG,
	STILLE_AKTION_FG,
	MAX_BEST_GENERIERT_FG,
	AKTION_REIHENFOLGE_ZUKUNFT_NR,
	NUR_ONLINE_FG,
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
	AUSLIEFERGRUPPE_ID,
	ESTIMATION_ID,
	ESTIMATION_BEZ,
	ADJUSTMENT_ID,
	ADJUSTMENT_BEZ,
	BONUSKAUF_PROMOTIONSTYP,
	MULTI_OFFER_ID_FG
) as

 



SELECT 
   v01.mandant_id
 , v01.wup_id
 , v01.wup_id_vz
 , v01.nb_id
 , v01.nb_id_vz
 , v01.aktion_id
 , v01.offer_id
 , v01.dat_ab
 , v01.dat_bis
 , v01.art_id
 , COALESCE((CASE WHEN v01.gp_id=0 THEN -1 ELSE v01.gp_id END),-1) AS gp_id_
 , v01.dat_beladung
 , v01.kjwo
 , v9.kjwo_ww
 , CASE WHEN v01.wup_id_vz = 6140 THEN 4 ELSE v01.mandant_id_vz END AS mandant_id_vz
 , CAST(COALESCE(v02.menge_ohne_bestand_genehmigt_fg,0) AS BYTEINT) AS menge_ohne_bestand_genehmigt_fg
 , CAST(COALESCE(v02.menge_mit_bestand_genehmigt_fg,0) AS BYTEINT) AS menge_mit_bestand_genehmigt_fg
 , v01.gk_fg
 , v01.titel_fg
 , v01.rueckseite_fg
 , v01.fixmenge_fg
 , v01.tv_fg
 , v01.stille_aktion_fg
 , v01.best_generiert_fg AS max_best_generiert_fg
 , v01.aktion_reihenfolge_zukunft_nr
 , v01.nur_online_fg
 , COALESCE(v02.wfl_menge_geprueft_fg,COALESCE(v01.wfl_menge_geprueft_fg,0)) AS wfl_geprueft_fg
,  CASE WHEN (COALESCE(CASE WHEN v02.wfl_nutzer_kommentar_txt= '-' 
                           THEN '' 
                           ELSE v02.wfl_nutzer_kommentar_txt END,(CASE WHEN v01.wfl_nutzer_kommentar_txt= '-' THEN NULL ELSE v01.wfl_nutzer_kommentar_txt END)))='' THEN NULL ELSE 
         COALESCE(CASE WHEN v02.wfl_nutzer_kommentar_txt= '-' THEN '' ELSE v02.wfl_nutzer_kommentar_txt END,(CASE WHEN v01.wfl_nutzer_kommentar_txt= '-' THEN NULL ELSE v01.wfl_nutzer_kommentar_txt END)) END  wfl_nutzer_kommentar_txt_
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
 ,v01.ausliefergruppe_id
 ,COALESCE(v02.estimation_id,v01.estimation_id) AS estimation_id_
 ,v03.estimation_bez
 ,COALESCE(COALESCE(v02.adjustment_id,v01.adjustment_id),0) AS adjustment_id_
 ,v03a.adjustment_bez

 
 ,(v01.bonuskauf_promotionstyp_liste_txt) AS bonuskauf_promotionstyp

 ,(v01.multi_offer_id_fg) AS multi_offer_id_fg
 
FROM dbp_view.v_wbs_werbeaenderungen_1 v01
 
LEFT JOIN dbp_view.v_ts_mengenaenderungen_writeback_1 v02
ON (v01.mandant_id = v02.mandant_id
	AND v01.aktion_id = v02.aktion_id
    AND v01.offer_id = v02.angebot_id
    AND v01.dat_ab = v02.dat_von
    AND v01.dat_bis = v02.dat_bis
    AND v01.art_id = v02.art_id
    AND v01.dat_beladung = v02.dat_beladung)
 







        
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


WHERE v01.dat_beladung = CURRENT_DATE AND v01.dat_ab>=CURRENT_DATE


GROUP BY 
    v01.mandant_id,
    v01.wup_id,
    v01.wup_id_vz,
    v01.nb_id,
    v01.nb_id_vz,
    v01.aktion_id,
    v01.offer_id,
    v01.dat_ab,
    v01.dat_bis,
    v01.art_id,
    CASE WHEN v01.gp_id = 0 THEN -1 ELSE v01.gp_id END,
    v01.dat_beladung,
    v01.kjwo,
    v9.kjwo_ww,
    CASE WHEN v01.wup_id_vz = 6140 THEN 4 ELSE v01.mandant_id_vz END,
    COALESCE(v02.menge_ohne_bestand_genehmigt_fg, 0),
    COALESCE(v02.menge_mit_bestand_genehmigt_fg, 0),
    v01.gk_fg,
    v01.titel_fg,
    v01.rueckseite_fg,
    v01.fixmenge_fg,
    v01.tv_fg,
    v01.stille_aktion_fg,
    v01.best_generiert_fg,
    v01.aktion_reihenfolge_zukunft_nr,
    v01.nur_online_fg,
    COALESCE(v02.wfl_menge_geprueft_fg, COALESCE(v01.wfl_menge_geprueft_fg, 0)),
    wfl_nutzer_kommentar_txt_,
    v01.ausliefergruppe_id,
    COALESCE(v02.estimation_id, v01.estimation_id),
    v03.estimation_bez,
    COALESCE(COALESCE(v02.adjustment_id, v01.adjustment_id), 0),
    v03a.adjustment_bez,
    v01.multi_offer_id_fg,
   
    v01.bonuskauf_promotionstyp_liste_txt;