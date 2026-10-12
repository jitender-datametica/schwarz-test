create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_WBS_ART_AKTION_PMR_PER(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	ART_ID_CONCAT,
	WBS_ART_ID,
	AKTION_DAUER,
	AKTION_ID,
	KJWO_VON,
	KJWO_WW,
	DAT_VON,
	DAT_BIS,
	DAT_VON_REF,
	DAT_BIS_REF,
	WTAG_ID_VON,
	MUTTER_WB_ID,
	MENGE,
	MENGE_SA,
	KORRIGIERTE_MENGE,
	SALES_FG,
	MENGE_AF_4WO,
	IN_GRUPPE_FG,
	TV_FG,
	TITELSEITE_FG,
	RUECKSEITE_FG,
	MULTI_OFFER_ID_FG,
	BONUSKAUF_FG,
	GK_FG,
	COMPOUND_FG,
	COMPOUND_FG_DE,
	COMPOUND_FG_CZ,
	COMPOUND_FG_SK,
	COMPOUND_FG_HR,
	COMPOUND_FG_PL,
	COMPOUND_FG_RO,
	COMPOUND_FG_BG,
	LOKALE_GESCHAEFTSVORFALL_BEZ,
	VK_AKTION_BRUTTO,
	VK_AKTION_BRUTTO_REF_CONCAT,
	PREISNACHLASS_REF_CONCAT,
	VK_VOR_AKTION_BRUTTO,
	ANZ_ART_IN_GRUPPE,
	COUNT_MAERKTE_VERGLEICH,
	KJWO_HIST_AKTION,
	FAKTOR_FLAKI_HIST_AKTION,
	MENGE_HIST_AKTION,
	MENGE_AKTIONSSTART_HIST_AKTION,
	MENGE_WE_ZENTRALE_HIST_AKTION,
	ANZAHL_NULLBESTAND_HIST_AKTION,
	ANZAHL_TAGE_AKTION_HIST_AKTION,
	MENGE_HISTORIE_AF_HIST_AKTION,
	SOLLBESTAND_HIST_AKTION,
	MIN_SICHERH_BESTAND_HIST_AKTION,
	MENGE_ENDBESTAND_HIST_AKTION,
	UMSATZ_NETTO_HIST_AKTION,
	AKTION_RANK
) as



WITH TOP_DAT_BERECHNUNG AS (
        SELECT  DISTINCT TOP 5 dat_beladung 
        FROM dbp_view.v_wbs_werbeaenderungen ORDER BY  dat_beladung DESC
),
act_prom AS (SELECT DISTINCT v00.mandant_id,  
        v00.art_id, 
        FROM dbp_view.v_wbs_werbeaenderungen v00
        JOIN TOP_DAT_BERECHNUNG v99
        ON v00.dat_beladung = v99.dat_beladung),
        
