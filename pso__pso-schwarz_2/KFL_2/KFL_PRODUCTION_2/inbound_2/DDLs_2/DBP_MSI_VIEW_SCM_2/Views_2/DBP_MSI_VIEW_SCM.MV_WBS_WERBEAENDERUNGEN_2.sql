CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WBS_WERBEAENDERUNGEN_2 (
	MANDANT_ID,
	AKTION_ID,
	OFFER_ID,
	WUP_ID,
	ART_ID,
	ART_ID_DISPLAY,
	ART_ID_VKSET,
	DAT_BELADUNG,
	MANDANT_ID_VZ,
	WUP_ID_VZ,
	NB_ID,
	NB_ID_VZ,
	DAT_AB,
	DAT_BIS,
	KJWO,
	KJWO_WW,
	AUSLIEFERGRUPPE_ID,
	WBS_PHASE_ID,
	GP_ID,
	GK_FG,
	FACHBODEN_FG,
	TITEL_FG,
	RUECKSEITE_FG,
	ERSTE_SEITE_FG,
	KASSE_FG,
	TV_FG,
	NEUER_ARTIKEL_FG,
	PREIS_NORMAL,
	PREIS_AKTION,
	ANZ_TAGE_WERBUNG,
	TAGE_BIS_BESTELLUNG_LIEFERANT,
	TAGE_BIS_DEADLINE_PRINT,
	TAGE_BIS_INITIALE_BELIEFERUNG,
	ANZ_WERBEAENDERUNGEN_AUFG,
	ANZ_WERBEAENDERUNGEN_NACH_PRINT,
	WERBEAENDERUNG_ANGEBOTSPREISREDUKTION_FG,
	WERBEAENDERUNG_ANGEBOTSPREISERHOEHUNG_FG,
	WERBEAENDERUNG_NORMALPREISREDUKTION_FG,
	WERBEAENDERUNG_NORMALPREISERHOEHUNG_FG,
	WERBEAENDERUNG_ARTIKELNEUANLAGE_FG,
	WERBEAENDERUNG_ARTIKELENTFERNUNG_FG,
	WERBEAENDERUNG_MARKTANZAHLERHOEHUNG_FG,
	WERBEAENDERUNG_MARKTANZAHLREDUKTION_FG,
	WERBEAENDERUNG_ABBILDUNGSAENDERUNG_FG,
	WERBEAENDERUNG_RADIO_TV_BILLBOARD_FG,
	WERBEAENDERUNG_KOLLIINHALTSAENDERUNG_FG,
	WERBEAENDERUNG_WERBETHEMA_FG,
	WERBEAENDERUNG_SONSTIGES_FG,
    WERBEAENDERUNG_BONUSKAUF_PROMOTIONSTYP_FG,
	MINDESTPLATZIERUNG_FG,
	BEST_GENERIERT_FG,
	HOHE_MENGENAENDERUNG_FG,
	GERINGE_MENGENAENDERUNG_FG,
	GESTEUERTE_PROGNOSE_FG,
	MENGE_MINDESTPLATZIERUNG_BME,
	FIXMENGE_FG,
	FIXMENGE_BME,
	MINDESTMENGE_FG,
	MINDESTMENGE_BME,
	MAXIMALMENGE_FG,
	MAXIMALMENGE_BME,
	BESTAND_WUP_BME,
	OFFENE_BESTELLUNGEN_BME,
	ORDER_FORECAST_BME,
	PROJIZIERTER_BESTAND_VOR_WERBUNG_BME,
	DURCHSCHNITTLICHER_ABVERKAUF_BME,
	PROGNOSE_WERBEZEITRAUM_BME,
	ANTEIL_WUP_ARTIKEL_PERC,
	BEDARF_BME,
	BEDARF_AME,
	BEDARF_PAL,
	ZIELBESTAND_BME,
	BESTELLMENGE_FINAL_AME,
	BESTELLMENGE_FINAL_PAL,
	BESTELLMENGE_OHNE_BESTAND_AME,
	BESTELLMENGE_OHNE_BESTAND_PAL,
	BESTELLMENGE_MIT_BESTAND_AME,
	BESTELLMENGE_MIT_BESTAND_PAL,
	PREIS_NACHLASS_PERC,
	WERBUNG_IN_X_TAGEN,
	MULTI_OFFER_ID_FG,
	WERBEAENDERUNG_MENGE_VORLAUF,
	MHD_ZEITRAUM,
	LAGER_PROZENT,
	FIXMENGE_WFL_FG,
	FIXMENGE_WFL_BME,
	PREIS_NORMAL_VORLAUF,
	PREIS_AKTION_VORLAUF,
	TOP_GK_FG,
	BESTAND_VZ,
	BLOCKIERTER_BESTAND_VZ,
	FINAL_VERFUEGBARER_BESTAND_VZ,
	BESTELLUNG_LIEFERANT_MENGE,
	BESTELLUNG_LIEFERANT_FG,
	STILLE_AKTION_FG,
	PROGNOSE_UNGESTEUERT,
	MENGE_ZULETZT_DC_PROMO,
	WERBELISTUNG_FG,
	WERBELISTUNG_AENDERUNG_FG,
	AKTION_REIHENFOLGE_AENDERUNG_FG,
	AKTION_REIHENFOLGE_ZUKUNFT_NR,
	REFERENZMARKT_FALLBACK_FG,
	LISTUNG_DAT_VON,
	LISTUNG_DAT_BIS,
	LISTUNG_DAT_BIS_VZ,
	GP_ID_AENDERUNG_FG,
	KONDITIONSART_ZAR5_GUELTIGKEIT_AENDERUNG_FG,
	POSTEN_KZ_SAP_AENDERUNG_FG,
	SAISON_ID,
	SAISON_ID_AENDERUNG_FG,
	BEST_MENGE_EINH_ID_AENDERUNG_FG,
	RABATTAENDERUNG_FG,
	ABBILDUNG_VORTAG_ID,
	WERBETHEMA_VORTAG_BEZ,
	DISPOMERKMAL,
	RANK_AKTION_BELADUNG,
	ANZAHL_ARTIKELENTFERNUNG,
	ANZAHL_ARTIKELNEUANLAGE,
	ANZAHL_WUP,
	ARTIKELENTFERNUNG_ART_FG,
	ARTIKELNEUANLAGE_ART_FG,
	COMPOUND_FG,
	COMPOUND_FG_DE,
	COMPOUND_FG_CZ,
	COMPOUND_FG_SK,
	COMPOUND_FG_HR,
	COMPOUND_FG_PL,
	COMPOUND_FG_RO,
	COMPOUND_FG_BG,
	WERBEAENDERUNG_KUNDENKARTE_PERSONALISIERT_FG,
	OUTLIER_FG,
	Z_SCORE,
	ART_ID_REF,
	WUP_ID_REF,
	NB_ID_REF,
	FAKTOR_REF,
	ANZ_ANGEBOTE_ZEITRAUM,
	ANZ_ANGEBOTE_ZEITRAUM_AENDERUNG_FG,
	FIXMENGE_WFL_AENDERUNG_FG,
	FIXMENGE_EK_AENDERUNG_FG,
	WFL_GEPRUEFT_FG,
	WFL_NUTZER_KOMMENTAR_TXT,
	MIN_SICHERH_BESTAND,
	ESTIMATION_ID,
	ESTIMATION_ID_AENDERUNG_FG,
	MENGE_KOLLIINHALT_VORTAG_BME,
	FIXMENGE_EK_VORTAG_BME,
	FIXMENGE_WFL_VORTAG_BME,
	VORTAG_AKTION_REIHENFOLGE_ZUKUNFT_NR,
	UTP_RELEVANT_AENDERUNG_FG,
	UTP_RELEVANT_FG,
	DAT_GUELTIG_VON_KONDITIONSART_ZAR5,
	DAT_GUELTIG_BIS_KONDITIONSART_ZAR5,
	UTP_LIEFERANT_BESTAETIGT_FG,
	WFL_MENGE_GEPRUEFT_RESET_FG,
	KUNDENKARTE_PERSONALISIERT_FG,
	PMR_WERBETHEMA_ID,
	BEDARF_ESTIMATION_2_BME,
	BESTELLMENGE_ESTIMATION_2_OHNE_BESTAND_AME,
	BESTELLMENGE_ESTIMATION_2_MIT_BESTAND_AME,
	KOLLIFAKTOR,
    BONUSKAUF_PROMOTIONSTYP_LISTE_TXT
) AS
--AP0043130 | baranowska | initial creation
--AP0048550 cbru1709  additional columns added
--AP0048550 | 20210324 | nwag2310   | diplay + vkset
--AP0048550 | 20210330 | cbru1709 | ausliefergruppe -9 bei NULL
--AP0048550 | 20210504 | cbru1709 | diverse neue Felder hinzugefuegt
-- 20.07.2021 sanadze (Mayko): SPEC0106469 erstellt auf Snowflake
--AP0048550 | 20210707 | cbru1709 | art_list_wup_zu_per_2 hinzugefügt 
-- 07.07.2022 richter INC4967674 Verlangerung der RANK()Berechnung von MSI in die View
-- 20220704 richternic AP0128888 SPEC0156304 Berechnung Artikelentfernung/neuanlage auf Artikelebene
-- 08.08.2022 richternic INC5107687 RANK() Nur auf Artikelebene - Nur der letzte Beladungstag soll im FE geflaggt werden koennen 
-- 10.10.2023 richternic AP0155057 SPEC0179398 Einschraenken auf 140 Tage
-- 03.01.2022 richternic SPEC0179811 rename Felder + neue Felder 
-- 08.03.2023 richternic AP0160697_SPEC0185039 neue Felder einfuegen
-- 11.04.2023 richternic SPEC0191587	neue Felder einfuegen
--2023-08-25, dknop, adding compound_fg including concat of all flags	
/* Einschraenkung leider nicht moeglich hier, da dies auswirkungen auf Freeze Dokument hat
WITH TOP_DAT_BERECHNUNG AS (
        SELECT  DISTINCT TOP 5 dat_beladung 
        FROM dbp_view.v_wbs_werbeaenderungen_2 ORDER BY dat_beladung DESC
)*/
--2023-09-07, dknop, changing definition of gp_id
--2023-10-24, dknop, adding outlier_fg logic
--2023-11-16, dknop, updating logic for outlier_fg - adding dat_ab and dat_bis
--2024-01-17, dknop, AP0196878_SPEC0224717, adding min_sicherh_bestand
--2024-02-12, dknop, adding ,z_score,art_id_ref,wup_id_ref,nb_id_ref,faktor_ref
--2024-02-12, AP0188857, SPEC0218680, dknop, updating compound flag: adding kundenkarte_personalisiert_fg, nur_online_fg, stille_aktion_mit_menge_fg; adding werbeaenderung_kundenkarte_personalisiert_fg,anz_angebote_zeitraum, anz_angebote_zeitraum_aenderung_fg,fixmenge_wfl_aenderung_fg,fixmenge_ek_aenderung_fg
--2024-02-12, dknop, adding wfl_menge_geprueft_fg, wfl_nutzer_kommentar_txt
--2024-05-07, dknop, adding ,kjwo_ww from table werbewoche_kl_2
--2024-05-15, dknop, INC8514688, updating logic for kommentar to avoid duplicates
--2024-04-24, AP0205751, SPEC0247117 dknop, adding ,estimation_id_aenderung_fg, menge_kolliinhalt_vortag_bme,fixmenge_ek_vortag_bme,fixmenge_wfl_vortag_bme,vortag_aktion_reihenfolge_zukunft_nr,utp_relevant_aenderung_fg,utp_relevant_fg ,utp_relevant_aenderung_fg,
                                               --dat_gueltig_von_konditionsart_zar5,dat_gueltig_bis_konditionsart_zar5,utp_lieferant_bestaetigt_fg, wfl_menge_geprueft_reset_fg
