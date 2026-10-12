create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_LAGERPLATZ_EWM_TAG(
	MANDANT_ID,
	LAGERNUMMER_ID,
	LAGERPLATZ_ID,
	LAGERTYP_ID,
	LAGERBEREICH_ID,
	LAGERPLATZTYP_ID,
	LAGERPLATZ_ZUGRIFFSTYP_ID,
	LAGERPLATZ_AUFTEILUNG_ID,
	LAGERPLATZ_POSITION,
	AUSLAGERUNG_SPERR_FG,
	EINLAGERUNG_SPERR_FG,
	INVENTUR_BLOCK_FG,
	AUFGETEILT_FG,
	ANZ_HU,
	ANZ_HU_MAX,
	GEWICHT_MAX,
	GEW_EINH_ID,
	GEWICHT,
	VOLUMEN_NETTO,
	VOLUMEN_MAX,
	VOL_EINH_ID,
	KAPA_MAX,
	KAPA_FREI,
	LEER_FG,
	VOLL_FG,
	DAT_ERSTE_EINLAGERUNG,
	DATZEIT_LETZTE_BEWEGUNG,
	LAGERAUFGABE_ID_LETZTE_BEW,
	BRANDABSCHNITT_ID,
	DATZEIT_AENDERUNG,
	HAUPT_LAGERPLATZ_ID,
	LOC_GUID,
	HANDLING_UNIT_GUID,
	GANG_ID,
	SAEULE_ID,
	EBENE_ID,
	X_KOORDINATE,
	Y_KOORDINATE,
	Z_KOORDINATE,
	LAGERNEREICH_LGST_ID,
	FELDTYP_ID,
	REGALTYP_ID,
	WA_LANE_KAPA,
	WE_LANE_KAPA,
	KAPA_ERH_FG,
	DAT,
	TIEFE_MAX,
	TIEFE_MAX_FG,
	ANZ_LAGERPLAETZE_GESAMT,
	ANZ_LAGERPLAETZE_BELEGT
) as
 
 
SELECT
v01.mandant_id,
v01.lagernummer_id,
v01.lagerplatz_id,
v01.lagertyp_id,
v01.lagerbereich_id,
v01.lagerplatztyp_id,
v01.lagerplatz_zugriffstyp_id,
v01.lagerplatz_aufteilung_id,
v01.lagerplatz_position,
v01.auslagerung_sperr_fg,
v01.einlagerung_sperr_fg,
v01.inventur_block_fg,
v01.aufgeteilt_fg,
v01.anz_hu,
v01.anz_hu_max,                                           
v01.gewicht_max,
v01.gew_einh_id,
v01.gewicht,
v01.volumen_netto,
v01.volumen_max,
v01.vol_einh_id,
v01.kapa_max,
v01.kapa_frei,
v01.leer_fg,
v01.voll_fg,
v01.dat_erste_einlagerung,
v01.datzeit_letzte_bewegung,
v01.lageraufgabe_id_letzte_bew,
v01.brandabschnitt_id,
v01.datzeit_aenderung,
v01.haupt_lagerplatz_id,
v01.loc_guid,
v01.handling_unit_guid,
v01.gang_id,
v01.saeule_id,
v01.ebene_id,
v01.x_koordinate,
v01.y_koordinate,
v01.z_koordinate,
v01.lagernereich_lgst_id,
v01.feldtyp_id,
v01.regaltyp_id,
v01.wa_lane_kapa,
v01.we_lane_kapa,
v01.kapa_erh_fg,
v01.dat,
v01.tiefe_max,
CASE WHEN COALESCE(v01.tiefe_max,1) >= 2 THEN tiefe_max ELSE 1 END AS tiefe_max_fg,
CASE WHEN RIGHT(v01.lagertyp_id,3) = 'RLP' AND (v01.lagerplatz_position IS NULL OR v01.haupt_lagerplatz_id IS NULL) THEN RIGHT(v01.lagerplatztyp_id,1)::NUMBER
    WHEN RIGHT(v01.lagertyp_id,3) = 'RLP' THEN 0 
    WHEN tiefe_max_fg = 2 THEN  2 
    ELSE 1 END AS anz_lagerplaetze_gesamt,
CASE WHEN RIGHT(v01.lagertyp_id,3) = 'RLP' AND (v01.lagerplatz_position IS NULL OR v01.haupt_lagerplatz_id IS NULL) THEN
    CASE WHEN RIGHT(v01.lagerplatztyp_id,1) = 2 AND v01.anz_hu_max = 0 AND v01.anz_hu = 0 THEN 0
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 2 AND v01.anz_hu_max = 1 AND v01.anz_hu = 1 THEN 2
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 2 AND v01.anz_hu_max = 2 AND v01.anz_hu = 2 THEN 2
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 2 AND v01.anz_hu_max = 2 AND v01.anz_hu = 1 THEN 1
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 4 AND v01.anz_hu_max = 0 AND v01.anz_hu = 0 THEN 0
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 4 AND v01.anz_hu_max = 2 AND v01.anz_hu = 2 THEN 4
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 4 AND v01.anz_hu_max = 2 AND v01.anz_hu = 1 THEN 2
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 4 AND v01.anz_hu_max = 4 AND v01.anz_hu = 1 THEN 1
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 4 AND v01.anz_hu_max = 4 AND v01.anz_hu = 2 THEN 2
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 4 AND v01.anz_hu_max = 4 AND v01.anz_hu = 3 THEN 3
         WHEN RIGHT(v01.lagerplatztyp_id,1) = 4 AND v01.anz_hu_max = 4 AND v01.anz_hu = 4 THEN 4   
     END 
     WHEN RIGHT(v01.lagertyp_id,3) = 'RLP' THEN 0
     ELSE (CASE WHEN v01.lagertyp_id LIKE '%G%' AND v01.leer_fg=0 THEN 1 ELSE 0 END) + (CASE WHEN v01.leer_fg=0 THEN v01.anz_hu ELSE 0 END) 
END  AS anz_lagerplaetze_belegt
FROM dbp_view.v_lagerplatz_ewm_tag v01
WHERE NOT (RIGHT(v01.lagertyp_id,3) = 'RLP' AND v01.lagerplatz_id LIKE '%/%') ;
