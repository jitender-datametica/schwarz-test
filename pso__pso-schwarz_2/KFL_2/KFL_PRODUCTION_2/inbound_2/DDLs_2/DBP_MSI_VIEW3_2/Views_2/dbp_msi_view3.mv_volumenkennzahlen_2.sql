CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VOLUMENKENNZAHLEN_2(
	HANDLING_UNIT_ID_EXT,
	HANDLING_UNIT_ID,
	HU_STATUS_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	TRAEGERTYP_BEZ,
	HU_AUFGEPACKT,
	LIEF_BELEG_ID,
	KJ_LIEF_BELEG,
	WUP_ID,
	LAGERNUMMER_ID,
	MANDANT_ID,
	NB_ID,
	DAT_LIEF_SOLL,
	LIEF_TYP_ID,
	LIEF_PAL_TYP_ID,
	WERBEWARE_ID,
	WG_VERKETT_LIEF,
	WG_VERKETT_FG,
	WG_VERKETT_HIER_ID,
	PALETTENVOLUMEN_WGRVK,
	PALETTENVOLUMEN_HIERARCHIE,
	MENGE_HANDLING_KOLLI_ORIG,
	NETTO_VOL_LADUNG,
	THEORETISCHES_SAP_VOLUMEN,
	BRTVOL_LADUNG_GEDECKELT
) AS
-- 2021-09-03,dknop, AP0092673, SPEC0123445, initial
-- 2021-09-07, dknop, AP0092673, SPEC0123445, adding hu_status_id,lief_typ_id 
-- 2021-09-15, dknop, AP0092673, SPEC0123445, adding theoretisches_SAP_volumen
-- 2021-09-15, dknop, AP0092673, SPEC0123445, changing wup_id to be taken from hu
-- 2021-09-15, dknop, AP0092673, SPEC0123445, zero if null for wgver.wg_verkett_hier_id
-- 2021-09-15, dknop, AP0092673, SPEC0123445, adding palletengroesse_einh_id for logic for theoretisches_SAP_volumen
-- 2021-11-26, dknop, AP0092673, SPEC0123445, adding hu_aufgepackt
-- 2021-11-29, dknop, AP0092673, SPEC0123445, changing to use in joins for wup_id dbp_view.v_handling_unit_2 instead of dbp_view.v_besch_lief_2
-- 2021-12-15, dknop, AP0092673, SPEC0123445, minor formatting
-- 2021-12-16, dknop, AP0092673, SPEC0123445, removing zero if null for wgver.wg_verkett_hier_id
-- 2021-12-20, dknop, AP0092673, SPEC0123445, correcting logic for palettenvolumen_WGRVK, palettenvolumen_hierarchie
-- 2021-12-21, dknop, AP0092673, SPEC0123445, correcting joins - adding mandnat_id
-- 2022-01-10, dknop, AP0092673, SPEC0123445, adding kunde
-- 2022-01-11, dknop, AP0092673, SPEC0123445, updating palettenvolumen_WGRVK, palettenvolumen_hierarchie, correcting kunde_id
-- 2022-06-08, dknop, AP0092673, SPEC0123445, change to take lagernummer_id from mv_handling_unit_2, adding mandant_id to join to besch_lief_2
--2024-01-31, INC7963291, dknop, change kunde_id 
--2024-06-04, dknop, INC8699508, AND bl.lief_pal_typ_id = '9' in palettenvolumen_hierarchie, palettenvolumen_WGRVK
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-09, dknop, change to left join with dbp_view.v_wup_2
--2025-06-06, AP0277469 dknop, Adjustments for pallet typ 6 for theoretisches_sap_volumen
SELECT
 hu.handling_unit_id_ext
