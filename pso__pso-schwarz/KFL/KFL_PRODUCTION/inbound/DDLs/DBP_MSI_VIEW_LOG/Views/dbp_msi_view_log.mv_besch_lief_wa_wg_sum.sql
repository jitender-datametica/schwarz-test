create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_BESCH_LIEF_WA_WG_SUM(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	LAGERNUMMER_ID,
	VERSANDSTELLE_ID,
	LAGERORT_ID,
	LAGERSORTIMENT_ID,
	ARTIKELSORTIMENT_ID,
	TRANSPORTSORTIMENT_ID,
	DIFF_ID,
	DAT_LIEF_SOLL,
	LIEF_TYP_ID,
	VERTR_BELEG_TYP_ID,
	WG_ID,
	ARTHIERTYP_ID,
	KUNDE_ID,
	WG_VERKETT_LIEF,
	LIEF_PAL_TYP_ID,
	LIEF_PAL_TYP_DWH_ID,
	MANDANT_ID_KUNDE,
	WERBEWARE_ID,
	BESTELLART_ID,
	HU_STATUS_ID,
	DISPONENT_ID,
	ANZAHL_POSITION,
	ANZAHL_POSITION_CHARG_SPLIT,
	ANZAHL_PACKSTUECK_ANZPK,
	ANZAHL_PACKSTUECK_HU,
	BRTVOL_LADUNG,
	BRTVOL_LADUNG_GEDECKELT,
	BRTVOL_HU_GEDECKELT_OA,
	BRTVOL_HU_OA,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI,
	MENGE_LIEF_SOLL_BME,
	MENGE_LIEF_IST_BME,
	ANZAHL_STELLPLATZ_EWM_EXT_PARENT,
	ANZAHL_STELLPLATZ_EWM,
	AUSLIEFERUNGSGRUPPE_ID,
	WG_VERKETT_HIER_ID,
	WG_VERKETT_FG
) as









SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.lagernummer_id
,v01.versandstelle_id
,v01.lagerort_id
,v01.lagersortiment_id
,CASE WHEN LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) = '5' THEN '1'WHEN LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) = '7' THEN '2'ELSE LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) END AS ARTIKELSORTIMENT_ID
,COALESCE (v01.transportsortiment_id,'-1') AS transportsortiment_id
,v01.diff_id
,v01.dat_lief_soll
,v01.lief_typ_id
,v01.vertr_beleg_typ_id
,v01.wg_id
,v01.arthiertyp_id


,COALESCE(aktuell_wup_id, TRY_CAST(kunde_id AS INTEGER)) AS kunde_id
,v01.wg_verkett_lief
,v01.lief_pal_typ_id
,v01.lief_pal_typ_dwh_id
,v01.mandant_id_kunde
,v01.werbeware_id
,v01.bestellart_id
,v01.hu_status_id
,v01.disponent_id
,v01.anzahl_position
,v01.anzahl_position_charg_split
,v01.anzahl_packstueck_anzpk
,v01.anzahl_packstueck_hu
,v01.brtvol_ladung
,v01.brtvol_ladung_gedeckelt
,v01.brtvol_hu_gedeckelt_oa
,v01.brtvol_hu_oa
,v01.menge_lief_soll_kolli
,v01.menge_lief_ist_kolli
,v01.menge_lief_soll_bme
,v01.menge_lief_ist_bme
,v01.anzahl_stellplatz_ewm_ext_parent
,v01.anzahl_stellplatz_ewm
,v01.auslieferungsgruppe_id
,CASE WHEN v01.wg_verkett_fg=1 THEN CAST(wgver.wg_verkett_hier_id AS CHAR(4)) ELSE '' END AS wg_verkett_hier_id
,wg_verkett_fg
FROM dbp_view.v_besch_lief_wa_wg_sum v01 
LEFT JOIN dbp_view.v_wup v02
   ON v02.mandant_id = CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id ELSE v01.mandant_id_kunde END
   
   AND v02.wup_id = kunde_id
   AND v02.nb_id = 0
   
LEFT JOIN dbp_view.v_wg_verkettung_hierarchie_zu_per wgver
ON v01.wup_id =wgver.wup_id
AND v01.mandant_id=wgver.mandant_id
AND v01.wg_verkett_lief=wgver.wg_verkett_id
AND v01.dat_lief_soll BETWEEN wgver.dat_von AND wgver.dat_bis
WHERE  v01.lief_pal_typ_dwh_id <> 'J'



;
