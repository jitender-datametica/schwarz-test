CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_VOLUMENKENNZAHLEN_2(
	LAGERNUMMER_ID,
	LAGERSORTIMENT_ID,
	ARTIKELSORTIMENT_ID,
	MANDANT_ID,
	HANDLING_UNIT_ID_EXT,
	DAT_LIEF_SOLL,
	LIEF_TYP_ID,
	LIEF_PAL_TYP_ID,
	WERBEWARE_ID,
	WG_VERKETT_LIEF,
	WG_VERKETT_FG,
	HU_AUFGEPACKT,
	WG_VERKETT_HIER_ID,
	PALETTENVOLUMEN_WGRVK,
	PALETTENVOLUMEN_HIERARCHIE,
	THEORETISCHES_SAP_VOLUMEN_HIER,
	THEORETISCHES_SAP_VOLUMEN_WGRVK,
	LIEF_PAL_TYP_DWH_ID,
	THEORETISCHES_SAP_VOLUMEN,
	MENGE_LIEF_IST_KOLLI_HU,
	NTVOL_LADUNG_GEDECKELT,
	NTVOL_HU_GEDECKELT_OA,
	BRTVOL_LADUNG_GEDECKELT,
	BRTVOL_HU_GEDECKELT_OA,
	HU_RELEVANT_FG,
	KUNDE_ID,
	MANDANT_ID_KUNDE,
    LIEF_BELEG_ID
) AS
-- 2021.11.30, dknop, AP0111584, SPEC0135971, initial
-- 2021.12.02, dknop, AP0111584, SPEC0135971, adding hu relevant fg
-- 2021.12.16, dknop, AP0111584, SPEC0135971, removing zeroifnull for wg_verkett_hier_id
-- 2021.12.20, dknop, AP0111584, SPEC0135971, new logic for theoretisches_SAP_volumen_HIER, theoretisches_SAP_volumen_WGRVK
-- 2021.12.21, dknop, AP0111584, SPEC0135971, correcting joins - adding mandnat_id
-- 2021.12.22, dknop, AP0111584, SPEC0135971, correcting join to wup_wg_verkett_hierarchie_per, adding join to dbp_view.v_handling_unit_2 hu for menge_lief_ist_kolli
-- 2021.01.03, dknop, AP0111584, SPEC0135971, correcting join to wup_wg_verkett_hierarchie_per
-- 2022.01.03, dknop, AP0111584, SPEC0135971, correcting join to wup_wg_verkett_hierarchie_per
-- 2022.01.04, dknop, AP0111584, SPEC0135971, adding logic for menge_lief_ist_kolli (based on N.Wagner)
-- 2022.01.10, dknop, AP0111584, SPEC0135971, adding kunde_id
-- 2022.01.11, dknop, AP0111584, SPEC0135971, updating palettenvolumen_WGRVK, palettenvolumen_hierarchie
-- 2022.01.27, dknop, AP0111584, SPEC0135971, updating datatyp for wg_verkett_hier_id
--2022-02-11, AP0111584, dknop, adding ntvol_hu_gedeckelt_oa, brtvol_hu_gedeckelt_oa
--2022-02-16, dknop,  performance issue - 1 subselect instead of 2 and extent join criteria with lief_beleg_id+dat_lief_soll
--2022.03.02, dknop, removing join to kolli_menge_per_hu and replacing by bl.menge_lief_ist_kolli_hu
--2022.03.03, dknop, changing column name from menge_lief_ist_kolli to menge_lief_ist_kolli_hu
--2022.12.07, dknop, correcting error in join to v_wup_wg_verkettung_hierarchie_per_2
--2024-01-09, AP0168817, dknop, hardcoded values for lief_ pal typ DWH J4 / J9 in column theoretisches_SAP_volumen, adding LIEF_PAL_TYP_ID_DWH
--2024-06-04, dknop, INC8699508, AND bl.lief_pal_typ_id = '9' in palettenvolumen_hierarchie, palettenvolumen_WGRVK
--2024-07-19,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2025-06-06, AP0277469 dknop, Adjustments for pallet typ 6 for theoretisches_sap_volumen
--2025-06-27, adding lief_beleg_id
SELECT

 bl.lagernummer_id