--2024-06-26, dknop, INC8932510, correcting Zscore
--2024-08-06,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-04, AP0202707_SPEC0268776, dknop, adding listung_dat_bis_vz
--2024-10-21,AP0202707,SPEC0269265, dknop, adding gp_id_aenderung_fg,konditionsart_zar5_gueltigkeit_aenderung_fg,posten_kz_sap_aenderung_fg,saison_id,saison_id_aenderung_fg,best_menge_einh_id_aenderung_fg,
--2024-10-30, INC9663820, dknop, CASE WHEN v1.wup_id_vz = 6140 THEN 4 ELSE v1.mandant_id_vz END instead of mandant_id_vz_ in join to v4a
--2025-01-16, dknop, adding KUNDENKARTE_PERSONALISIERT_FG,PMR_WERBETHEMA_ID; updating Anzahl_WUP
--2025-02-07, dknop, INC10285471, dat_beladung missing in Anzahl_WUP definition
--2025-03-28, dknop, adding kollifaktor
--2025-05-12, adjusting definition of compound_fg, adding new lookup tables for WERBEFLAECHENTHEMA, WERBEFLAECHENABSCHNITT, WERBEMITTEL
--2025-06-25, adjusting definition of compound_fg, removing unecessary flags from compound flag
--2025-10-28, dknop, limit calculation days to 60
--2025-11-06, dknop, AP0296461, SPEC0342263, adding WERBEAENDERUNG_BONUSKAUF_PROMOTIONSTYP_FG, BONUSKAUF_PROMOTIONSTYP_LISTE_TXT

