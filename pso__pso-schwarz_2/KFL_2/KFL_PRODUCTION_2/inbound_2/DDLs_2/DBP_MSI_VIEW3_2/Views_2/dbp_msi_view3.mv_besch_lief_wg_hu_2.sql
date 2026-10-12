CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_LIEF_WG_HU_2(
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
) AS
-- 2022-03-22, AP0101988, dknop, New way to determine Ausliefergruppe 
-- 2022-04-19, AP0101988, dknop, changing logic for menge_handling_kolli_hu
-- 2022-04-20, AP0101988, dknop, adding hu_status_id, arthiertyp_id, updating logic for menge_handling_kolli_hu
-- 2022-05-17, AP0101988, SPEC0121842, adding art_id in join to besch_lief_det_2, dknop
-- 2022-05-20, AP0101988, SPEC0121842, dknop, adding hud.kj_lief_beleg=lips.kj
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
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
--,TRY_CAST(likp.kunde_id AS INT) AS kunde_id
,CASE WHEN TRY_CAST(likp.kunde_id AS INTEGER) = 0 THEN NULL ELSE w.aktuell_wup_id END kunde_id_
,COALESCE(art_ausl.auslieferungsgruppe_id,COALESCE(wg_ausl.auslieferungsgruppe_id,'-1')) AS auslieferungsgruppe_id 
,hu.handling_unit_id_ext
,hu.handling_unit_id
,hu.hu_status_id
,SUM (CASE WHEN lips.besch_palette_fg=1 AND a.artikelart_id <>'Z983' AND  a.artikelart_id <> '-1' THEN hud.menge_handling_kolli/50 ELSE hud.menge_handling_kolli END) AS menge_handling_kolli_hu

FROM dbp_view.v_handling_unit_det_2 hud

JOIN dbp_view.v_besch_lief_det_2 lips 
ON  hud.mandant_id =lips.mandant_id
AND hud.wup_id =lips.wup_id
AND hud.lief_beleg_id = lips.lief_beleg_id
AND hud.lief_beleg_pos_id = lips.lief_beleg_pos_id
AND hud.art_id = lips.art_id
AND hud.kj_lief_beleg=lips.kj
AND hud.hu_typ_id=1

JOIN dbp_view.v_handling_unit_2 hu
ON  hud.lief_beleg_id=hu.lief_beleg_id
AND hud.handling_unit_id=hu.handling_unit_id
AND hud.mandant_id =hu.mandant_id
AND hud.wup_id =hu.wup_id  

JOIN dbp_view.v_besch_lief_2 likp
ON likp.lief_beleg_id=hu.lief_beleg_id
AND likp.kj=hu.kj_lief_beleg

INNER JOIN dbp_view.v_wup_2 w
   ON w.mandant_id = CASE WHEN likp.mandant_id_kunde IS NULL OR likp.mandant_id_kunde = 0 THEN likp.mandant_id ELSE likp.mandant_id_kunde END
   AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

JOIN  dbp_view.v_art_wg_zu_per_2 awg 
ON lips.mandant_id = awg.mandant_id 
AND lips.art_id = awg.art_id 
AND lips.dat_lief_soll BETWEEN awg.dat_von AND awg.dat_bis 
AND awg.arthiertyp_id=2 

JOIN dbp_view.v_wg_per_2 wg
ON awg.wg_id=wg.wg_id
AND awg.mandant_id=wg.mandant_id
AND likp.dat_lief_soll BETWEEN wg.dat_von AND wg.dat_bis

JOIN dbp_view.v_art_2 a
ON hud.art_id=a.art_id
AND hud.mandant_id=a.mandant_id

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
,hu.hu_status_id
;