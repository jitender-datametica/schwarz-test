create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WUP(
	MANDANT_ID,
	NB_ID,
	HAUPT_WUP_ID,
	LAND_ID,
	WUP_ID,
	ORIG_WUP_ID,
	WUP_STANDORT,
	DAT_EROEFFNUNG,
	DAT_VON,
	DAT_BIS,
	DAT_GESCHLOSSEN,
	DAT_WIEDEREROEFFNUNG,
	DAT_STECKBRIEF,
	WUP_ID_ALT,
	DAT_UMZUG,
	WUP_AENDERUNG_GRUND_ID,
	DAT_UMGLIEDERUNG,
	DAT_LETZTE_MODERNISIERUNG_VON,
	DAT_LETZTE_MODERNISIERUNG_BIS,
	DAT_LETZTE_MODERNISIERUNG_VON2,
	DAT_LETZTER__FACELIFT_VON,
	DAT_LETZTER_FACELIFT,
	DUMMY,
	VS_ID,
	GF_ID,
	VKL_ID,
	WM_ID,
	HL_ID,
	VW_ID,
	VF_ID,
	REGION_ID,
	WUP_STR,
	WUP_PLZ,
	WUP_STADT,
	WUP_TELEFON,
	WUP_TELEFAX,
	BETRIEBSRAT_FG,
	BUCHUNGSKREIS_ID,
	VAUS_WUP_NAME,
	AUFLAGE_WUP_VERTEILGEBIET,
	AUFLAGE_WUP_AUSLAGE,
	NILS_VERTEILGEBIET_ID,
	VERTEILGEBIET_UID,
	AUFLAGE_VERTEILGEBIET,
	GLN_ID,
	KUNDE_ID,
	UMSATZ_ERWARTUNG_EUR,
	EINWOHNER_ANZAHL,
	EIGENTUM_MIETE_KZ,
	VERKAUFSFLAECHE,
	BETRIEBSFLAECHE,
	UEBERNAHME_VON,
	UEBERNAHME_REAL,
	UMSATZ_EA,
	UMSATZ_WOCHE,
	UMSATZ_EA_EUR,
	UMSATZ_EA_LAND,
	KUNDENFAKTOR,
	GETRAENKEMARKT_FG,
	GETRAENKE_MARKT_FG,
	DAT_QBM_UMSTELLUNG,
	QBM_ID,
	DAT_UMSTELLUNG_WAAGE,
	BREITENGRAD,
	LAENGENGRAD,
	GIS_QUALI_ID,
	VDAT,
	EDAT,
	SDAT,
	GJ_EROEFFNUNG,
	GJ_SCHLIESSUNG,
	KJMO_EROEFFNUNG,
	KJMO_SCHLIESSUNG,
	KJMO_UMZUG,
	PREISKATEGORIE_FOOD,
	PREISKATEGORIE_NONFOOD,
	SORTKATEGORIE_FOOD,
	SORTKATEGORIE_NONFOOD,
	WUP_TYP_ID,
	WUP_NAME_V,
	WUP_NAME_E,
	LEAD_MWST,
	BREAKEVENUMSATZ,
	SYSTEMRENTABILITAET,
	FLEISCHSYSTEM,
	SONDERMARKT,
	REF_WUP_ID,
	KASSENTYP,
	VZ_WUP_ID,
	VERKAUFSORGANISATION_ID,
	BEWERTUNGSKREIS_ID,
	KREISTYP_GRUPPE_ID,
	FILIALTYP_ID,
	ETAGEN_ANZ,
	VAUS_WUP_STADT,
	SYSTEM_ID
) as 




























 
SELECT
  v01.mandant_id
