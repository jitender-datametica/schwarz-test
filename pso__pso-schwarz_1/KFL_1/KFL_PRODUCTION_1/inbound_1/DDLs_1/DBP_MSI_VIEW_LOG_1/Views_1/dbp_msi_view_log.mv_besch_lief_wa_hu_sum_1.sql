create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_BESCH_LIEF_WA_HU_SUM_1(
	MANDANT_ID,
	HANDLING_UNIT_ID,
	LIEF_BELEG_ID,
	TRANSPORTATION_UNIT_ID,
	KJ_TRANSPORTATION_UNIT,
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
	ARTHIERTYP_ID,
	KUNDE_ID,
	WG_ID,
	WG_VERKETT_LIEF,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI,
	MENGE_LIEF_SOLL_BME,
	MENGE_LIEF_IST_BME,
	LIEF_PAL_TYP_ID,
	LIEF_PAL_TYP_DWH_ID,
	ANZAHL_POSITION,
	ANZAHL_POSITION_CHARG_SPLIT,
	ANZAHL_PACKSTUECK_HU,
	ANZAHL_PACKSTUECK_ANZPK,
	MANDANT_ID_KUNDE,
	WERBEWARE_ID,
	BESTELLART_ID,
	HU_STATUS_ID,
	BRTVOL_LADUNG,
	BRTVOL_LADUNG_GEDECKELT,
	BRTVOL_HU_GEDECKELT_OA,
	BRTGEW_HU_OA,
	HU_RELEVANT_FG,
	HANDLING_UNIT_ID_EXT_PARENT,
	HU_IN_BEZIEHUNG_FG,
	VOL_RELEVANT_FG,
	ANZAHL_STELLPLATZ_EWM_EXT_PARENT,
	ANZAHL_STELLPLATZ_EWM,
	HANDLING_UNIT_ID_EXT,
	HANDLING_UNIT_ID_PARENT,
	DISPONENT_ID,
	VK_NETTO_LIEF_IST,
	VK_NETTO_LIEF_SOLL,
	BELOS_VORGANG_ID,
	MENGE_LIEF_SOLL_PAL,
	MENGE_LIEF_IST_PAL,
	MENGE_GEFAHRGUT,
	AUSLIEFERUNGSGRUPPE_ID,
	WRG_ID,
	WG_VERKETT_HIER_ID,
	WG_VERKETT_FG
) as 


















SELECT
 v01.mandant_id
,v01.handling_unit_id
,v01.lief_beleg_id
,v01.transportation_unit_id
,YEAR(v01.dat_tour) AS KJ_TRANSPORTATION_UNIT
,v01.wup_id
,v01.nb_id
,v01.lagernummer_id
,v01.versandstelle_id
,v01.lagerort_id
,v01.lagersortiment_id
,CASE WHEN LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) = '5' THEN '1'WHEN LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) = '7' THEN '2'ELSE LEFT(RIGHT(v01.VERSANDSTELLE_ID,2),1) END AS artikelsortiment_id
,COALESCE (v01.transportsortiment_id,'-1') AS transportsortiment_id
,v01.diff_id
,v01.dat_lief_soll
,v01.lief_typ_id
,v01.vertr_beleg_typ_id
,v01.arthiertyp_id



,COALESCE(aktuell_wup_id, TRY_CAST(kunde_id AS INTEGER)) AS kunde_id
,v01.wg_id
,v01.wg_verkett_lief
,v01.menge_lief_soll_kolli
,v01.menge_lief_ist_kolli
,v01.menge_lief_soll_bme
,v01.menge_lief_ist_bme
,v01.lief_pal_typ_id
,v01.lief_pal_typ_dwh_id
,v01.anzahl_position
,v01.anzahl_position_charg_split
,v01.anzahl_packstueck_hu
,v01.anzahl_packstueck_anzpk
,v01.mandant_id_kunde
,v01.werbeware_id
,v01.bestellart_id
,v01.hu_status_id
,v01.brtvol_ladung
,v01.brtvol_ladung_gedeckelt
,v01.brtvol_hu_gedeckelt_oa
,v01.brtgew_hu_oa
,v01.hu_relevant_fg
,v01.handling_unit_id_ext_parent
,v01.hu_in_beziehung_fg
,v01.vol_relevant_fg
,v01.anzahl_stellplatz_ewm_ext_parent
,v01.anzahl_stellplatz_ewm
,v01.handling_unit_id_ext
,v01.handling_unit_id_parent
,v01.disponent_id
,CASE WHEN v04.wrg_typ_id = 0 THEN v01.vk_netto_lief_ist * v02.umrechnungskurs ELSE v01.vk_netto_lief_ist END AS vk_netto_lief_ist
,CASE WHEN v04.wrg_typ_id = 0 THEN v01.vk_netto_lief_soll * v02.umrechnungskurs ELSE v01.vk_netto_lief_soll END AS vk_netto_lief_soll
,v01.belos_vorgang_id
,v01.menge_lief_soll_pal
,v01.menge_lief_ist_pal
,v01.menge_gefahrgut
,v01.auslieferungsgruppe_id
,CASE WHEN v03.wrg_typ_id=0 THEN 'EUR' ELSE v01.wrg_id END AS wrg_id_
,CASE WHEN v01.wg_verkett_fg=1 THEN CAST(wgver.wg_verkett_hier_id AS CHAR(4)) ELSE '' END AS wg_verkett_hier_id
,v01.wg_verkett_fg
FROM dbp_view.v_besch_lief_wa_hu_sum_1 v01

LEFT JOIN dbp_view.v_wup_1 v05
   ON v05.mandant_id = CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id ELSE v01.mandant_id_kunde END
   AND v05.wup_id = v01.kunde_id
   AND v05.nb_id = 0
   
LEFT JOIN dbp_view.v_wg_verkettung_hierarchie_zu_per_1 wgver
ON v01.wup_id =wgver.wup_id
AND v01.mandant_id=wgver.mandant_id
AND v01.wg_verkett_lief=wgver.wg_verkett_id
AND v01.dat_lief_soll BETWEEN wgver.dat_von AND wgver.dat_bis

LEFT JOIN dbp_msi_view_log.mv_kurs_1 v02
 ON v01.wrg_id = v02.von_wrg_id

INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03 
ON v01.mandant_id = v03.mandant_id 

INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v04 
ON v03.wrg_typ_id = v04.wrg_typ_id

WHERE ( v01.handling_unit_id > 0 OR v01.menge_lief_ist_kolli > 0 ) 

;
