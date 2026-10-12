CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_BESCH_LIEF_WG_HU_2(
	MANDANT_ID,
	HANDLING_UNIT_ID,
	HANDLING_UNIT_POS_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	TRANSPORTATION_UNIT_ID,
    KJ_TRANSPORTATION_UNIT,
	BELOS_VORGANG_ID,
	WUP_ID,
	NB_ID,
	LAGERNUMMER_ID,
	VERSANDSTELLE_ID,
	LAGERORT_ID,
	LAGERSORTIMENT_ID,
	ARTIKELSORTIMENT_ID,
	DIFF_ID,
	DAT_LIEF_SOLL,
	LIEF_TYP_ID,
	VERTR_BELEG_TYP_ID,
	ARTHIERTYP_ID,
	KUNDE_ID,
	ART_ID,
	WG_ID,
	OWG_ID,
	WG_VERKETT_LIEF,
	LIEF_PAL_TYP_ID,
	LIEF_PAL_TYP_DWH_ID,
	MANDANT_ID_KUNDE,
	WERBEWARE_ID,
	BESTELLART_ID,
	HU_STATUS_ID,
	HU_RELEVANT_FG,
	HANDLING_UNIT_ID_EXT_PARENT,
	HU_IN_BEZIEHUNG_FG,
	VOL_RELEVANT_FG,
	HANDLING_UNIT_ID_EXT,
	HANDLING_UNIT_ID_PARENT,
	WG_VERKETT_FG,
	MENGE_LIEF_IST_KOLLI_HU,
	AUSLIEFERUNGSGRUPPE_ID
) AS

SELECT
--AP0122352_SPEC0146171, dknop, initial
-- 19.04.2022, AP0122352_SPEC0146171, dknop, updates in logic for menge_lief_ist_kolli_hu, auslieferungsgruppe_id based on script from n.wagner
--2024-07-19,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-11-14, AP0240092, nwag, add KJ_TRANSPORTATION_UNIT
 agg.mandant_id
,agg.handling_unit_id
,hud.handling_unit_pos_id
,hud.lief_beleg_id
,hud.lief_beleg_pos_id
,agg.transportation_unit_id
,YEAR(agg.dat_tour) AS KJ_TRANSPORTATION_UNIT
,agg.belos_vorgang_id
,agg.wup_id
,agg.nb_id
,agg.lagernummer_id
,agg.versandstelle_id
,lips.lagerort_id
,agg.lagersortiment_id
,CASE WHEN LEFT(RIGHT(agg.versandstelle_id,2),1) = '5' THEN '1'WHEN LEFT(RIGHT(agg.versandstelle_id,2),1) = '7' THEN '2'ELSE LEFT(RIGHT(agg.versandstelle_id,2),1) END AS Artikelsortiment_id
,lips.diff_id
,agg.dat_lief_soll
,agg.lief_typ_id
,agg.vertr_beleg_typ_id
,agg.arthiertyp_id
,w.aktuell_wup_id AS kunde_id
--,CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id
--,kunde_id
,hud.art_id
,awg.wg_id
,wg.owg_id
,agg.wg_verkett_lief
,agg.lief_pal_typ_id
,agg.lief_pal_typ_dwh_id
,agg.mandant_id_kunde
,agg.werbeware_id
,lips.bestellart_id
,agg.hu_status_id
,agg.hu_relevant_fg
,agg.handling_unit_id_ext_parent
,agg.hu_in_beziehung_fg
,agg.vol_relevant_fg
,agg.handling_unit_id_ext
,agg.handling_unit_id_parent
,agg.wg_verkett_fg
,hud.verp_menge_bme/ (CASE WHEN lips.menge_lief_ist_kolli > 0 THEN lips.menge_lief_ist_lme/lips.menge_lief_ist_kolli ELSE 1 END) AS menge_lief_ist_kolli_hu
,COALESCE(art_ausl.auslieferungsgruppe_id,COALESCE( wg_ausl.auslieferungsgruppe_id,'-1')) AS auslieferungsgruppe_id

FROM dbp_view.v_besch_lief_wa_hu_sum_2 agg

INNER JOIN dbp_view.v_wup_2 w
   ON w.mandant_id = CASE WHEN agg.mandant_id_kunde IS NULL OR agg.mandant_id_kunde = 0 THEN agg.mandant_id ELSE agg.mandant_id_kunde END
   --AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND w.wup_id = agg.kunde_id
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

JOIN dbp_view.v_handling_unit_det_2 hud
ON  agg.mandant_id=hud.mandant_id
AND agg.lief_beleg_id=hud.lief_beleg_id
AND agg.handling_unit_id=hud.handling_unit_id
AND agg.wup_id=hud.wup_id

JOIN dbp_view.v_art_wg_zu_per_2 awg
ON hud.mandant_id=awg.mandant_id
AND hud.art_id=awg.art_id
AND agg.dat_lief_soll BETWEEN awg.dat_von AND awg.dat_bis
AND awg.arthiertyp_id=2

JOIN dbp_view.v_wg_per_2 wg
ON awg.wg_id=wg.wg_id
AND awg.mandant_id=wg.mandant_id
AND agg.dat_lief_soll BETWEEN wg.dat_von AND wg.dat_bis

JOIN dbp_view.v_besch_lief_det_2 lips
ON lips.mandant_id = hud.mandant_id
AND lips.wup_id = hud.wup_id
AND lips.lief_beleg_id = hud.lief_beleg_id
AND lips.lief_beleg_pos_id = hud.lief_beleg_pos_id
AND lips.kj = hud.kj_lief_beleg

JOIN dbp_view.v_art_vorschlagswert_per_2 maw1_2
ON lips.mandant_id = maw1.mandant_id
AND lips.art_id = maw1.art_id
AND lips.dat_lief_soll BETWEEN maw1.dat_von AND maw1.dat_bis

LEFT JOIN dbp_view.v_art_auslieferungsgruppe_per_2 art_ausl
ON lips.mandant_id = art_ausl.mandant_id
AND lips.art_id = art_ausl.art_id
AND lips.dat_lief_soll BETWEEN art_ausl.dat_von AND art_ausl.dat_bis

LEFT JOIN dbp_view.v_wg_auslieferungsgruppe_per_2 wg_ausl
ON lips.mandant_id = wg_ausl.mandant_id
AND awg.wg_id = wg_ausl.wg_id
AND CASE WHEN wg_ausl.sortimentslistenart_id = '' THEN '' ELSE maw1.sortimentslistenart_id END =wg_ausl.sortimentslistenart_id
AND lips.dat_lief_soll BETWEEN wg_ausl.dat_von AND wg_ausl.dat_bis;