act_prom_art_ref_count AS (	
SELECT DISTINCT v01.mandant_id, v01.art_id, ek_art_id_ref, dat_angebot_gueltig_von AS dat_von, dat_angebot_gueltig_bis AS dat_bis, 
COUNT(wup_id) AS wup_id_count
FROM dbp_view.v_ANGEBOT_ART_WUP_ZU v01

JOIN dbp_view.v_ANGEBOT v01a
ON v01.ANGEBOT_NR = v01a.ANGEBOT_NR 
AND v01.mandant_id = v01a.mandant_id 
AND v01a.angebot_geloescht_fg = 0

JOIN (
SELECT angebot_nr, mandant_id, MAX(CASE WHEN angebot_attribut_id = 53 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS ek_art_id_ref
FROM dbp_view.v_angebot_attribut_zu WHERE angebot_attribut_id =53
GROUP BY 1,2) v01b
ON v01.ANGEBOT_NR=v01b.ANGEBOT_NR 
AND v01.mandant_id=v01b.mandant_id 

JOIN dbp_view.v_art v01aa
ON v01b.ek_art_id_ref = v01aa.kl_art_id
AND v01.mandant_id = v01aa.mandant_id
JOIN act_prom v00
ON  v01.mandant_id = v00.mandant_id
AND v01.art_id = v00.art_id
WHERE v01a.dat_angebot_gueltig_bis>=CURRENT_DATE::DATE - 365 AND v01.art_id <> v01aa.art_id AND ek_art_id_ref <>0
GROUP BY v01.mandant_id, v01.art_id, v01aa.art_id, ek_art_id_ref, v01a.dat_angebot_gueltig_von, v01a.dat_angebot_gueltig_bis

),
act_prom_art_ref_rank AS( 
 SELECT v01.mandant_id,
 v01.art_id,
 v01.ek_art_id_ref,v01.dat_von, v01.dat_bis,
 ROW_NUMBER()OVER(PARTITION BY v01.art_id, v01.mandant_id, v01.dat_von, v01.dat_bis ORDER BY v01.wup_id_count DESC) AS rk
 FROM act_prom_art_ref_count v01
 ),

 act_prom_art_ref AS (
SELECT 
v01.mandant_id,
 v01.art_id,
 v01.ek_art_id_ref, v01.dat_von, v01.dat_bis,
 FROM act_prom_art_ref_rank v01
 WHERE rk=1 
 ),
prices_ref AS( SELECT DISTINCT aktion_id, mandant_id, art_id, wup_id, MAX(VK_AKTION_BRUTTO) AS VK_AKTION_BRUTTO_REF, MAX(vk_vor_aktion_brutto) AS vk_vor_aktion_brutto  FROM dbp_view.v_wbs_art_aktion_per GROUP BY aktion_id, mandant_id, art_id, wup_id),
	  
price_normal AS ( SELECT DISTINCT aktion_id, mandant_id, art_id, wup_id,  MAX(vk_vor_aktion_brutto)AS vk_vor_aktion_brutto FROM dbp_view.v_wbs_art_aktion_per
               GROUP BY aktion_id, mandant_id, art_id, wup_id),

werbeflaechenabschnitt_spr AS(
SELECT
 v01.werbeflaechenabschnitt_id
,v01.werbeflaechenabschnitt_name                   
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_                        
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_de                                 
,MAX(CASE WHEN v01.spr_id = 124 THEN v01.werbeflaechenabschnitt_wfl_bez END)  AS werbeflaechenabschnitt_wfl_bez_cz    
,MAX(CASE WHEN v01.spr_id = 108 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_sk    
,MAX(CASE WHEN v01.spr_id =  65 THEN v01.werbeflaechenabschnitt_wfl_bez END)  AS werbeflaechenabschnitt_wfl_bez_hr    
,MAX(CASE WHEN v01.spr_id =  90 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_pl    
,MAX(CASE WHEN v01.spr_id =  95 THEN v01.werbeflaechenabschnitt_wfl_bez END)  AS werbeflaechenabschnitt_wfl_bez_ro    
,MAX(CASE WHEN v01.spr_id =  18 THEN v01.werbeflaechenabschnitt_wfl_bez END)  AS werbeflaechenabschnitt_wfl_bez_bg     
FROM dbp_view.v_werbeflaechenabschnitt_spr_zu v01
GROUP BY 
 v01.werbeflaechenabschnitt_id,v01.werbeflaechenabschnitt_name),
 
werbemittel_spr AS(
SELECT
 v01.werbemittelkanal_id
,v01.werbemittel_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.werbemittel_wfl_bez END) AS werbemittel_wfl_bez_                        
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.werbemittel_wfl_bez END) AS werbemittel_wfl_bez_de                                 
,MAX(CASE WHEN v01.spr_id = 124 THEN v01.werbemittel_wfl_bez END) AS werbemittel_wfl_bez_cz    
,MAX(CASE WHEN v01.spr_id = 108 THEN v01.werbemittel_wfl_bez END) AS werbemittel_wfl_bez_sk    
,MAX(CASE WHEN v01.spr_id =  65 THEN v01.werbemittel_wfl_bez END) AS werbemittel_wfl_bez_hr    
,MAX(CASE WHEN v01.spr_id =  90 THEN v01.werbemittel_wfl_bez END) AS werbemittel_wfl_bez_pl    
,MAX(CASE WHEN v01.spr_id =  95 THEN v01.werbemittel_wfl_bez END) AS werbemittel_wfl_bez_ro    
,MAX(CASE WHEN v01.spr_id =  18 THEN v01.werbemittel_wfl_bez END) AS werbemittel_wfl_bez_bg     
FROM dbp_view.v_werbemittel_spr_zu v01
GROUP BY v01.werbemittelkanal_id,v01.werbemittel_id)
   
SELECT 
v01.mandant_id,
v05.aktuell_wup_id AS wup_id_,
v01.nb_id,
v01.art_id,
LISTAGG(DISTINCT a.kl_art_id, '|') WITHIN GROUP (ORDER BY a.kl_art_id) OVER (PARTITION BY v011.art_id, v01.mandant_id) AS art_id_concat,
v011.art_id AS wbs_art_id,
v01.aktion_dauer, 
v01.aktion_id,
v01.kjwo_von,
v09.kjwo_ww,
v01.dat_von,
v01.dat_bis,
v011.dat_von AS dat_von_ref,
v011.dat_bis AS dat_bis_ref,
v01.wtag_id_von,
v01.mutter_wb_id, 
MAX(v01.menge_gesamt_bme) AS menge,
MAX(v01.menge_sa_bme) AS menge_sa,
MAX(v01.zeitraum_korrigierte_menge) AS korrigierte_menge,
MAX(COALESCE(v01.sales_fg,0)) AS sales_fg,
MAX(v01.zeitraum_menge_af_4wo) AS MENGE_AF_4WO,
MAX(COALESCE(v01.in_gruppe_fg,0)) AS in_gruppe_fg,
MAX(COALESCE(v01.tv_fg,0)) AS tv_fg,
MAX(COALESCE(v01.titelseite_fg,0)) AS titelseite_fg,
MAX(COALESCE(v01.rueckseite_fg,0)) AS rueckseite_fg,
MAX(COALESCE(v01.MULTI_OFFER_ID_FG,0)) AS MULTI_OFFER_ID_FG,
MAX(COALESCE(v01.BONUSKAUF_FG,0)) AS BONUSKAUF_FG,
MAX(COALESCE(v01.gk_fg,0)) AS gk_fg
,MAX(CONCAT(  CASE WHEN v01.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,   
           CASE WHEN v01.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v01.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN COALESCE(v01.gk_fg,0)<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v01.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,        
           CASE WHEN COALESCE(v01.kundenkarte_personalisiert_fg,0)<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,
           CASE WHEN COALESCE(v01.bonuskauf_fg,0)<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_ <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_ <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v01.lokale_geschaeftsvorfall_bez <> '' THEN CONCAT ('| ', v01.lokale_geschaeftsvorfall_bez, ' ') ELSE '' END         
        )) AS compound_fg
,MAX(CONCAT(  CASE WHEN v01.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,   
           CASE WHEN v01.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v01.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN COALESCE(v01.gk_fg,0)<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v01.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,        
           CASE WHEN COALESCE(v01.kundenkarte_personalisiert_fg,0)<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,
           CASE WHEN COALESCE(v01.bonuskauf_fg,0)<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_ <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_ <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v01.lokale_geschaeftsvorfall_bez <> '' THEN CONCAT ('| ', v01.lokale_geschaeftsvorfall_bez, ' ') ELSE '' END         
        )) AS compound_fg_de
, MAX(CONCAT(  CASE WHEN v01.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,
           CASE WHEN v01.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v01.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN COALESCE(v01.gk_fg,0)<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v01.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,         
           CASE WHEN COALESCE(v01.kundenkarte_personalisiert_fg,0)<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,          
           CASE WHEN COALESCE(v01.bonuskauf_fg,0)<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_cz <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_cz, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_cz <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_cz, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v01.lokale_geschaeftsvorfall_bez <> '' THEN CONCAT ('| ', v01.lokale_geschaeftsvorfall_bez, ' ') ELSE '' END         
        )) AS compound_fg_cz
, MAX(CONCAT(  CASE WHEN v01.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,           
           CASE WHEN v01.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v01.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN COALESCE(v01.gk_fg,0)<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v01.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,         
           CASE WHEN COALESCE(v01.kundenkarte_personalisiert_fg,0)<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,         
           CASE WHEN COALESCE(v01.bonuskauf_fg,0)<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_sk <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_sk, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_sk <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_sk, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v01.lokale_geschaeftsvorfall_bez <> '' THEN CONCAT ('| ', v01.lokale_geschaeftsvorfall_bez, ' ') ELSE '' END         
        )) AS compound_fg_sk
, MAX(CONCAT(  CASE WHEN v01.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,       
           CASE WHEN v01.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v01.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN COALESCE(v01.gk_fg,0)<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v01.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,           
           CASE WHEN COALESCE(v01.kundenkarte_personalisiert_fg,0)<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,          
           CASE WHEN COALESCE(v01.bonuskauf_fg,0)<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_hr <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_hr, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_hr <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_hr, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v01.lokale_geschaeftsvorfall_bez <> '' THEN CONCAT ('| ', v01.lokale_geschaeftsvorfall_bez, ' ') ELSE '' END         
        )) AS compound_fg_hr
, MAX(CONCAT(  CASE WHEN v01.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,          
           CASE WHEN v01.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v01.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN COALESCE(v01.gk_fg,0)<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v01.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,         
           CASE WHEN COALESCE(v01.kundenkarte_personalisiert_fg,0)<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,         
           CASE WHEN COALESCE(v01.bonuskauf_fg,0)<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_pl <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_pl, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_pl<> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_pl, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v01.lokale_geschaeftsvorfall_bez <> '' THEN CONCAT ('| ', v01.lokale_geschaeftsvorfall_bez, ' ') ELSE '' END         
        )) AS compound_fg_pl
, MAX(CONCAT(  CASE WHEN v01.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,        
           CASE WHEN v01.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v01.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN COALESCE(v01.gk_fg,0)<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v01.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,
           CASE WHEN COALESCE(v01.kundenkarte_personalisiert_fg,0)<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,
           CASE WHEN COALESCE(v01.bonuskauf_fg,0)<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_ro <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_ro, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_ro <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_ro, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v01.lokale_geschaeftsvorfall_bez <> '' THEN CONCAT ('| ', v01.lokale_geschaeftsvorfall_bez, ' ') ELSE '' END         
        )) AS compound_fg_ro
, MAX(CONCAT(  CASE WHEN v01.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,        
           CASE WHEN v01.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v01.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN COALESCE(v01.gk_fg,0)<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v01.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,
           CASE WHEN COALESCE(v01.kundenkarte_personalisiert_fg,0)<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,         
           CASE WHEN COALESCE(v01.bonuskauf_fg,0)<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_bg <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_bg, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_bg <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_bg, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v01.lokale_geschaeftsvorfall_bez <> '' THEN CONCAT ('| ', v01.lokale_geschaeftsvorfall_bez, ' ') ELSE '' END         
        )) AS compound_fg_bg,
MAX(COALESCE(v01.lokale_geschaeftsvorfall_bez,'')) AS LOKALE_GESCHAEFTSVORFALL_BEZ,
MAX(v01.vk_aktion_brutto)  AS vk_aktion_brutto,
MAX(vk_aktion_brutto_ref_concat) AS vk_aktion_brutto_ref_concat,
MAX(preisnachlass_ref_concat) AS preisnachlass_ref_concat,
MAX(v01.vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
MAX(v01.anz_art_in_gruppe) AS anz_art_in_gruppe,

COUNT(DISTINCT v01.wup_id) AS count_maerkte_vergleich,

v01.kjwo_von AS kjwo_hist_aktion,
wkw1.faktor_flaki AS faktor_flaki_hist_aktion,
(wkw1.menge_tag1 + wkw1.menge_tag2 + wkw1.menge_tag3 + wkw1.menge_tag4 + wkw1.menge_tag5 + wkw1.menge_tag6 + wkw1.menge_tag7) AS menge_hist_aktion,
wkw1.menge_aktionsstart AS menge_aktionsstart_hist_aktion,
wkw1.we_menge_zentral AS menge_we_zentrale_hist_aktion,
wkw1.anzahl_nullbestand AS anzahl_nullbestand_hist_aktion,
wkw1.anzahl_tage_aktion AS anzahl_tage_aktion_hist_aktion,
wkw1.menge_historie_af AS menge_historie_af_hist_aktion,
wkw1.sollbestand AS sollbestand_hist_aktion,
wkw1.min_sicherh_bestand AS min_sicherh_bestand_hist_aktion,
wkw1.menge_endbestand AS menge_endbestand_hist_aktion,
(wkw1.umsatz_netto_tag1 + wkw1.umsatz_netto_tag2 + wkw1.umsatz_netto_tag3 + wkw1.umsatz_netto_tag4 + wkw1.umsatz_netto_tag5 + wkw1.umsatz_netto_tag6 + wkw1.umsatz_netto_tag7) AS umsatz_netto_hist_aktion,
ROW_NUMBER()OVER(PARTITION BY v01.art_id, v01.wup_id, v01.dat_von, v01.kjwo_von ORDER BY v01.aktion_id)  AS aktion_rank			   
FROM dbp_view.v_WBS_ART_AKTION_PER v01

INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v01.mandant_id  
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

JOIN dbp_view.v_art a
ON v01.art_id = a.art_id
AND v01.mandant_id = a.mandant_id

LEFT JOIN (SELECT prices_ref.mandant_id, prices_ref.art_id,prices_ref.aktion_id,
LISTAGG( DISTINCT prices_ref.vk_aktion_brutto_ref, '|') WITHIN GROUP (ORDER BY prices_ref.vk_aktion_brutto_ref) AS vk_aktion_brutto_ref_concat,
LISTAGG( DISTINCT CONCAT(ROUND((1-DIV0( prices_ref.vk_aktion_brutto_ref, prices_ref.vk_vor_aktion_brutto))*100,2),'%'),'|') WITHIN GROUP (ORDER BY CONCAT(ROUND((1-DIV0( prices_ref.vk_aktion_brutto_ref, prices_ref.vk_vor_aktion_brutto))*100,2),'%'))  AS preisnachlass_ref_concat 
FROM prices_ref

GROUP BY prices_ref.mandant_id, prices_ref.art_id,prices_ref.aktion_id)prices_ref

ON v01.mandant_id=prices_ref.mandant_id
AND v01.art_id=prices_ref.art_id
AND v01.aktion_id=prices_ref.aktion_id

LEFT JOIN price_normal
ON v01.mandant_id=price_normal.mandant_id
AND v01.art_id=price_normal.art_id
AND v01.aktion_id=price_normal.aktion_id

JOIN  act_prom_art_ref v011 
ON v011.mandant_id = v01.mandant_id 
AND v011.ek_art_id_ref = v01.art_id 

LEFT JOIN dbp_view.v_werbung_kennzahlen_woche wkw1
ON v01.mandant_id = wkw1.mandant_id
AND v01.art_id = wkw1.art_id
AND v01.wup_id = wkw1.wup_id
AND v01.kjwo_von = wkw1.kjwo

LEFT JOIN dbp_view.v_werbewoche_kl v09
ON v01.mandant_id = v09.mandant_id
AND v01.dat_von = v09.dat

LEFT JOIN (SELECT DISTINCT v7.mandant_id 
   ,v7.art_id
   ,v7.wup_id 
   ,v7.nb_id
   ,v7.angebot_nr
   ,v7a.aktion_id FROM dbp_view.v_angebot_art_wup_zu v7
   JOIN dbp_view.v_angebot v7a
   ON v7.mandant_id = v7a.mandant_id 						   
   AND v7.angebot_nr = v7a.angebot_nr
) v7
ON v01.mandant_id = v7.mandant_id 
   AND v01.art_id = v7.art_id
   AND v01.wup_id = v7.wup_id 
   AND v01.nb_id = v7.nb_id
   AND v01.aktion_id  = v7.aktion_id								
  
LEFT JOIN (SELECT TRY_CAST(v10.ANGEBOT_NR AS NUMBER) AS angebot_id, v10.mandant_id 
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_,'| ') AS werbeflaechenabschnitt_wfl_bez_
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_de,'| ') AS werbeflaechenabschnitt_wfl_bez_de
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_cz,'| ') AS werbeflaechenabschnitt_wfl_bez_cz
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_sk,'| ') AS werbeflaechenabschnitt_wfl_bez_sk
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_hr,'| ') AS werbeflaechenabschnitt_wfl_bez_hr
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_pl,'| ') AS werbeflaechenabschnitt_wfl_bez_pl
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_ro,'| ') AS werbeflaechenabschnitt_wfl_bez_ro
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_bg,'| ') AS werbeflaechenabschnitt_wfl_bez_bg
FROM
dbp_view.v_angebot_werbemittel_promotion_event_zu v10 
     
  JOIN werbeflaechenabschnitt_spr v10a
    ON  TRIM(REGEXP_SUBSTR(v10.werbeflaechenabschnitt_name, '^[^\\(]+'))= v10a.werbeflaechenabschnitt_name
  
  GROUP BY v10.angebot_nr, v10.mandant_id
)v101
ON v01.mandant_id = v101.mandant_id 
   AND TRY_CAST(v7.ANGEBOT_NR AS NUMBER)  = v101.angebot_id