WITH geschaeftsvorfall_spr AS(
SELECT
 v01.mandant_id
,v01.geschaeftsvorfall_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.geschaeftsvorfall_bez END) AS geschaeftsvorfall_bez_                        
,COALESCE(MAX(CASE WHEN v01.spr_id = 22 THEN v01.geschaeftsvorfall_bez END),geschaeftsvorfall_bez_) AS geschaeftsvorfall_bez_de                                 
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.geschaeftsvorfall_bez END),geschaeftsvorfall_bez_) AS geschaeftsvorfall_bez_cz    
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.geschaeftsvorfall_bez END),geschaeftsvorfall_bez_) AS geschaeftsvorfall_bez_sk    
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.geschaeftsvorfall_bez END),geschaeftsvorfall_bez_) AS geschaeftsvorfall_bez_hr    
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.geschaeftsvorfall_bez END),geschaeftsvorfall_bez_) AS geschaeftsvorfall_bez_pl    
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.geschaeftsvorfall_bez END),geschaeftsvorfall_bez_) AS geschaeftsvorfall_bez_ro    
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.geschaeftsvorfall_bez END),geschaeftsvorfall_bez_) AS geschaeftsvorfall_bez_bg     
FROM dbp_view.v_geschaeftsvorfall_spr_zu_2 v01
GROUP BY 
 v01.geschaeftsvorfall_id,v01.mandant_id
),

