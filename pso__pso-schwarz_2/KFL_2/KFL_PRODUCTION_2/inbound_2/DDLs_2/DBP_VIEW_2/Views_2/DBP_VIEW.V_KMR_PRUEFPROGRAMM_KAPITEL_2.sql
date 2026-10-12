create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL_2(
	AMX_SYSTEM_ID,
	KAPITEL_ID,
	KAPITEL_BEZ,
	KAPITEL_TYP_ID,
	PRUEFUNG_ID,
	KAPITEL_NR,
	SORT_NR,
	FEHLERVERDACHT_FG,
	GEPR_PROZESS_ID,
	ERGEBNIS,
	ERGEBNIS_BERECHNET,
	ERGEBNIS_MANUELL
) as 
    SELECT 
        amx_system_id
        ,kapitel_id
        ,kapitel_bez
        ,kapitel_typ_id
        ,pruefung_id
        ,kapitel_nr
        ,sort_nr
        ,fehlerverdacht_fg
        ,gepr_prozess_id
        ,ergebnis
        ,ergebnis_berechnet
        ,ergebnis_manuell


FROM DBP_DATA.KMR_PRUEFPROGRAMM_KAPITEL_2 ;