,bl.lagersortiment_id
,CASE WHEN LEFT(RIGHT(bl.versandstelle_id,2),1) = '5' THEN '1'WHEN LEFT(RIGHT(bl.versandstelle_id,2),1) = '7' THEN '2'ELSE LEFT(RIGHT(bl.versandstelle_id,2),1) END AS artikelsortiment_id -- workaround for Artikelsortiment
,bl.mandant_id
,COALESCE(bl.handling_unit_id_ext,'-1') AS handling_unit_id_ext
,bl.dat_lief_soll
,bl.lief_typ_id
,bl.lief_pal_typ_id
,bl.werbeware_id
,bl.wg_verkett_lief
,bl.wg_verkett_fg
,CASE WHEN bl.handling_unit_id_parent <>0 THEN 1 ELSE 0 END AS hu_aufgepackt
,CASE WHEN bl.wg_verkett_fg=1 THEN CAST(wgver.wg_verkett_hier_id AS CHAR(4)) ELSE '' END AS wg_verkett_hier_id

,CASE WHEN wgverper.klapp_pal_fg=1 AND (CASE WHEN wgverper.palettengroesse_einh_id='CM' THEN wgverper.palettenvolumen/1000
ELSE wgverper.palettenvolumen END)>800 AND bl.lief_pal_typ_id = '9' THEN wgverper.palettenvolumen/2 ELSE wgverper.palettenvolumen END AS palettenvolumen_WGRVK

,CASE WHEN wupwgverhie.klapp_pal_fg=1  AND (CASE WHEN wupwgverhie.palettengroesse_einh_id='CM' THEN wupwgverhie.palettenvolumen/1000
ELSE wupwgverhie.palettenvolumen END)>800 AND bl.lief_pal_typ_id = '9' THEN wupwgverhie.palettenvolumen/2 ELSE wupwgverhie.palettenvolumen END AS palettenvolumen_hierarchie
,CASE WHEN wupwgverhie.palettengroesse_einh_id='CM' THEN palettenvolumen_hierarchie/1000
ELSE palettenvolumen_hierarchie END AS theoretisches_SAP_volumen_hier
,CASE WHEN wgverper.palettengroesse_einh_id='CM' THEN palettenvolumen_WGRVK/1000
ELSE palettenvolumen_WGRVK END AS theoretisches_SAP_volumen_WGRVK
,lief_pal_typ_dwh_id
,CASE
    WHEN lief_pal_typ_dwh_id = 'J4' THEN 1728
    WHEN lief_pal_typ_dwh_id = 'J9' THEN 756
    WHEN lief_pal_typ_id = '6' AND MAX_VOLUMEN_AUFPACKPAL / 1000 != 0 THEN MAX_VOLUMEN_AUFPACKPAL / 1000
    ELSE 
        CASE 
            WHEN bl.wg_verkett_fg = 1 AND lief_pal_typ_dwh_id NOT IN ('J4', 'J9') THEN 
                CASE 
                    WHEN wupwgverhie.palettengroesse_einh_id = 'CM' THEN palettenvolumen_hierarchie / 1000
                    ELSE palettenvolumen_hierarchie 
                END
            ELSE 
                CASE 
                    WHEN wgverper.palettengroesse_einh_id = 'CM' THEN palettenvolumen_WGRVK / 1000
                    ELSE palettenvolumen_WGRVK 
                END 
        END
END AS theoretisches_SAP_volumen

/*,CASE WHEN lief_pal_typ_dwh_id='J4' THEN 1728
      WHEN lief_pal_typ_dwh_id='J9' THEN 756
      ELSE CASE WHEN bl.wg_verkett_fg=1 AND lief_pal_typ_dwh_id NOT IN('J4','J9') THEN (CASE WHEN wupwgverhie.palettengroesse_einh_id='CM' THEN palettenvolumen_hierarchie/1000
                ELSE palettenvolumen_hierarchie END)
                ELSE (CASE WHEN wgverper.palettengroesse_einh_id='CM' THEN palettenvolumen_WGRVK/1000
                 ELSE palettenvolumen_WGRVK END) END END AS theoretisches_SAP_volumen*/                                    
                                         
,bl.menge_lief_ist_kolli_hu AS menge_lief_ist_kolli_hu
,bl.ntvol_ladung_gedeckelt
,bl.ntvol_hu_gedeckelt_oa
,bl.brtvol_ladung_gedeckelt
,bl.brtvol_hu_gedeckelt_oa
,bl.hu_relevant_fg
--,bl.kunde_id
--,CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(aktuell_wup_id AS INTEGER) END kunde_id
,aktuell_wup_id
,bl.mandant_id_kunde
,bl.lief_beleg_id
FROM dbp_view.v_besch_lief_wa_hu_sum_2 bl