,hu.handling_unit_id
,hu.hu_status_id
,bl.mandant_id_kunde
--,CASE WHEN TRY_CAST(bl.kunde_id AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(bl.kunde_id AS INTEGER) END kunde_id
, CASE WHEN TRY_CAST(bl.kunde_id AS INTEGER) IS NULL THEN -3 ELSE w.aktuell_wup_id END kunde_id
,CASE WHEN hu.versandeinheit_id NOT IN (1,-1) THEN 'AUFGEPACKT'
   WHEN hu.versandeinheit_id = -1 THEN 'NORMAL'
   WHEN hu.versandeinheit_id = 1 THEN 'TRÄGER'
END AS traegertyp_bez
,CASE WHEN hu.versandeinheit_id NOT IN (1,-1) THEN 1
   ELSE 0 END AS hu_aufgepackt
,hu.lief_beleg_id
,hu.kj_lief_beleg
,hu.wup_id
,hu.lagernummer_id
,hu.mandant_id
,hu.nb_id
,bl.dat_lief_soll
,bl.lief_typ_id
,bl.lief_pal_typ_id
,bl.werbeware_id
,bl.wg_verkett_lief
,bl.wg_verkett_fg
,CASE WHEN bl.wg_verkett_fg=1 THEN TO_CHAR(wgver.wg_verkett_hier_id) ELSE '' END AS wg_verkett_hier_id
,CASE WHEN volwarerk.klapp_pal_fg=1 AND (CASE WHEN volwarerk.palettengroesse_einh_id='CM' THEN volwarerk.palettenvolumen/1000
                                         ELSE volwarerk.palettenvolumen END)>800 AND bl.lief_pal_typ_id = '9' THEN volwarerk.palettenvolumen/2 ELSE volwarerk.palettenvolumen END AS palettenvolumen_WGRVK
,CASE WHEN volwarerkhie.klapp_pal_fg=1  AND (CASE WHEN volwarerkhie.palettengroesse_einh_id='CM' THEN volwarerkhie.palettenvolumen/1000
                                         ELSE volwarerkhie.palettenvolumen END)>800 AND bl.lief_pal_typ_id = '9' THEN volwarerkhie.palettenvolumen/2 ELSE volwarerkhie.palettenvolumen END AS palettenvolumen_hierarchie
,hu.menge_handling_kolli_orig
,CASE WHEN hu.vol_ladung > 2304 THEN 2304 ELSE hu.vol_ladung END AS netto_vol_ladung
--,CASE WHEN bl.wg_verkett_fg=1 THEN volwarerkhie.palettenvolumen ELSE volwarerk.palettenvolumen END AS theoretisches_SAP_volumen
/*,CASE WHEN bl.wg_verkett_fg=1 THEN (CASE WHEN volwarerkhie.palettengroesse_einh_id='CM' THEN palettenvolumen_hierarchie/1000
                                         ELSE palettenvolumen_hierarchie END)
                                 ELSE (CASE WHEN volwarerk.palettengroesse_einh_id='CM' THEN palettenvolumen_WGRVK/1000
                                         ELSE palettenvolumen_WGRVK END) END AS theoretisches_SAP_volumen  */
,CASE
    WHEN lief_pal_typ_id = '6' AND MAX_VOLUMEN_AUFPACKPAL / 1000 != 0 THEN MAX_VOLUMEN_AUFPACKPAL / 1000
    WHEN bl.wg_verkett_fg = 1 THEN 
        CASE 
            WHEN volwarerkhie.palettengroesse_einh_id = 'CM' THEN palettenvolumen_hierarchie / 1000
            ELSE palettenvolumen_hierarchie
        END
    ELSE 
        CASE 
            WHEN volwarerk.palettengroesse_einh_id = 'CM' THEN palettenvolumen_WGRVK / 1000
            ELSE palettenvolumen_WGRVK
        END
END AS theoretisches_SAP_volumen

,hu.brtvol_ladung_gedeckelt

FROM dbp_view.v_handling_unit_2 hu
JOIN dbp_view.v_besch_lief_2 bl ON 
hu.lief_beleg_id=bl.lief_beleg_id
AND hu.kj_lief_beleg=bl.kj
AND hu.mandant_id=bl.mandant_id

LEFT JOIN dbp_view.v_wup_2 w
   ON w.mandant_id = CASE WHEN bl.mandant_id_kunde IS NULL OR bl.mandant_id_kunde = 0 THEN bl.mandant_id ELSE bl.mandant_id_kunde END
   AND w.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((w.nb_id IN (2, 0, -111) AND w.wup_id > 0) OR (w.nb_id = -1 AND w.wup_id = 0))

LEFT JOIN dbp_view.v_wg_verkettung_hierarchie_zu_per_2 wgver ON 
hu.wup_id =wgver.wup_id 
AND hu.mandant_id=wgver.mandant_id
AND bl.wg_verkett_lief=wgver.wg_verkett_id--
AND bl.dat_lief_soll BETWEEN wgver.dat_von AND wgver.dat_bis

LEFT JOIN dbp_view.v_wg_verkettung_per_2 volwarerk ON 
hu.wup_id =volwarerk.wup_id 
AND hu.mandant_id=volwarerk.mandant_id
AND bl.wg_verkett_lief=volwarerk.wg_verkett_id
AND bl.dat_lief_soll BETWEEN volwarerk.dat_von AND volwarerk.dat_bis

LEFT JOIN dbp_view.v_wup_wg_verkettung_hierarchie_per_2 volwarerkhie ON 
hu.wup_id =volwarerkhie.wup_id
AND hu.mandant_id=volwarerkhie.mandant_id
AND wgver.wg_verkett_hier_id=volwarerkhie.wg_verkett_hier_id--
AND bl.dat_lief_soll BETWEEN volwarerkhie.dat_von AND volwarerkhie.dat_bis

;