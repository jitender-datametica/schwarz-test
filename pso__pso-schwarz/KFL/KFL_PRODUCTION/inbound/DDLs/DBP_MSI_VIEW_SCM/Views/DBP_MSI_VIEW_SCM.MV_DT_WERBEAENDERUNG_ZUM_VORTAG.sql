CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_WERBEAENDERUNG_ZUM_VORTAG(
	MANDANT_ID,
	AKTION_ID,
	OFFER_ID,
	DAT_AB,
	DAT_BIS,
	ART_ID,
	DAT_BELADUNG,
	WBS_COMPOUND_FG,
	WBS_COMPOUND_FG_DE,
	WBS_COMPOUND_FG_PL,
	WBS_COMPOUND_FG_BG,
	WBS_COMPOUND_FG_SK,
	WBS_COMPOUND_FG_RO,
	WBS_COMPOUND_FG_CZ,
	WBS_COMPOUND_FG_HR
) TARGET_LAG = '60 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
 AS
 SELECT 
 v01.mandant_id
, v01.aktion_id
, v01.offer_id
, v01.dat_ab
, v01.dat_bis
, v01.art_id
, v01.dat_beladung
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
               CASE WHEN spr_id=22 THEN'| KDN/KDP Änderung' END ELSE '' END)
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
               CASE WHEN spr_id=22 THEN'| KDN/KDP Änderung' END ELSE '' END)
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
               CASE WHEN spr_id=22 THEN'| Zmiana Posten' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| Zmiana KDN/KDP' END ELSE '' END)
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
               CASE WHEN spr_id=22 THEN'| Posten промяна' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| KDN/KDP промяна' END ELSE '' END)
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
               CASE WHEN spr_id=108 THEN'| Artikel IN' END ELSE '' END),  
		 MIN( CASE WHEN werbeaenderung_artikelentfernung_fg<>0 THEN                  
               CASE WHEN spr_id=108 THEN'| Artikel OUT' END ELSE '' END),	
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
               CASE WHEN spr_id=22 THEN'| Posten zmena' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| KDN/KDP zmena' END ELSE '' END)
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
               CASE WHEN spr_id=22 THEN'| Modificare Posten' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| Modificare KDN/KDP' END ELSE '' END)
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
               CASE WHEN spr_id=22 THEN'| Posten Change' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| KDN/KDP Change' END ELSE '' END)
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
               CASE WHEN spr_id=22 THEN'| Posten promjena' END ELSE '' END),
		 MAX( CASE WHEN  werbeaenderung_kundenkarte_personalisiert_fg<>0 THEN                      
               CASE WHEN spr_id=22 THEN'| KDN/KDP promjena' END ELSE '' END)
			   ) AS wbs_compound_fg_hr
FROM dbp_view.v_wbs_werbeaenderungen v01
JOIN  dbp_view.v_spr spr
ON spr_id IN (22, 124, 108, 65, 90,95,18)
WHERE v01.dat_beladung = CURRENT_DATE
     GROUP BY 
      v01.mandant_id
, v01.aktion_id
, v01.offer_id
, v01.dat_ab
, v01.dat_bis
, v01.art_id
, v01.dat_beladung
;