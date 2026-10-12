create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_BESCH_LIEF_WA_DET_1(
	MANDANT_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	HANDLING_UNIT_ID,
	HANDLING_UNIT_POS_ID,
	HU_TYP_ID,
	BEST_BELEG_ID,
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
	ART_ID,
	KUNDE_ID,
	WG_VERKETT_LIEF,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI,
	MENGE_LIEF_IST_KOLLI_INCL_CHARSPLIT,
	MENGE_LIEF_SOLL_BME,
	MENGE_LIEF_IST_BME,
	LIEF_PAL_TYP_ID,
	LIEF_PAL_TYP_DWH_ID,
	MANDANT_ID_KUNDE,
	WERBEWARE_ID,
	BESTELLART_ID,
	HU_STATUS_ID,
	HANDLING_UNIT_ID_EXT_PARENT,
	HANDLING_UNIT_ID_EXT,
	HANDLING_UNIT_ID_PARENT,
	ORIGINALPOSITION_LIEF_FG,
	POSITION_CHARG_SPLIT_FG,
	UEBG_CHARGENSPLIT_POS,
	DISPONENT_ID,
	DAT_HALTBARKEIT,
	CHARGE_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	ANZAHL_PACKSTUECK,
	VK_NETTO_LIEF_IST,
	VK_NETTO_LIEF_SOLL,
	MENGE_LIEF_SOLL_PAL,
	MENGE_LIEF_IST_PAL,
	WG_VERKETT_HIER_ID,
	WG_VERKETT_FG
) as





















SELECT
v01.mandant_id
,v01.lief_beleg_id
,v01.lief_beleg_pos_id
,v01.handling_unit_id
,v01.handling_unit_pos_id
,v01.hu_typ_id
,v01.best_beleg_id
,v01.transportation_unit_id
,YEAR(v01.dat_tour) AS KJ_TRANSPORTATION_UNIT
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
,v01.art_id



,COALESCE(aktuell_wup_id, TRY_CAST(v01.kunde_id AS INTEGER)) AS kunde_id
,v01.wg_verkett_lief
,v01.menge_lief_soll_kolli
,v01.menge_lief_ist_kolli
,v05a.menge_lief_ist_kolli_incl_charsplit_agg AS menge_lief_ist_kolli_incl_charsplit
,v01.menge_lief_soll_bme
,v01.menge_lief_ist_bme
,v01.lief_pal_typ_id
,v01.lief_pal_typ_dwh_id
,v01.mandant_id_kunde
,v01.werbeware_id
,v01.bestellart_id
,v01.hu_status_id
,v01.handling_unit_id_ext_parent
,v01.handling_unit_id_ext
,v01.handling_unit_id_parent
,v01.originalposition_lief_fg
,v01.position_charg_split_fg
,v01.uebg_chargensplit_pos
,v01.disponent_id
,v01.dat_haltbarkeit
,v01.charge_id
,COALESCE(v01.auslieferungsgruppe_id, '-1') AS AUSLIEFERUNGSGRUPPE_ID
,v01.anzahl_packstueck
,CASE WHEN v04.wrg_typ_id = 0 THEN v01.vk_netto_lief_ist * v02.umrechnungskurs ELSE v01.vk_netto_lief_ist END AS vk_netto_lief_ist
,CASE WHEN v04.wrg_typ_id = 0 THEN v01.vk_netto_lief_soll * v02.umrechnungskurs ELSE v01.vk_netto_lief_soll END AS vk_netto_lief_soll
,v01.menge_lief_soll_pal
,v01.menge_lief_ist_pal
,CASE WHEN v01.wg_verkett_fg=1 THEN CAST(wgver.wg_verkett_hier_id AS CHAR(4)) ELSE '' END AS wg_verkett_hier_id
,v01.wg_verkett_fg
FROM dbp_view.v_besch_lief_wa_det_1 v01


LEFT JOIN dbp_view.v_wg_verkettung_hierarchie_zu_per_1 wgver
ON v01.wup_id =wgver.wup_id
AND v01.mandant_id=wgver.mandant_id
AND v01.wg_verkett_lief=wgver.wg_verkett_id
AND v01.dat_lief_soll BETWEEN wgver.dat_von AND wgver.dat_bis

LEFT JOIN dbp_view.v_wup_1 v06
   ON v06.mandant_id = CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id ELSE v01.mandant_id_kunde END
   AND v06.wup_id = v01.kunde_id
   AND  v06.nb_id = 0 
   
LEFT JOIN dbp_msi_view_log.mv_kurs_1 v02 ON v01.wrg_id = v02.von_wrg_id

INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03 ON v01.mandant_id = v03.mandant_id 

INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v04 
ON v03.wrg_typ_id = v04.wrg_typ_id

LEFT JOIN
(SELECT
 v05.dat_lief_soll
,v05.lief_beleg_id
,v05.uebg_chargensplit_pos
,v05.art_id
,v05.mandant_id
,SUM(v05.menge_lief_ist_kolli_charsplit) AS menge_lief_ist_kolli_incl_charsplit_agg
 FROM
(SELECT
 v01.dat_lief_soll
,v01.lief_beleg_id
,v01.uebg_chargensplit_pos
,v01.art_id
,v01.mandant_id
 ,SUM (v01.menge_lief_ist_kolli) AS menge_lief_ist_kolli_charsplit
FROM dbp_view.v_besch_lief_wa_det_1 v01
 WHERE  v01.originalposition_lief_fg=0
GROUP BY
 v01.dat_lief_soll
,v01.lief_beleg_id
,v01.uebg_chargensplit_pos
,v01.art_id
,v01.mandant_id
UNION

SELECT
 v01.dat_lief_soll
,v01.lief_beleg_id
,v01.lief_beleg_pos_id AS uebg_chargensplit_pos
,v01.art_id
,v01.mandant_id
,SUM (v01.menge_lief_ist_kolli) AS menge_lief_ist_kolli_charsplit
FROM dbp_view.v_besch_lief_wa_det_1 v01
WHERE  v01.originalposition_lief_fg=1 
GROUP BY
 v01.dat_lief_soll
,v01.lief_beleg_id
,v01.lief_beleg_pos_id
,v01.art_id
,v01.mandant_id
) v05
GROUP BY
 v05.dat_lief_soll
,v05.lief_beleg_id
,v05.uebg_chargensplit_pos
,v05.art_id
,v05.mandant_id) v05a
ON 
    v01.dat_lief_soll=v05a.dat_lief_soll
AND v01.lief_beleg_id=v05a.lief_beleg_id
AND v01.lief_beleg_pos_id=v05a.uebg_chargensplit_pos
AND v01.art_id=v05a.art_id
AND v01.mandant_id=v05a.mandant_id


;
