create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_LAGERPLATZ_EWM_STUNDE(
	LAGERPLATZ_ID,
	LAGERNUMMER_ID,
	MANDANT_ID,
	LAGERTYP_ID,
	LAGERBEREICH_ID,
	EINLAGERUNG_SPERR_FG,
	AUSLAGERUNG_SPERR_FG,
	GANG_ID,
	SAEULE_ID,
	EBENE_ID,
	BRANDABSCHNITT_ID,
	LAGERPLATZTYP_ID,
	KAPA_MAX,
	GEWICHT_MAX,
	LEER_FG,
	DAT_ZEIT,
	DAT,
	STUNDE,
	WA_LANE_KAPA,
	ANZ_HU,
	TIEFE_MAX,
	TIEFE_MAX_FG,
	ANZ_LAGERPLAETZE_GESAMT,
	ANZ_LAGERPLAETZE_BELEGT
) as
 
  
SELECT
v01.lagerplatz_id,
v01.lagernummer_id,
v01.mandant_id,
v01.lagertyp_id,
v01.lagerbereich_id,
v01.einlagerung_sperr_fg,
v01.auslagerung_sperr_fg,
v01.gang_id,
v01.saeule_id,
v01.ebene_id,
CAST(COALESCE(v01.brandabschnitt_id,'-1') AS CHAR(2)) AS brandabschnitt_id,
v01.lagerplatztyp_id,
v01.kapa_max,
v01.gewicht_max,
v01.leer_fg,
v02.dat_zeit,
v02.dat,
v02.stunde,
v01.wa_lane_kapa,
v01.anz_hu,
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
FROM dbp_view.v_lagerplatz_ewm_per v01
JOIN dbp_view.v_tag_stunde v02 ON v02.dat_zeit BETWEEN v01.datzeit_von AND v01.datzeit_bis;