, v01.nb_id
, CASE 
	WHEN v01.nb_id = -1 AND v01.vs_id = 1 THEN  43 
	WHEN v01.nb_id = -1 AND v01.vs_id = 2 THEN  22 
	WHEN v01.nb_id = -1 AND v01.vs_id = 3 THEN  46 
	WHEN v01.nb_id = -1 AND v01.vs_id = 6 THEN 124 
	WHEN v01.nb_id = -1 AND v01.vs_id = 7 THEN   2 
	WHEN v01.nb_id = -1 AND v01.vs_id = 8 THEN  28 
	WHEN v01.nb_id = -1 THEN 0 
	ELSE COALESCE(v01.haupt_wup_id, v01.wup_id) 
  END AS haupt_wup_id
, v01.land_id       
, v01.wup_id        
, v01.orig_wup_id    
, v01.wup_standort  
, COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung)                           AS dat_eroeffnung       
, COALESCE(v01.dat_von_alt, v01.dat_von)                                         AS dat_von              
, v01.dat_bis                                                                    AS dat_bis         
, CASE WHEN v01.dat_bis < (CURRENT_DATE + 1) THEN v01.dat_bis ELSE NULL END      AS dat_geschlossen 
, v01.dat_wiedereroeffnung                                                       AS dat_wiedereroeffnung 
, COALESCE(v01.dat_wiedereroeffnung, v01.dat_eroeffnung_alt, v01.dat_eroeffnung) AS dat_steckbrief  
 

, v01.wup_id_alt                                                            
, CASE WHEN v01.wup_id_alt > 1 THEN v01.dat_eroeffnung END AS dat_umzug 
 

, v01.wup_aenderung_grund_id 
, CASE WHEN v01.wup_id <> v01.orig_wup_id THEN v01.dat_eroeffnung END AS dat_umgliederung 
 

, v01.dat_letzte_modernisierung_von 
, v01.dat_letzte_modernisierung_bis 
, COALESCE(v01.dat_letzte_modernisierung_von, v01.dat_letzte_modernisierung_bis) AS dat_letzte_modernisierung_von2 
, v01.dat_letzter__facelift_von 
, v01.dat_letzter_facelift      
 

, ((1000 + v01.mandant_id * 100 + v01.vs_id * 10)) * -1::INTEGER AS DUMMY 
, CASE WHEN v01.vs_id >= 0 THEN v01.vs_id  ELSE 0     END AS vs_id 
, CASE WHEN v01.gf_id > 0  THEN v01.gf_id  ELSE DUMMY END AS gf_id 
, CASE WHEN v01.vkl_id > 0 THEN v01.vkl_id ELSE DUMMY END AS vkl_id 
, CASE WHEN v01.wm_id > 0  THEN v01.wm_id  ELSE DUMMY END AS wm_id 
, CASE WHEN v01.hl_id > 0  THEN v01.hl_id  ELSE DUMMY END AS hl_id
, v01.vw_id
, v01.vf_id
 

, COALESCE(v03.region_id, v01.region_id, -v01.mandant_id) AS region_id
, COALESCE(v03.wup_str, v01.wup_str, '')                  AS wup_str
, COALESCE(v03.wup_plz, v01.wup_plz)                      AS wup_plz
, COALESCE(v03.wup_stadt_1, v01.wup_stadt, '')            AS wup_stadt
, COALESCE(v03.wup_telefon, '')                           AS wup_telefon
, COALESCE(v03.wup_fax, '')                               AS wup_telefax
, COALESCE(v03.betriebsrat_fg, -1)                        AS betriebsrat_fg
, COALESCE(v03.buchungskreis_id, -1)                      AS buchungskreis_id
, COALESCE(v03.wup_name_1, '')                            AS vaus_wup_name
, v03.auflage_wup_verteilgebiet
, v03.auflage_wup_auslage
, v03.nils_verteilgebiet_id
, v04.verteilgebiet_uid
, SUM(v03.auflage_wup_verteilgebiet) OVER (PARTITION BY v01.mandant_id, v03.nils_verteilgebiet_id ORDER BY v01.mandant_id, v03.nils_verteilgebiet_id, v01.wup_id) AS auflage_verteilgebiet
, v03.gln_id
, v03.kunde_id
 
 
, v01.umsatz_erwartung_eur 
, v01.einwohner_anzahl     
, COALESCE(v01.eigentum_miete_kz,'')  AS eigentum_miete_kz
, v01.verkaufsflaeche
, v01.betriebsflaeche
, v01.uebernahme_von
, CASE WHEN SUBSTR( uebernahme_von, 1, 8) = 'real 202' THEN 'Real' ELSE 'Bestand' END AS uebernahme_real
, (v01.umsatz_ea_eur/1000)::INTEGER  AS umsatz_ea    
, (v01.umsatz_ea_eur/53000)::INTEGER AS umsatz_woche 
, v01.umsatz_ea_eur  
, v01.umsatz_ea_land 
, v01.kundenfaktor
, v01.getraenkemarkt_fg 
, CASE WHEN v01.kundenfaktor < 1.000 THEN 1 ELSE 0 END AS getraenke_markt_fg
, v01.dat_qbm_umstellung
, v01.qbm_id
, v01.dat_umstellung_waage
, v01.breitengrad  
, v01.laengengrad  
, v01.gis_quali_id 
 