werbeflaechenabschnitt_spr AS(
SELECT
 v01.werbeflaechenabschnitt_id
,v01.werbeflaechenabschnitt_name                   
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_                        
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_de                                 
,MAX(CASE WHEN v01.spr_id = 124 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_cz    
,MAX(CASE WHEN v01.spr_id = 108 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_sk    
,MAX(CASE WHEN v01.spr_id =  65 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_hr    
,MAX(CASE WHEN v01.spr_id =  90 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_pl    
,MAX(CASE WHEN v01.spr_id =  95 THEN v01.werbeflaechenabschnitt_wfl_bez END)AS werbeflaechenabschnitt_wfl_bez_ro    
,MAX(CASE WHEN v01.spr_id =  18 THEN v01.werbeflaechenabschnitt_wfl_bez END) AS werbeflaechenabschnitt_wfl_bez_bg     
FROM dbp_view.v_werbeflaechenabschnitt_spr_zu_2 v01
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
FROM dbp_view.v_werbemittel_spr_zu_2 v01
GROUP BY v01.werbemittelkanal_id,v01.werbemittel_id)
  
SELECT
 v1.mandant_id
,v1.aktion_id
,v1.offer_id 
, v05.aktuell_wup_id wup_id 
,v1.art_id
,CASE WHEN v2.artikeltyp_id=12 THEN v1.art_id ELSE CASE WHEN v3.artikeltyp_id=12 THEN v1.art_id_mutter END END AS art_id_display 
,CASE WHEN v2.artikeltyp_id=10 THEN v1.art_id ELSE CASE WHEN v3.artikeltyp_id=10 THEN v1.art_id_mutter END END AS art_id_vkset  
,v1.dat_beladung
,CASE WHEN v1.wup_id_vz = 6140 THEN 4 ELSE v1.mandant_id_vz END AS mandant_id_vz
,v1.wup_id_vz
,v1.nb_id
,v1.nb_id_vz
,v1.dat_ab
,v1.dat_bis 
,v1.kjwo
,v9.kjwo_ww
,COALESCE(v1.ausliefergruppe_id,' ') AS ausliefergruppe_id
,v1.wbs_phase_id
,COALESCE((CASE WHEN v1.gp_id=0 THEN -1 ELSE v1.gp_id END),-1) AS gp_id_
,v1.gk_fg
,v1.fachboden_fg 
,v1.titel_fg
,v1.rueckseite_fg 
,v1.erste_seite_fg 
,v1.kasse_fg 
,v1.tv_fg 
,v1.neuer_artikel_fg
,v1.preis_normal 
,v1.preis_aktion
,v1.anz_tage_werbung
,v1.tage_bis_bestellung_lieferant
,v1.tage_bis_deadline_print 
,v1.tage_bis_initiale_belieferung 
,v1.anz_werbeaenderungen_aufg
,v1.anz_werbeaenderungen_nach_print
,v1.werbeaenderung_angebotspreisreduktion_fg 
,v1.werbeaenderung_angebotspreiserhoehung_fg
,v1.werbeaenderung_normalpreisreduktion_fg 
,v1.werbeaenderung_normalpreiserhoehung_fg
,v1.werbeaenderung_artikelneuanlage_fg 
,v1.werbeaenderung_artikelentfernung_fg
,v1.werbeaenderung_marktanzahlerhoehung_fg
,v1.werbeaenderung_marktanzahlreduktion_fg
,v1.werbeaenderung_abbildungsaenderung_fg 
,v1.werbeaenderung_radio_tv_billboard_fg
,v1.werbeaenderung_kolliinhaltsaenderung_fg 
,v1.werbeaenderung_werbethema_fg
,v1.werbeaenderung_sonstiges_fg 
,COALESCE(v1.werbeaenderung_bonuskauf_promotionstyp_fg,0)
,v1.mindestplatzierung_fg
,v1.best_generiert_fg
,v1.hohe_mengenaenderung_fg
,v1.geringe_mengenaenderung_fg
,v1.gesteuerte_prognose_fg
,v1.menge_mindestplatzierung_bme 
,v1.fixmenge_fg 
,v1.fixmenge_bme 
,v1.mindestmenge_fg
,v1.mindestmenge_bme 
,v1.maximalmenge_fg 
,v1.maximalmenge_bme 
,v1.bestand_wup_bme
,v1.offene_bestellungen_bme 
,v1.order_forecast_bme
,v1.projizierter_bestand_vor_werbung_bme
,v1.durchschnittlicher_abverkauf_bme
,v1.prognose_werbezeitraum_bme 
,v1.anteil_wup_artikel_perc
,v1.bedarf_bme
,v1.bedarf_ame
,v1.bedarf_pal
,v1.zielbestand_bme 
,0 AS bestellmenge_final_ame 
,0 AS bestellmenge_final_pal 
,v1.bestellmenge_ohne_bestand_ame
,v1.bestellmenge_ohne_bestand_pal
,v1.bestellmenge_mit_bestand_ame
,v1.bestellmenge_mit_bestand_pal
,v1.preis_nachlass_perc 
,(v1.dat_beladung - v1.dat_ab) AS werbung_in_x_tagen
,v1.multi_offer_id_fg
,v1.werbeaenderung_menge_vorlauf
,v2.mhd_zeitraum
,v2.lager_prozent
,v1.fixmenge_wfl_fg
,v1.fixmenge_wfl_bme
,v1.preis_normal_vorlauf
,v1.preis_aktion_vorlauf
,v1.top_gk_fg
,v1.bestand_vz
,v1.blockierter_bestand_vz
,v1.final_verfuegbarer_bestand_vz
,v1.bestellung_lieferant_menge
,v1.bestellung_lieferant_fg
,v1.stille_aktion_fg
,v1.prognose_ungesteuert
,v1.menge_zuletzt_dc_promo
,v1.werbelistung_fg
,v1.werbelistung_aenderung_fg
,COALESCE(v1.AKTION_REIHENFOLGE_AENDERUNG_FG,0) AS AKTION_REIHENFOLGE_AENDERUNG_FG
,v1.AKTION_REIHENFOLGE_ZUKUNFT_NR
--Neu, Tabelle noch nicht aktuell auf Q+P, MSI Objekte noch zu bauen
--,v1.pmr_werbethema_id
,v1.referenzmarkt_fallback_fg

,v4.listung_dat_von 
,v4.listung_dat_bis
,v4a.listung_dat_bis AS listung_dat_bis_vz

,COALESCE(v1.gp_id_aenderung_fg,0) 
,COALESCE(v1.konditionsart_zar5_gueltigkeit_aenderung_fg,0) 
,COALESCE(v1.posten_kz_sap_aenderung_fg,0) 
,v1.saison_id 
,COALESCE(v1.saison_id_aenderung_fg,0)
,COALESCE(v1.best_menge_einh_id_aenderung_fg,0) 

,COALESCE(v1.rabattaenderung_fg,0) AS rabattaenderung_fg
,COALESCE(v1.abbildung_vortag_id,' ') AS abbildung_vortag_id
,COALESCE(v1.werbethema_vortag_bez,' ') AS werbethema_vortag_bez

--Dispomerkmal Markt wg. MD/RO Problematik

,COALESCE(v5.dispomerkmal,' ') AS dispomerkmal
--INC4967674 Bestimmen welcher der letzte Datensatz ist 
-- INC5107687 Nur auf ART_2 & Mandant_2 -> Letzte Eintrag pro Artikel_2 finden

,DENSE_RANK() OVER (PARTITION BY  v1.art_id, v1.mandant_id_vz ORDER BY v1.dat_beladung DESC NULLS LAST) AS rank_aktion_beladung

-- Auf Artikelebene Berechnen ob Artikel_2 komplett neu/entfernt wird 

, SUM(v1.werbeaenderung_artikelentfernung_fg) OVER (PARTITION BY v1.mandant_id_vz, v1.ART_ID, v1.aktion_id, v1.dat_beladung) AS Anzahl_artikelentfernung
, SUM(v1.werbeaenderung_artikelneuanlage_fg) OVER (PARTITION BY v1.mandant_id_vz, v1.ART_ID, v1.aktion_id, v1.dat_beladung) AS Anzahl_artikelneuanlage
--, COUNT(v1.wup_id) OVER (PARTITION BY v1.mandant_id_vz, v1.ART_ID, v1.aktion_id, v1.dat_beladung) AS Anzahl_WUP
,COUNT(DISTINCT v1.wup_id) OVER (PARTITION BY v1.art_id, v1.mandant_id, v1.dat_ab, v1.dat_bis, v1.offer_id, v1.dat_beladung) AS Anzahl_WUP
, IFF(Anzahl_artikelentfernung = Anzahl_WUP, 1, 0 ) AS artikelentfernung_art_fg
, IFF(Anzahl_artikelneuanlage = Anzahl_WUP, 1, 0 ) AS artikelneuanlage_art_fg
,CONCAT(  CASE WHEN v1.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,   
           CASE WHEN v1.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v1.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN v1.gk_fg<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v1.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,        
           CASE WHEN v1.kundenkarte_personalisiert_fg<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END, 
           CASE WHEN v7.bonuskauf_fg<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_ <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_ <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v7a.geschaeftsvorfall_bez_ <> '' THEN CONCAT ('| ', v7a.geschaeftsvorfall_bez_, ' ') ELSE '' END         
        ) AS compound_fg
, CONCAT(  CASE WHEN v1.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,
          
           CASE WHEN v1.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v1.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN v1.gk_fg<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v1.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,
           CASE WHEN v1.kundenkarte_personalisiert_fg<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END, 
           CASE WHEN v7.bonuskauf_fg<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_de <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_de, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_de <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_de, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v7a.geschaeftsvorfall_bez_de <> '' THEN CONCAT ('| ', v7a.geschaeftsvorfall_bez_de, ' ') ELSE '' END         
        ) AS compound_fg_de
, CONCAT(  CASE WHEN v1.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,
           CASE WHEN v1.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v1.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN v1.gk_fg<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v1.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,         
           CASE WHEN v1.kundenkarte_personalisiert_fg<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,          
           CASE WHEN v7.bonuskauf_fg<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_cz <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_cz, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_cz <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_cz, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v7a.geschaeftsvorfall_bez_cz <> '' THEN CONCAT ('| ', v7a.geschaeftsvorfall_bez_cz, ' ') ELSE '' END         
        ) AS compound_fg_cz
, CONCAT(  CASE WHEN v1.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,           
           CASE WHEN v1.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v1.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN v1.gk_fg<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v1.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,         
           CASE WHEN v1.kundenkarte_personalisiert_fg<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,           
           CASE WHEN v7.bonuskauf_fg<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_sk <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_sk, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_sk <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_sk, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v7a.geschaeftsvorfall_bez_sk <> '' THEN CONCAT ('| ', v7a.geschaeftsvorfall_bez_sk, ' ') ELSE '' END         
        ) AS compound_fg_sk
, CONCAT(  CASE WHEN v1.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,
           
           CASE WHEN v1.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v1.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN v1.gk_fg<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v1.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,           
           CASE WHEN v1.kundenkarte_personalisiert_fg<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,            
           CASE WHEN v7.bonuskauf_fg<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_hr <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_hr, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_hr <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_hr, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v7a.geschaeftsvorfall_bez_hr <> '' THEN CONCAT ('| ', v7a.geschaeftsvorfall_bez_hr, ' ') ELSE '' END         
        ) AS compound_fg_hr
, CONCAT(  CASE WHEN v1.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,          
           CASE WHEN v1.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v1.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN v1.gk_fg<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v1.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,         
           CASE WHEN v1.kundenkarte_personalisiert_fg<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,           
           CASE WHEN v7.bonuskauf_fg<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_pl <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_pl, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_pl<> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_pl, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v7a.geschaeftsvorfall_bez_pl <> '' THEN CONCAT ('| ', v7a.geschaeftsvorfall_bez_pl, ' ') ELSE '' END         
        ) AS compound_fg_pl
, CONCAT(  CASE WHEN v1.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,
           
           CASE WHEN v1.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v1.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN v1.gk_fg<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v1.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,
           CASE WHEN v1.kundenkarte_personalisiert_fg<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END, 
           CASE WHEN v7.bonuskauf_fg<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_ro <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_ro, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_ro <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_ro, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v7a.geschaeftsvorfall_bez_ro <> '' THEN CONCAT ('| ', v7a.geschaeftsvorfall_bez_ro, ' ') ELSE '' END         
        ) AS compound_fg_ro
, CONCAT(  CASE WHEN v1.multi_offer_id_fg<>0 THEN '| Multi-offer ' ELSE '' END,        
           CASE WHEN v1.fixmenge_fg<>0 THEN '| Fixmenge ' ELSE '' END,
           CASE WHEN v1.fixmenge_wfl_fg<>0 THEN '| Fixmenge WFL ' ELSE '' END,
           CASE WHEN v1.gk_fg<>0 THEN '| GK ' ELSE '' END,
           CASE WHEN v1.mindestplatzierung_fg<>0 THEN '| Mindestplatzierung ' ELSE '' END,
           CASE WHEN v1.kundenkarte_personalisiert_fg<>0 THEN '| Kundenkarte Personalisiert ' ELSE '' END,         
           CASE WHEN v7.bonuskauf_fg<>0 THEN '| Bonuskauf ' ELSE '' END,
           CASE WHEN v101.werbeflaechenabschnitt_wfl_bez_bg <> '' THEN CONCAT ('| ', v101.werbeflaechenabschnitt_wfl_bez_bg, ' ') ELSE '' END, 
           CASE WHEN v102.werbemittel_wfl_bez_bg <> '' THEN CONCAT ('| ', v102.werbemittel_wfl_bez_bg, ' ') ELSE '' END,
		   CASE WHEN v103.werbeflaechenthema_wfl_bez <> '' THEN CONCAT ('| ', v103.werbeflaechenthema_wfl_bez, ' ') ELSE '' END,
           CASE WHEN v7a.geschaeftsvorfall_bez_bg <> '' THEN CONCAT ('| ', v7a.geschaeftsvorfall_bez_bg, ' ') ELSE '' END         
        ) AS compound_fg_bg																							  
,COALESCE(v1.werbeaenderung_kundenkarte_personalisiert_fg,0)
,CASE WHEN z_score>8 THEN 1 ELSE 0 END AS outlier_fg
,z_score
,COALESCE(art_id_ref,-1) AS art_id_ref
,COALESCE(wup_id_ref,-1) AS wup_id_ref
,COALESCE(nb_id_ref,-1) AS nb_id_ref
,AVG(COALESCE(faktor_ref,0)) OVER (PARTITION BY v1.mandant_id_vz, v1.ART_ID, v1.aktion_id, v1.dat_beladung, v1.art_id_ref) AS faktor_ref
,v1.anz_angebote_zeitraum
,COALESCE(v1.anz_angebote_zeitraum_aenderung_fg,-1)
,COALESCE(v1.fixmenge_wfl_aenderung_fg,-1)
,COALESCE(v1.fixmenge_ek_aenderung_fg,-1)
,COALESCE(v1.wfl_menge_geprueft_fg,0)
,COALESCE(CASE WHEN v1.wfl_nutzer_kommentar_txt='-' THEN NULL ELSE v1.wfl_nutzer_kommentar_txt END,NULL)
,v5.min_sicherh_bestand
,COALESCE(v1.estimation_id,-1)
,COALESCE(v1.estimation_id_aenderung_fg,-1)
,COALESCE(v1.menge_kolliinhalt_vortag_bme,-1)
,v1.fixmenge_ek_vortag_bme
,v1.fixmenge_wfl_vortag_bme
,COALESCE(v1.vortag_aktion_reihenfolge_zukunft_nr,-1)
,COALESCE(v1.utp_relevant_aenderung_fg,-1)
,COALESCE(v1.utp_relevant_fg,-1) 
,COALESCE(v1.dat_gueltig_von_konditionsart_zar5,'1900-01-01')
,COALESCE(v1.dat_gueltig_bis_konditionsart_zar5,'1900-01-01')
,COALESCE(v1.utp_lieferant_bestaetigt_fg,-1)
,COALESCE(wfl_menge_geprueft_reset_fg,-1)
,v1.kundenkarte_personalisiert_fg
,v1.pmr_werbethema_id
,v1.bedarf_estimation_id_2_bme 
,v1.bestellmenge_estimation_id_2_ohne_bestand_ame
,v1.bestellmenge_estimation_id_2_mit_bestand_ame
,v1.kollifaktor
,v1.bonuskauf_promotionstyp_liste_txt
FROM dbp_view.v_wbs_werbeaenderungen_2 v1

INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v1.mandant_id
   
   AND v05.wup_id = v1.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

LEFT JOIN dbp_view.v_art_2 v2 
ON ( v1.mandant_id = v2.mandant_id AND v1.art_id = v2.art_id )

LEFT JOIN dbp_view.v_art_2 v3 
ON ( v1.mandant_id = v3.mandant_id AND v1.art_id_mutter = v3.art_id )

LEFT JOIN dbp_view.v_art_wup_status_per_2 v5 
ON (v1.mandant_id = v5.mandant_id AND v1.art_id = v5.art_id AND v1.wup_id = v5.wup_id AND v1.nb_id = v5.nb_id AND v1.dat_beladung BETWEEN v5.dat_von AND v5.dat_bis )

LEFT JOIN ( 
  SELECT s1.mandant_id, s1.art_id, s1.wup_id, s1.nb_id, s1.dat_ab,
    MIN(s2.dat_von) AS listung_dat_von, MAX(s2.dat_bis) AS listung_dat_bis
  FROM dbp_view.v_wbs_werbeaenderungen_2 s1
  JOIN dbp_view.v_art_list_wup_zu_per_2 s2
   ON s1.mandant_id = s2.mandant_id
   AND s2.art_id = s1.art_id
   AND s2.wup_id = s1.wup_id 
   AND s2.nb_id = s1.nb_id
   AND s2.dat_von <= s1.dat_ab 
   AND s2.dat_bis >= s1.dat_bis 
  GROUP BY s1.mandant_id, s1.art_id, s1.wup_id, s1.nb_id, s1.dat_ab ) v4
  ON v4.mandant_id = v1.mandant_id 
   AND v4.art_id = v1.art_id
   AND v4.wup_id = v1.wup_id 
   AND v4.nb_id = v1.nb_id
   AND v4.dat_ab = v1.dat_ab

LEFT JOIN ( 
  SELECT CASE WHEN s1.wup_id_vz = 6140 THEN 4 ELSE s1.mandant_id_vz END AS mandant_id_vz_, s1.art_id, s1.wup_id_vz, s1.nb_id_vz, s1.dat_ab,
    MIN(s2.dat_von) AS listung_dat_von, MAX(s2.dat_bis) AS listung_dat_bis
  FROM dbp_view.v_wbs_werbeaenderungen_2 s1
  JOIN dbp_view.v_art_list_wup_zu_per_2 s2
   ON  mandant_id_vz_ = s2.mandant_id
   AND s1.art_id = s2.art_id
   AND s1.wup_id_vz = s2.wup_id
   AND s1.nb_id_vz = s2.nb_id
   AND s1.dat_ab >= s2.dat_von 
   AND  s1.dat_bis <= s2.dat_bis
  GROUP BY mandant_id_vz_, s1.art_id, s1.wup_id_vz, s1.nb_id_vz, s1.dat_ab ) v4a
  ON CASE WHEN v1.wup_id_vz = 6140 THEN 4 ELSE v1.mandant_id_vz END = v4a.mandant_id_vz_
   AND v1.art_id = v4a.art_id
   AND v1.wup_id_vz = v4a.wup_id_vz
   AND v1.nb_id_vz = v4a.nb_id_vz 
   AND v1.dat_ab = v4a.dat_ab

LEFT JOIN dbp_view.v_pmr_angebot_art_wup_zu_2 v7 
 ON v1.mandant_id = v7.mandant_id 
   AND v1.art_id = v7.art_id
   AND v1.wup_id = v7.wup_id 
   AND v1.nb_id = v7.nb_id
   AND v1.offer_id  = v7.angebot_id
   
LEFT JOIN geschaeftsvorfall_spr v7a
   ON v7.mandant_id = v7a.mandant_id 
   AND v7.bonuskauf_geschaeftsvorfall_id = v7a.geschaeftsvorfall_id
  
LEFT JOIN (SELECT v10.angebot_id, v10.mandant_id 
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_,'| ') AS werbeflaechenabschnitt_wfl_bez_
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_de,'| ') AS werbeflaechenabschnitt_wfl_bez_de
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_cz,'| ') AS werbeflaechenabschnitt_wfl_bez_cz
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_sk,'| ') AS werbeflaechenabschnitt_wfl_bez_sk
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_hr,'| ') AS werbeflaechenabschnitt_wfl_bez_hr
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_pl,'| ') AS werbeflaechenabschnitt_wfl_bez_pl
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_ro,'| ') AS werbeflaechenabschnitt_wfl_bez_ro
, LISTAGG(DISTINCT v10a.werbeflaechenabschnitt_wfl_bez_bg,'| ') AS werbeflaechenabschnitt_wfl_bez_bg

