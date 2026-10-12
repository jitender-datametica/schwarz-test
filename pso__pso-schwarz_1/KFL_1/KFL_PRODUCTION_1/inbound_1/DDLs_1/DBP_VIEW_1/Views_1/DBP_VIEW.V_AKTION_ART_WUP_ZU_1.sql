create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_AKTION_ART_WUP_ZU_1(
	MANDANT_ID,
	AKTION_ID,
	ART_ID,
	BEWART_ID,
	WUP_ID,
	NB_ID,
	VK_AKTION_BRUTTO,
	WRG_ID,
	BEZUGSWEG_ID,
	GRUND_SPERRUNG,
	DAT_SPERRUNG,
	AKTION_THEMA_ID,
	VK_VOR_AKTION_BRUTTO,
	VOR_AKTION_WRG_ID,
	DAT_PREISAKTIVIERT,
	GELOESCHT_SAP_FG,
	DAT_GELOESCHT_SAP
) as 
    SELECT 
        mandant_id
        ,aktion_id
        ,art_id
        ,bewart_id
        ,wup_id
        ,nb_id
        ,vk_aktion_brutto
        ,wrg_id
        ,bezugsweg_id
        ,grund_sperrung
        ,dat_sperrung
        ,aktion_thema_id
        ,vk_vor_aktion_brutto
        ,vor_aktion_wrg_id
        ,dat_preisaktiviert
        ,geloescht_sap_fg
        ,dat_geloescht_sap


FROM DBP_DATA.aktion_art_wup_zu_1 ;