, COALESCE(v01.dat_von_alt, v01.dat_von) AS VDAT
, COALESCE(v01.dat_eroeffnung_alt, v01.dat_eroeffnung) AS EDAT
, v01.dat_bis AS SDAT
, CASE WHEN EDAT <= CURRENT_DATE THEN YEAR(EDAT) + CASE WHEN MONTH(EDAT) < 3 THEN -1 ELSE 0 END ELSE 0 END AS gj_eroeffnung
, CASE WHEN SDAT <= CURRENT_DATE THEN YEAR(SDAT) + CASE WHEN MONTH(SDAT) < 3 THEN -1 ELSE 0 END ELSE 0 END AS gj_schliessung
, CASE WHEN EDAT <= CURRENT_DATE THEN YEAR(EDAT)*100 + MONTH(EDAT) ELSE 0 END::INTEGER AS kjmo_eroeffnung
, CASE WHEN SDAT <= CURRENT_DATE THEN YEAR(SDAT)*100 + MONTH(SDAT) ELSE 0 END::INTEGER AS kjmo_schliessung
, CASE WHEN v01.wup_id_alt > 1 THEN YEAR(v01.dat_eroeffnung) * 100 + MONTH(v01.dat_eroeffnung) ELSE 0 END::INTEGER AS kjmo_umzug
 

, v01.preiskategorie_food
, v01.preiskategorie_nonfood
, v01.sortkategorie_food
, v01.sortkategorie_nonfood
, v01.wup_typ_id
, v01.wup_name_v
, v01.wup_name_e
, v01.lead_mwst
, v01.breakevenumsatz
, v01.systemrentabilitaet
, v01.fleischsystem
, v01.sondermarkt
, v01.ref_wup_id
, v01.kassentyp
, v01.vz_wup_id
, v01.verkaufsorganisation_id
, v01.bewertungskreis_id
, v01.kreistyp_gruppe_id
, v01.filialtyp_id
, v01.etagen_anz
, v03.wup_stadt_1 AS vaus_wup_stadt
, v03.system_id
FROM dbp_view.v_wup  v01
 

LEFT JOIN dbp_view.v_vaus_wup  v03
ON v01.wup_id = v03.wup_id
AND v01.mandant_id = v03.mandant_id
 

LEFT JOIN dbp_view.v_geku_verteilgebiet v04
ON v03.nils_verteilgebiet_id = v04.nils_verteilgebiet_id
AND v03.mandant_id = v04.mandant_id
 
WHERE v01.nb_id IN (-2, -1, 0, 2, 7)  
AND v01.dat_von > '1900-01-01' AND v01.dat_eroeffnung > '1900-01-01'  
AND v01.umzugsfiliale_fg = 0 
AND v01.wup_id = v01.aktuell_wup_id 
;