FROM
dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu_2 v10
     
  JOIN werbeflaechenabschnitt_spr v10a
    ON  TRIM(REGEXP_SUBSTR(v10.werbeflaeche_abschnitt_name, '^[^\\(]+'))= v10a.werbeflaechenabschnitt_name
  
  GROUP BY v10.angebot_id, v10.mandant_id
)v101
ON v1.mandant_id = v101.mandant_id 
   AND v1.offer_id  = v101.angebot_id
   
LEFT JOIN (SELECT v10.angebot_id, v10.mandant_id 
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_ ,'| ') AS werbemittel_wfl_bez_
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_de ,'| ') AS werbemittel_wfl_bez_de
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_cz ,'| ') AS werbemittel_wfl_bez_cz
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_sk ,'| ') AS werbemittel_wfl_bez_sk
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_hr ,'| ') AS werbemittel_wfl_bez_hr
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_pl ,'| ') AS werbemittel_wfl_bez_pl
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_ro ,'| ') AS werbemittel_wfl_bez_ro
, LISTAGG(DISTINCT v10b.werbemittel_wfl_bez_bg ,'| ') AS werbemittel_wfl_bez_bg

FROM
dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu_2 v10
     
  JOIN werbemittel_spr v10b
   ON v10.werbemittel_art_id = v10b.werbemittelkanal_id
   AND v10.werbemittel_id = v10b.werbemittel_id  
  
  GROUP BY v10.angebot_id, v10.mandant_id
)v102
ON v1.mandant_id = v102.mandant_id 
   AND v1.offer_id  = v102.angebot_id
   
