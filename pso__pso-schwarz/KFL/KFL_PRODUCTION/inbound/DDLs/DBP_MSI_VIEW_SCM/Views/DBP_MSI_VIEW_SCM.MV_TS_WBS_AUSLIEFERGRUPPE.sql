create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_TS_WBS_AUSLIEFERGRUPPE(
	MANDANT_ID,
	AUSLIEFERGRUPPE_ID,
	AUSLIEFERGRUPPE_CLUSTER_ID,
	FAKTOR_REST_VON_NORMALBESTAND,
	BERECHNUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ,
	BERECHNUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ,
	BERECHNUNG_KOLLI_RUNDUNG_PROZ,
	NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ,
	NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ,
	NACHVERSORGUNG_KOLLI_RUNDUNG_PROZ,
	FAKTOR_MAX_KAPA_ENDBESTAND,
	FAKTOR_BESTAND_BETRACHTUNG,
	ERWEITERUNG_BEDARFSHORIZONT_TAGE,
	MENGE_ZIELENDBESTAND_SCHWELLWERT_AME
) as







SELECT 
	v01.mandant_id
    ,v01.ausliefergruppe_id
    ,v01.ausliefergruppe_cluster_name AS ausliefergruppe_cluster_id
    ,MAX(v01.REST_VON_NORMALBESTAND_PROZ) AS faktor_rest_von_normalbestand
    ,MAX(v01.berechnung_schwellwert_pal_abrundung_proz) AS schwellwert_pal_abrundung_proz
    ,MAX(v01.berechnung_schwellwert_pal_aufrundung_proz) AS schwellwert_pal_aufrundung_proz
    ,MAX(v01.berechnung_kolli_rundung_proz) AS kolli_rundung_proz
    ,MAX(v01.nachversorgung_schwellwert_pal_abrundung_proz) AS nachversorgung_schwellwert_pal_abrundung_proz
    ,MAX(v01.nachversorgung_schwellwert_pal_aufrundung_proz) AS nachversorgung_schwellwert_pal_aufrundung_proz
    ,MAX(v01.nachversorgung_kolli_rundung_proz) AS nachversorgung_kolli_rundung_proz
    ,MAX(v01.MAX_KAPA_ENDBESTAND_PROZ) AS faktor_max_kapa_endbestand
    
    ,MAX(v01.BESTAND_BETRACHTUNG_PROZ) AS faktor_bestand_betrachtung
    
    
    
    
    
    
    ,MAX(erweiterung_bedarfshorizont_tage) AS erweiterung_bedarfshorizont_tage 
    ,MAX(menge_zielendbestand_schwellwert_ame) AS zielendbestand_schwellwert_ame
    






































FROM DBP_VIEW.v_ts_wbs_ausliefergruppe v01


GROUP BY 	
	v01.mandant_id
    ,v01.ausliefergruppe_id
    ,v01.ausliefergruppe_cluster_name;
