create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_LIEF_WG_HU_1(
	WUP_ID,
	NB_ID,
	WG_ID,
	ARTHIERTYP_ID,
	OWG_ID,
	LAGERNUMMER_ID,
	MANDANT_ID,
	DAT_LIEF_SOLL,
	BESTELLART_ID,
	LIEF_TYP_ID,
	LIEF_PAL_TYP_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	HANDLING_UNIT_ID_EXT,
	HANDLING_UNIT_ID,
	HU_STATUS_ID,
	MENGE_HANDLING_KOLLI_HU
) as






SELECT 
 lips.wup_id
,lips.nb_id
,wg.wg_id
,wg.arthiertyp_id
,wg.owg_id
,likp.lagernummer_id
,likp.mandant_id
,likp.dat_lief_soll
,lips.bestellart_id
,likp.lief_typ_id
,likp.lief_pal_typ_id
,likp.mandant_id_kunde

,CASE WHEN TRY_CAST(likp.kunde_id AS INTEGER) = 0 THEN NULL ELSE w.aktuell_wup_id END kunde_id_
,COALESCE(art_ausl.auslieferungsgruppe_id,COALESCE(wg_ausl.auslieferungsgruppe_id,'-1')) AS auslieferungsgruppe_id 
,hu.handling_unit_id_ext
,hu.handling_unit_id
,hu.hu_status_id
,SUM (CASE WHEN lips.besch_palette_fg=1 AND a.artikelart_id <>'Z983' AND  a.artikelart_id <> '-1' THEN hud.menge_handling_kolli/50 ELSE hud.menge_handling_kolli END) AS menge_handling_kolli_hu

FROM dbp_view.v_handling_unit_det_1 hud

JOIN dbp_view.v_besch_lief_det_1 lips 
ON  hud.mandant_id =lips.mandant_id
AND hud.wup_id =lips.wup_id
AND hud.lief_beleg_id = lips.lief_beleg_id
AND hud.lief_beleg_pos_id = lips.lief_beleg_pos_id
AND hud.art_id = lips.art_id
AND hud.kj_lief_beleg=lips.kj
AND hud.hu_typ_id=1

JOIN dbp_view.v_handling_unit_1 hu
ON  hud.lief_beleg_id=hu.lief_beleg_id
AND hud.handling_unit_id=hu.handling_unit_id
AND hud.mandant_id =hu.mandant_id
AND hud.wup_id =hu.wup_id  

JOIN dbp_view.v_besch_lief_1 likp
ON likp.lief_beleg_id=hu.lief_beleg_id
AND likp.kj=hu.kj_lief_beleg

INNER JOIN dbp_view.v_wup_1 w
   ON w.mandant_id = CASE WHEN likp.mandant_id_kunde IS NULL OR likp.mandant_id_kunde = 0 THEN likp.mandant_id ELSE likp.mandant_id_kunde END
   AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

JOIN  dbp_view.v_art_wg_zu_per_1 awg 
ON lips.mandant_id = awg.mandant_id 
AND lips.art_id = awg.art_id 
AND lips.dat_lief_soll BETWEEN awg.dat_von AND awg.dat_bis 
AND awg.arthiertyp_id=2 

JOIN dbp_view.v_wg_per_1 wg
ON awg.wg_id=wg.wg_id
AND awg.mandant_id=wg.mandant_id
AND likp.dat_lief_soll BETWEEN wg.dat_von AND wg.dat_bis

JOIN dbp_view.v_art_1 a
ON hud.art_id=a.art_id
AND hud.mandant_id=a.mandant_id

JOIN dbp_view.v_art_vorschlagswert_per_1 maw1_1  
ON lips.mandant_id = maw1.mandant_id 
AND lips.art_id = maw1.art_id 
AND lips.dat_lief_soll BETWEEN maw1.dat_von AND maw1.dat_bis 

LEFT JOIN dbp_view.v_art_auslieferungsgruppe_per_1 art_ausl 
ON lips.mandant_id = art_ausl.mandant_id 
AND lips.art_id = art_ausl.art_id 
AND lips.dat_lief_soll BETWEEN art_ausl.dat_von AND art_ausl.dat_bis 

LEFT JOIN dbp_view.v_wg_auslieferungsgruppe_per_1 wg_ausl 
ON lips.mandant_id = wg_ausl.mandant_id 
AND awg.wg_id = wg_ausl.wg_id 
AND CASE WHEN wg_ausl.sortimentslistenart_id = '' THEN '' ELSE maw1.sortimentslistenart_id END =wg_ausl.sortimentslistenart_id 
AND lips.dat_lief_soll BETWEEN wg_ausl.dat_von AND wg_ausl.dat_bis 


GROUP BY
lips.wup_id
,lips.nb_id
,wg.wg_id
,wg.arthiertyp_id
,wg.owg_id
,likp.lagernummer_id
,likp.mandant_id
,likp.dat_lief_soll
,lips.bestellart_id
,likp.lief_typ_id
,likp.lief_pal_typ_id
,likp.mandant_id_kunde
,kunde_id_
,COALESCE(art_ausl.auslieferungsgruppe_id,COALESCE(wg_ausl.auslieferungsgruppe_id,'-1'))
,hu.handling_unit_id_ext
,hu.handling_unit_id
,hu.hu_status_id;