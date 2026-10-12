create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW3.TBL_MV_BESCH_LIEF_DET_2(
	AKTIONS_POS_KZ,
	ANNAHMEVERWEIGERUNG_ID,
	ART_ID,
	BESCH_PALETTE_FG,
	BRUTTOGEW,
	DAT_AENDERUNG,
	DAT_HALTBARKEIT,
	DIFF_ID,
	LAGERORT_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	MANDANT_ID,
	MENGE_LIEF_IST_BME,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_PALETTE,
	NB_ID,
	SYSTEM_ID,
	VERK_MENGE_EINH_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	WUP_ID,
	DAT_LIEF_SOLL,
	MENGE_LIEF_SOLL_BME,
	MENGE_LIEF_IST_KOLLI,
	MENGE_LIEF_IST_LME,
	MENGE_LIEF_FEHL_BME,
	MENGE_LIEF_FEHL_KOLLI,
	WRG_ID,
	MENGE_KOLLI,
	WRG_TYP_ID,
	VK_NETTO_LIEF_SOLL,
	VK_NETTO_LIEF_IST,
	VK_NETTO_LIEF_FEHL,
	LETZTER_WE_MARKT_LIEF,
	BESTELLART_ID,
	KJ,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	NB_ID_KUNDE,
	LIEF_PAL_TYP_ID,
	BETRAG_LIEF_IST,
	BETRAG_LIEF_SOLL,
	UMRECHNUNGSKURS,
	AUSLIEFERUNGSGRUPPE_ID,
	LAGERNUMMER_ID,
	LIEF_TYP_ID,
	WERBEWARE_ID,
	GP_ID,
	VERSANDSTELLE_ID,
	VERTR_BELEG_TYP_ID,
	WG_VERKETT_FG,
	WG_VERKETT_HIER_ID,
	WG_VERKETT_LIEF
) as





















SELECT
  v01.aktions_pos_kz
, v01.annahmeverweigerung_id
, v01.art_id
, v01.besch_palette_fg
, v01.bruttogew
, v01.dat_aenderung
, v01.dat_haltbarkeit
, v01.diff_id
, v01.lagerort_id
, v01.lief_beleg_id
, v01.lief_beleg_pos_id
, v01.mandant_id
, v01.menge_lief_ist_bme
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE v01.menge_lief_soll_kolli
END AS menge_lief_soll_kolli
, v01.menge_lief_palette
, v01.nb_id
, v01.system_id
, v01.verk_menge_einh_id
, CASE WHEN v01.best_beleg_id <> 0 THEN v01.best_beleg_id ELSE v01.vorlage_beleg_id END AS best_beleg_id
, v01.vorlage_beleg_pos_id AS best_beleg_pos_id
, v01.wup_id
, v01.dat_lief_soll
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE v01.menge_lief_soll_bme
END AS menge_lief_soll_bme
, v01.menge_lief_ist_kolli
, v01.menge_lief_ist_lme
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE (v01.menge_lief_soll_bme - v01.menge_lief_ist_bme)

END AS menge_lief_fehl_bme
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE (v01.menge_lief_soll_kolli - v01.menge_lief_ist_kolli)
END AS menge_lief_fehl_kolli
, v03.wrg_id
, v01.menge_kolli
, v03.wrg_typ_id
, CASE
WHEN v03.wrg_typ_id = 0
THEN (v01.vk_netto_lief_soll * v02.umrechnungskurs)
ELSE v01.vk_netto_lief_soll
END AS vk_netto_lief_soll
, CASE
WHEN v03.wrg_typ_id = 0
THEN (v01.vk_netto_lief_ist * v02.umrechnungskurs)
ELSE v01.vk_netto_lief_ist
END AS vk_netto_lief_ist
, CASE
WHEN v03.wrg_typ_id = 0
THEN ((v01.vk_netto_lief_soll - v01.vk_netto_lief_ist) * v02.umrechnungskurs)
ELSE (v01.vk_netto_lief_soll - v01.vk_netto_lief_ist)
END AS vk_netto_lief_fehl
, v01.dat_haltbarkeit - ((v05.mhd_zeitraum * v05.lager_prozent / 100 )+0.5) AS letzter_we_markt_lief
, v01.bestellart_id
, v01.kj
, v011.mandant_id_kunde

, CASE WHEN TRY_CAST(kunde_id AS INTEGER) IS NULL THEN -3 ELSE v04.aktuell_wup_id END kunde_id
, 0 AS nb_id_kunde