LEFT JOIN (SELECT v10.angebot_id, v10.mandant_id 
, LISTAGG(DISTINCT v10c.werbeflaechenthema_wfl_bez,'| ') AS werbeflaechenthema_wfl_bez

FROM
dbp_view.v_pmr_angebot_werbemittel_werbeflaeche_zu_2 v10
   JOIN dbp_view.v_l_werbeflaechenthema_2 v10c
   ON  v10.mandant_id = v10c.mandant_id
   AND v10.werbeflaeche_thema_id = v10c.werbeflaechenthema_cd
  GROUP BY v10.angebot_id, v10.mandant_id
)v103
ON v1.mandant_id = v103.mandant_id 
   AND v1.offer_id  = v103.angebot_id
 
LEFT JOIN ( SELECT v8a.kjwo, v8a.dat_ab, v8a.dat_bis, v8a.dat_beladung, v8a.wup_id,v8a.nb_id,v8a.art_id, v8a.mandant_id, NULLIFZERO(MEDIAN(v8a.diff_1) OVER (PARTITION BY v8a.mandant_id, v8a.art_id, v8a.kjwo, v8a.dat_beladung)) AS median_2 ,  0.6745 * v8a.diff_1 AS zaehler , zaehler / median_2 AS z_score 
           FROM(
                    SELECT 
                    kjwo, 
                    wup_id,
                    mandant_id,
                    nb_id,
                    art_id,
                    dat_beladung,
                    dat_ab,
                    dat_bis,
                    prognose_werbezeitraum_bme,
                    MEDIAN(prognose_werbezeitraum_bme) OVER (PARTITION BY mandant_id, art_id, kjwo, dat_beladung) AS median_1,
                    ABS(prognose_werbezeitraum_bme-median_1) AS diff_1 
                    FROM dbp_view.v_wbs_werbeaenderungen_2
                    WHERE prognose_werbezeitraum_bme>0) v8a
           )v8
           ON  v8.kjwo = v1.kjwo
           AND v8.dat_ab = v1.dat_ab
           AND v8.dat_bis = v1.dat_bis
           AND v8.wup_id = v1.wup_id
           AND v8.nb_id = v1.nb_id
           AND v8.art_id =v1.art_id
           AND v8.mandant_id = v1.mandant_id 
           AND v8.dat_beladung = v1.dat_beladung

LEFT JOIN dbp_view.v_werbewoche_kl_2 v9
ON v1.mandant_id = v9.mandant_id
AND v1.dat_ab = v9.dat

--WHERE v1.dat_beladung >= CURRENT_DATE - 140 
WHERE (v1.dat_beladung >= CURRENT_DATE - 140 AND v1.mandant_id = 6) OR (v1.dat_beladung >= CURRENT_DATE - 60 AND v1.mandant_id <> 6) 

;
