create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_LIEF_WG_LIEFERUNG_2(
	WUP_ID,
	NB_ID,
	ART_ID,
	WG_ID,
	OWG_ID,
	ARTHIERTYP_ID,
	LAGERNUMMER_ID,
	MANDANT_ID,
	DAT_LIEF_SOLL,
	WERBEWARE_ID,
	BESTELLART_ID,
	LIEF_TYP_ID,
	LIEF_PAL_TYP_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	KJ,
	AUSLIEFERUNGSGRUPPE_ID,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_IST_KOLLI
) as
SELECT 
 lips.wup_id
,lips.nb_id
,marc.art_id
,wg.wg_id
,wg.owg_id
,wg.arthiertyp_id
,likp.lagernummer_id
,lips.mandant_id
,likp.dat_lief_soll
,likp.werbeware_id
,lips.bestellart_id
,likp.lief_typ_id
,likp.lief_pal_typ_id
,likp.mandant_id_kunde

,CASE WHEN TRY_CAST(likp.kunde_id AS INTEGER) IS NULL THEN -3 ELSE w.aktuell_wup_id END  AS kunde_id
,lips.lief_beleg_id
,lips.lief_beleg_pos_id
,lips.kj
,COALESCE(art_ausl.auslieferungsgruppe_id,COALESCE( wg_ausl.auslieferungsgruppe_id,'-1')) AS auslieferungsgruppe_id 
,lips.menge_lief_soll_kolli
,lips.menge_lief_ist_kolli

FROM dbp_view.v_besch_lief_det_2 lips

JOIN dbp_view.v_besch_lief_2 likp 
ON  lips.mandant_id=likp.mandant_id
AND lips.lief_beleg_id=likp.lief_beleg_id
AND lips.dat_lief_soll=likp.dat_lief_soll

LEFT JOIN dbp_view.v_wup_2 w
   ON w.mandant_id = CASE WHEN likp.mandant_id_kunde IS NULL OR likp.mandant_id_kunde = 0 THEN likp.mandant_id ELSE likp.mandant_id_kunde END
   AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

JOIN dbp_view.v_art_wup_status_per_2 marc_2
ON  likp.mandant_id_kunde=marc.mandant_id
AND lips.art_id=marc.art_id
AND TRY_CAST(likp.kunde_id AS INT) = marc.wup_id
AND likp.dat_lief_soll BETWEEN marc.dat_von AND marc.dat_bis

JOIN dbp_view.v_art_vorschlagswert_per_2 maw1_2  
ON  lips.mandant_id = maw1.mandant_id 
AND lips.art_id = maw1.art_id 
AND lips.dat_lief_soll BETWEEN maw1.dat_von AND maw1.dat_bis 

JOIN dbp_view.v_art_wg_zu_per_2 awg  
ON lips.mandant_id = awg.mandant_id 
AND lips.art_id = awg.art_id 
AND lips.dat_lief_soll BETWEEN awg.dat_von AND awg.dat_bis 
AND awg.arthiertyp_id=2 

LEFT JOIN dbp_view.v_art_auslieferungsgruppe_per_2 art_ausl 
ON lips.mandant_id = art_ausl.mandant_id 
AND lips.art_id = art_ausl.art_id 
AND lips.dat_lief_soll BETWEEN art_ausl.dat_von AND art_ausl.dat_bis 

LEFT JOIN dbp_view.v_wg_auslieferungsgruppe_per_2 wg_ausl 
ON lips.mandant_id = wg_ausl.mandant_id 
AND awg.wg_id = wg_ausl.wg_id 
AND CASE WHEN wg_ausl.sortimentslistenart_id = '' THEN '' ELSE maw1.sortimentslistenart_id END =wg_ausl.sortimentslistenart_id 
AND lips.dat_lief_soll BETWEEN wg_ausl.dat_von AND wg_ausl.dat_bis 

JOIN dbp_view.v_wg_per_2 wg
ON awg.wg_id=wg.wg_id
AND awg.mandant_id=wg.mandant_id
AND likp.dat_lief_soll BETWEEN wg.dat_von AND wg.dat_bis;