LEFT JOIN (SELECT TRY_CAST(v10.ANGEBOT_NR AS NUMBER) AS angebot_id , v10.mandant_id 
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_ ,'| ') AS werbemittel_wfl_bez_
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_de ,'| ') AS werbemittel_wfl_bez_de
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_cz ,'| ') AS werbemittel_wfl_bez_cz
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_sk ,'| ') AS werbemittel_wfl_bez_sk
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_hr ,'| ') AS werbemittel_wfl_bez_hr
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_pl ,'| ') AS werbemittel_wfl_bez_pl
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_ro ,'| ') AS werbemittel_wfl_bez_ro
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_bg ,'| ') AS werbemittel_wfl_bez_bg
FROM 
dbp_view.v_angebot_werbemittel_promotion_event_zu v10 
	 
 JOIN werbemittel_spr v10b
   ON v10.werbemittelkanal_id = v10b.werbemittelkanal_id
   AND v10.werbemittel_id = v10b.werbemittel_id  
  GROUP BY v10.angebot_nr, v10.mandant_id
)v102
ON  v01.mandant_id = v102.mandant_id 
AND TRY_CAST(v7.ANGEBOT_NR AS NUMBER)  = v102.angebot_id   
LEFT JOIN (SELECT TRY_CAST(v10.ANGEBOT_NR AS NUMBER) AS angebot_id, v10.mandant_id 
, LISTAGG(DISTINCT v10c.werbeflaechenthema_wfl_bez,'| ') AS werbeflaechenthema_wfl_bez

FROM
dbp_view.v_angebot_werbemittel_promotion_event_zu v10 
   JOIN dbp_view.v_l_werbeflaechenthema v10c
   ON  v10.mandant_id = v10c.mandant_id
   AND v10.werbeflaechenthema_cd = v10c.werbeflaechenthema_cd
  GROUP BY v10.angebot_nr, v10.mandant_id
)v103
ON  v01.mandant_id = v103.mandant_id 
AND TRY_CAST(v7.ANGEBOT_NR AS NUMBER)  = v103.angebot_id
   
LEFT JOIN dbp_view.v_tag v02
ON v01.DAT_VON = v02.dat   

WHERE v02.akt_kj >=-2  

GROUP BY 
v01.mandant_id,
v01.wup_id,
aktuell_wup_id,
v01.nb_id,
v01.art_id,
a.kl_art_id,
v01.aktion_dauer, 
v01.aktion_id,
v01.kjwo_von,
v09.kjwo_ww,
v01.dat_von,
v01.dat_bis,
v011.dat_von,
v011.dat_bis,
v01.wtag_id_von,
v01.mutter_wb_id,


v01.DAT_VON, 
v01.DAT_BIS, 
v02.kjwo,
wkw1.faktor_flaki,
menge_hist_aktion,
wkw1.menge_aktionsstart,
wkw1.we_menge_zentral,
wkw1.anzahl_nullbestand,
wkw1.anzahl_tage_aktion,
wkw1.menge_historie_af,
wkw1.sollbestand,
wkw1.min_sicherh_bestand,
wkw1.menge_endbestand,
umsatz_netto_hist_aktion,
v011.art_id;