INNER JOIN dbp_view.v_wup_2 w
   ON w.mandant_id = CASE WHEN bl.mandant_id_kunde IS NULL OR bl.mandant_id_kunde = 0 THEN bl.mandant_id ELSE bl.mandant_id_kunde END
  -- AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND w.wup_id = bl.kunde_id
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

LEFT JOIN dbp_view.v_wg_verkettung_hierarchie_zu_per_2 wgver
ON bl.wup_id =wgver.wup_id
AND bl.mandant_id=wgver.mandant_id
AND bl.wg_verkett_lief=wgver.wg_verkett_id
AND bl.dat_lief_soll BETWEEN wgver.dat_von AND wgver.dat_bis

LEFT JOIN dbp_view.v_wup_wg_verkettung_hierarchie_per_2 wupwgverhie ON
wupwgverhie.wup_id=wgver.wup_id
AND wupwgverhie.mandant_id=wgver.mandant_id
AND wupwgverhie.wg_verkett_hier_id=wgver.wg_verkett_hier_id
AND bl.dat_lief_soll BETWEEN wupwgverhie.dat_von AND wupwgverhie.dat_bis

LEFT JOIN dbp_view.v_wg_verkettung_per_2 wgverper ON
bl.wup_id = wgverper.wup_id
AND bl.mandant_id=wgverper.mandant_id
AND bl.wg_verkett_lief= wgverper.wg_verkett_id
AND bl.dat_lief_soll BETWEEN wgverper.dat_von AND wgverper.dat_bis

--where lief_pal_typ_id='6' and max_volumen_aufpackpal=0 and dat_lief_soll ='2025-04-02'

/*LEFT JOIN (


SELECT bld.mandant_id
,bld.wup_id
,bld.handling_unit_id
,bld.lief_beleg_id
,bld.dat_lief_soll
--,bld.handling_unit_pos_id
--,bld.art_id
--,verp_menge_einh_id
--,verp_menge_bme
--,hud.kj_lief_beleg
,SUM (verp_menge_bme/ CASE WHEN (marm.umrech_zaehler / marm.umrech_nenner) IS NOT NULL THEN ( CAST( marm.umrech_zaehler AS DEC (15,5)) / CAST( marm.umrech_nenner AS DEC (15,5)))
ELSE 1 END ) AS menge_lief_ist_kolli
FROM dbp_view.v_handling_unit_det_2 hud

JOIN dbp_view.v_besch_lief_wa_det_2 bld
ON  hud.mandant_id =bld.mandant_id
AND bld.wup_id =hud.wup_id
AND bld.handling_unit_id = hud.handling_unit_id
AND bld.handling_unit_pos_id = hud.handling_unit_pos_id
--AND hud.KJ_LIEF_BELEG = EXTRACT (YEAR FROM bld.DAT_LIEF_SOLL ) --> INC to be created, column should be populated in HUD but not crucial

JOIN dbp_view.v_art_2 mara_2
ON bld.mandant_id = mara.mandant_id
AND mara.art_id=bld.art_id

JOIN dbp_view.v_art_vorschlagswert_per_2 maw1_2
ON bld.mandant_id = maw1.mandant_id
AND maw1.art_id=bld.art_id
AND bld.dat_lief_soll BETWEEN maw1.dat_von AND maw1.dat_bis

JOIN dbp_view.v_art_umrechnung_faktor_per_2 marm_2
ON bld.mandant_id = marm.mandant_id
AND marm.art_id=bld.art_id
AND bld.dat_lief_soll BETWEEN marm.dat_von AND marm.dat_bis
-- WAUSM = 1st try, if that's empty try zzek_zlkolli:
AND marm.ALTNV_MENGE_EINH_ID = CASE WHEN TRIM(ausg_menge_einh_id) = '' THEN zl_kolli_menge_einh_id ELSE ausg_menge_einh_id END

WHERE hud.hu_typ_id=1
GROUP BY bld.mandant_id
,bld.wup_id
,bld.handling_unit_id
,bld.lief_beleg_id
,bld.dat_lief_soll
) kolli_menge_per_hu ON
bl.handling_unit_id=kolli_menge_per_hu.handling_unit_id
AND bl.mandant_id=kolli_menge_per_hu.mandant_id
AND bl.wup_id=kolli_menge_per_hu.wup_id
AND bl.lief_beleg_id=kolli_menge_per_hu.lief_beleg_id
AND bl.dat_lief_soll=kolli_menge_per_hu.dat_lief_soll*/
;