,CASE WHEN v011.lief_pal_typ_id <> '6' THEN CAST(v011.lief_pal_typ_id AS CHAR(2))
WHEN v011.lief_pal_typ_id = '6' AND v01.mandant_id = 1 AND v01.lief_beleg_pos_id = 10 OR v01.mandant_id <> 1 AND v01.lief_beleg_pos_id = 1 THEN '61'
WHEN v011.lief_pal_typ_id = '6' AND v01.mandant_id = 1 AND v01.lief_beleg_pos_id <> 10 OR v01.mandant_id <> 1 AND v01.lief_beleg_pos_id <> 1 THEN '64'
END AS lief_pal_typ_id,
v01.betrag_lief_ist,
v01.betrag_lief_soll,
v02.umrechnungskurs,
COALESCE(art_ausl.auslieferungsgruppe_id,COALESCE( wg_ausl.auslieferungsgruppe_id,'-1')) AS auslieferungsgruppe_id,
v011.lagernummer_id,
v011.lief_typ_id,
v011.werbeware_id,
v011.gp_id,
v011.versandstelle_id,
v011.vertr_beleg_typ_id,
v011.wg_verkett_fg,
CASE WHEN v011.wg_verkett_fg=1 THEN TO_CHAR(wgver.wg_verkett_hier_id) ELSE '' END AS wg_verkett_hier_id,
v011.wg_verkett_lief
FROM dbp_view.v_besch_lief_2 v011

LEFT JOIN dbp_view.v_wg_verkettung_hierarchie_zu_per_2 wgver ON 
v011.wup_id =wgver.wup_id 
AND v011.mandant_id=wgver.mandant_id
AND v011.wg_verkett_lief=wgver.wg_verkett_id
AND v011.dat_lief_soll BETWEEN wgver.dat_von AND wgver.dat_bis

JOIN dbp_view.v_tag_2 t
ON v011.dat_lief_soll = t.dat
AND akt_kj >= -2

JOIN dbp_view.v_besch_lief_det_2 v01
ON v01.mandant_id = v011.mandant_id
AND v01.lief_beleg_id = v011.lief_beleg_id
AND v01.kj = v011.kj
AND v01.dat_lief_soll = t.dat

JOIN dbp_msi_view3.mv_kurs_2 v02
ON v01.wrg_id = v02.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu_2 v03
ON v01.mandant_id = v03.mandant_id

JOIN dbp_view.v_art_2 v05
ON v01.art_id = v05.art_id
AND v01.mandant_id = v05.mandant_id

JOIN dbp_view.v_art_vorschlagswert_per_2 maw1_2
ON v01.mandant_id = maw1.mandant_id
AND v01.art_id = maw1.art_id
AND v01.dat_lief_soll BETWEEN maw1.dat_von AND maw1.dat_bis

JOIN dbp_view.v_art_wg_zu_per_2 wg
ON v01.mandant_id = wg.mandant_id
AND v01.art_id = wg.art_id
AND v01.dat_lief_soll BETWEEN wg.dat_von AND wg.dat_bis
AND wg.arthiertyp_id=2

LEFT JOIN dbp_view.v_wup_2 v04
ON v04.mandant_id =  v011.mandant_id_kunde
AND v04.wup_id = TRY_CAST(kunde_id AS INTEGER)

LEFT JOIN dbp_view.v_art_auslieferungsgruppe_per_2 art_ausl
ON v01.mandant_id = art_ausl.mandant_id
AND v01.art_id = art_ausl.art_id
AND v01.dat_lief_soll BETWEEN art_ausl.dat_von AND art_ausl.dat_bis

LEFT JOIN dbp_view.v_wg_auslieferungsgruppe_per_2 wg_ausl
ON v01.mandant_id = wg_ausl.mandant_id
AND wg.wg_id = wg_ausl.wg_id
AND CASE WHEN wg_ausl.sortimentslistenart_id = '' THEN '' ELSE maw1.sortimentslistenart_id END =wg_ausl.sortimentslistenart_id
AND v01.dat_lief_soll BETWEEN wg_ausl.dat_von AND wg_ausl.dat_bis

LEFT JOIN dbp_view.v_l_lagernummer_2 l_lagn
ON  v011.mandant_id = l_lagn.mandant_id
AND v011.lagernummer_id = l_lagn.lagernummer_id

LEFT JOIN (SELECT 
            mandant_id
           ,wup_id
           ,nb_id
           ,lagernummer_id
           ,MIN(dat) AS dat 
           FROM dbp_msi_data.ts_lagerort_ewm_dat_2 
           GROUP BY mandant_id
           ,wup_id
           ,nb_id
           ,lagernummer_id) ts_lo_ewm
  ON v011.mandant_id = ts_lo_ewm.mandant_id
 AND l_lagn.wup_id = ts_lo_ewm.wup_id
 AND l_lagn.nb_id = ts_lo_ewm.nb_id
 AND v011.lagernummer_id = ts_lo_ewm.lagernummer_id

WHERE 
  ( ts_lo_ewm.mandant_id IS NULL OR NOT  v011.dat_lief_soll >= ts_lo_ewm.dat)  
;
