create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_PMR_ANGEBOT_ART_WUP_ZU_2(
	DAT_BELADUNG,
	MANDANT_ID,
	OFFER_ID,
	ANGEBOT_ID,
	ART_ID,
	NB_ID,
	WUP_ID,
	NB_ID_VZ,
	WUP_ID_VZ,
	VERKAUFSORGANISATION_ID,
	DAT_VON,
	DAT_BIS,
	PREIS_AKTION,
	PREIS_NORMAL,
	PREIS_NACHLASS_PERC,
	BESTAND_BME,
	MINDESTMENGE_BME,
	MAXIMALMENGE_BME,
	NIS_FG,
	AKTION_ID,
	AKTION_ID_PMR,
	MASTERBONUS_FG,
	GONDELKOPF_FG,
	TOPARTIKEL_FG,
	PMR_WERBETHEMA_ID,
	PMR_WERBETHEMA_BESCHREIBUNG,
	BONUSKAUF_ANREIZTYP,
	BONUSKAUF_GESCHAEFTSVORFALL_ID,
	BONUSKAUF_KONDITIONSART_ID,
	BONUSKAUF_LIMIT,
	BONUSKAUF_FG,
	BONUSKAUF_BEDINGUNG_ID,
	BONUSKAUF_DIMENSION_ID,
	BONUSKAUF_PRODUKTGRUPPENNAME,
	BONUSKAUF_BONUSMENGE,
	BONUSKAUF_KAUFMENGE,
	BONUSKAUF_MINDESTBETRAG,
	BONUSKAUF_RABATTTYPE_ID,
	BONUSKAUF_PRODUKTVARIANTE_ID,
	BONUSKAUF_RABATT_PERC,
	BONUSKAUF_RABATT_ZUORDNUNG_ID,
	BONUSKAUF_PROMOTIONSTYP,
	MULTI_OFFER_ID_FG,
	MANDANT_ID_VZ,
	KJWO,
	KJWO_WW,
	AUSLIEFERGRUPPE_ID,
	WERBEAENDERUNG_ARTIKELNEUANLAGE_FG,
	WERBEAENDERUNG_ARTIKELENTFERNUNG_FG,
	PREIS_NIEDRIGSTER,
	PREIS_NIEDRIGSTER_DIFF_PERC,
	OPV_PROSPEKT_FG,
	OPV_MARKT_FG,
	STIMMUNG_FG,
	PREISHAMMER_FG,
	EK_ART_ID_REF,
	TOP5_FG
) as 























SELECT DISTINCT
	v01.DAT_BELADUNG
	,v01.MANDANT_ID
    ,v01.OFFER_ID
	,TRY_CAST(v02.ANGEBOT_NR AS NUMBER)
	,v01.ART_ID
	,v01.NB_ID
	 ,v05.aktuell_wup_id  
    ,NB_ID_VZ
	,WUP_ID_VZ
	,v02.VERKAUFSORGANISATION_ID
	,a.dat_angebot_gueltig_von
	,a.dat_angebot_gueltig_bis
	
	
    
    ,v01.preis_aktion
    ,v01.preis_normal
	,v01.preis_nachlass_perc
	,aa.BESTAND_BME 
	,aa.MINDESTMENGE_BME 
	,aa.MAXIMALMENGE_BME 
	,v02.ART_NIS_FG
	,v01.AKTION_ID
    ,a.AKTION_ID AS AKTION_ID_PMR
	,aa.MASTERBONUS_FG 
	,aa.GONDELKOPF_FG 
	,aa.TOPARTIKEL_FG 
	,w.WERBETHEMA_ID		
	,w.WERBETHEMA_BEZ AS WERBETHEMA_BEZ
	,a.AKTION_TYP_ID
	,a.GESCHAEFTSVORFALL_ID
	,a.KONDITIONSART_ID
	,a.ANZ_ANGEBOT_LIMIT
	,a.BONUSKAUF_FG
	,0 AS BONUSKAUF_BEDINGUNG_ID 
	,0 AS BONUSKAUF_DIMENSION_ID 
	,v02.ART_WERBE_PROD_GRUPPE_NAME
	,v02.ANZ_BONUSKAUF_GRATIS AS BONUSKAUF_BONUSMENGE 
	,v02.ANZ_BONUSKAUF_KAUF  AS BONUSKAUF_KAUFMENGE
	,v02.MENGE_BONUSKAUF_MIN
	,v02.RABATT_TYP_ID
	,0 AS BONUSKAUF_PRODUKTVARIANTE_ID 
	,v02.PROZ_BONUSKAUF_RABATT 
	,0 AS BONUSKAUF_RABATT_ZUORDNUNG_ID 
    ,a.ANGEBOT_TYP_CD
    ,v01.MULTI_OFFER_ID_FG   
    ,CASE WHEN v01.wup_id_vz = 6140 THEN 4 ELSE v01.mandant_id_vz END AS MANDANT_ID_VZ
    ,v01.kjwo
    ,v09.kjwo_ww
    ,COALESCE(v01.ausliefergruppe_id,' ') AS ausliefergruppe_id
    ,v01.werbeaenderung_artikelneuanlage_fg 
,v01.werbeaenderung_artikelentfernung_fg
,0 AS preis_niedrigster
,0 AS preis_niedrigster_diff_perc
,v02.opv_prospekt_fg
,v02.opv_markt_fg
,aa.stimmung_fg 
,aa.preishammer_fg 
,aa.ek_art_id_ref 
,CASE WHEN d01.dat_beladung IS NOT NULL THEN 1 ELSE 0 END AS top5_fg
FROM  DBP_VIEW.V_WBS_WERBEAENDERUNGEN_2 v01

LEFT JOIN dbp_msi_view_scm.MV_WBS_TOP5_DAT_BELADUNG_2 d01
ON v01.dat_beladung = d01.dat_beladung

INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id

   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

LEFT JOIN dbp_view.v_werbewoche_kl_2 v09
ON v01.mandant_id = v09.mandant_id
AND v01.dat_ab = v09.dat

JOIN DBP_VIEW.V_ANGEBOT_ART_WUP_ZU_2 v02 
ON v01.OFFER_ID = TRY_CAST(v02.ANGEBOT_NR AS NUMBER)
		AND v01.ART_ID = v02.ART_ID
		AND v01.WUP_ID = v02.WUP_ID
		AND v01.MANDANT_ID = v02.MANDANT_ID
JOIN DBP_VIEW.V_ANGEBOT_2 A
 ON A.ANGEBOT_NR=v02.ANGEBOT_NR 
AND A.mandant_id=v02.mandant_id 
AND a.angebot_geloescht_fg=0
AND v01.DAT_AB = a.dat_angebot_gueltig_von
AND v01.DAT_BIS =  a.dat_angebot_gueltig_bis
     
LEFT JOIN DBP_DATA.angebot_werbemittel_promotion_event_zu_2 W 
ON A.ANGEBOT_NR=w.ANGEBOT_NR AND A.mandant_id=w.mandant_id
AND (w.werbemittelkanal_bez <> 'keine Information verfügbar' OR  w.werbethema_bez <> '' OR w.werbeflaechenabschnitt_name <> '')

LEFT JOIN 
 ( SELECT mandant_id , angebot_nr,
 MAX(CASE WHEN angebot_attribut_id = 44 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS BESTAND_BME
,MAX(CASE WHEN angebot_attribut_id = 42 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS MINDESTMENGE_bme
,MAX(CASE WHEN angebot_attribut_id = 43 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS MAXIMALMENGE_BME
,MAX(CASE WHEN angebot_attribut_id = 41 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS MASTERBONUS_FG 
,MAX(CASE WHEN angebot_attribut_id = 49 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS GONDELKOPF_FG 
,MAX(CASE WHEN angebot_attribut_id = 47 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS stimmung_fg
,MAX(CASE WHEN angebot_attribut_id = 48 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS preishammer_fg 
,MAX(CASE WHEN angebot_attribut_id = 53 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS ek_art_id_ref
,MAX(CASE WHEN angebot_attribut_id = 46 THEN TRY_CAST (angebot_attribut_txt AS NUMBER) END) AS topartikel_fg
FROM dbp_Data.angebot_attribut_zu_2 WHERE angebot_attribut_id BETWEEN 40 AND 53
GROUP BY 1,2) aa ON A.ANGEBOT_NR=aa.ANGEBOT_NR AND A.mandant_id=aa.mandant_id

WHERE v01.dat_beladung >= CURRENT_DATE - 140

;
