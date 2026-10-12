CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_ARTBEW_WG_TAG_SUM
(
DAT,
	WG_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	POSTEN_ID,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO,
	VK_MENGE_AF,
	VK_MENGE_SA,
	DIFF_EINSTANDSPREIS_KONZ,
	DIFF_EK_BRUTTO_KONZ,
	DIFF_EK_MEP_KONZ,
	DIFF_EK_NETTO_BNK_KONZ,
	DIFF_EK_NETTO_KONZ,
	DIFF_EK_NETTONETTO_KONZ,
	DIFF_UMSATZ_MWST_BETRAG_KONZ,
	DIFF_UMSATZ_NETTO_KONZ,
	DIFF_EK_GLD_KONZ,
	EINSTANDSPREIS,
	EK_BRUTTO,
	EK_MEP,
	EK_NETTO,
	EK_NETTO_BNK,
	EK_NETTONETTO,
	EK_GLD,
	MENGE,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE_AF_NON_LOYALTY,
	VK_MENGE_AF_LOYALTY,
	VK_MENGE_AF_LOYALTY_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	VK_MENGE_AF_NON_LOYALTY_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	VK_MENGE_AF_EXKL_SCHWARZ_MEDIA_U_BONRABATT_BBY,
	VK_MENGE_AF_LOYALTY_SCHWARZ_MEDIA,
	VK_MENGE_SA_NON_LOYALTY,
	VK_MENGE_SA_LOYALTY,
	VK_MENGE_BBY_NON_LOYALTY,
	VK_MENGE_BBY_LOYALTY,
	VK_MENGE_KDN_BBY_LOYALTY,
	VK_MENGE_KDP_BBY_LOYALTY,
	VK_MENGE_BONRABATT_BBY_NON_LOYALTY,
	VK_MENGE_BONRABATT_BBY_LOYALTY,
	VK_MENGE_BONRABATT_BBY,
	BONUSBASIS,
	BONUSBASIS_KONZ,
	EK_MEP_VOR_FWU,
	EK_MEP_VOR_FWU_KONZ,
	EK_KAL_BASIS,
	DIFF_EK_KAL_BASIS_KONZ,
	PV_AKTION,
	PV_AKTION_KONZ,
	PV_AKTION_BBY,
	PV_AKTION_BBY_KONZ,
	PV_AKTION_KDN_BBY,
	PV_AKTION_KDN_BBY_KONZ,
	PV_AKTION_KDP_BBY,
	PV_AKTION_KDP_BBY_KONZ,
	PV_BBY,
	PV_BBY_KONZ,
	PV_KDN_BBY,
	PV_KDN_BBY_KONZ,
	PV_KDP_BBY,
	PV_KDP_BBY_KONZ,
	PV_BONRABATT_BBY,
	PV_BONRABATT_BBY_KONZ,
    UMRECHNUNGSKURS_HIST
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
   AS 
-- AP0147481, SPEC0220258 - neue Bewart_id SMP 
-- AP0212516, SPEC0243813 - Anpassungen AF Kennzahlen 
-- AP0217036, SPEC0244515 - PV hinzufuegen

-- 20231205 WUP Bereinigt Berechnung voruebergehend hier berechnen. Zukuenftig soll es direkt in der ARTBEW vorhanden sein  
WITH t_wup_bereinigt AS(
    SELECT  
        v01.dat, 
        v02.mandant_id,
        v02.wup_id,
        --SPEC0256280 sschuecke 24.07.2024 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
        CASE WHEN v01.dat LIKE '%-02-29' 
            THEN wup_bereinigt_fg_vj_wo
        WHEN  (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) 
            THEN 1 
        ELSE 0 END AS wup_bereinigt_fg_vj
    FROM dbp_view.v_tag v01
    JOIN dbp_view.v_wup v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    LEFT JOIN dbp_view.v_tag v03
        ON (v01.dat = v03.dat_vj_kt)
    LEFT JOIN dbp_view.v_tag v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
        AND v02.nb_id = 0
        AND v02.mandant_id <> 1
)
SELECT
    v01.dat,
    v01.wg_id,
    v01.arthiertyp_id,
    v01.mandant_id,
    v01.nb_id,
    v01.wup_id,
    v01.bewart_id,
    v01.bewart_det_id,
    v01.posten_id,
    v02.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
    v02.wup_bereinigt_fg_vj,
    v02.wup_bereinigt_fg_vj_wo,
    CASE WHEN v01.bewart_id IN (1001,1010) THEN CAST(v01.menge AS NUMBER(38,5))  END AS vk_menge_af,
    CASE WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMBER(38,5)) END AS vk_menge_sa,
    v01.diff_einstandspreis_konz,
    v01.diff_ek_brutto_konz,
    v01.diff_ek_mep_konz,
    v01.diff_ek_netto_bnk_konz,
    v01.diff_ek_netto_konz,
    v01.diff_ek_nettonetto_konz,
    v01.diff_umsatz_mwst_betrag_konz,
    v01.diff_umsatz_netto_konz,
    v01.diff_ek_gld_konz,
    v01.einstandspreis,
    v01.ek_brutto,
    v01.ek_mep,
    v01.ek_netto,
    v01.ek_netto_bnk,
    v01.ek_nettonetto,
    v01.ek_gld,
    v01.menge,
    v01.umsatz_mwst_betrag,
    v01.umsatz_netto,
    CASE WHEN v01.bewart_det_id IN (100110,100130) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_non_loyalty,
    CASE WHEN v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_loyalty,
    CASE WHEN v01.bewart_det_id = 100111 THEN CAST(v01.menge AS NUMBER(38,5)) ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
    CASE WHEN v01.bewart_det_id = 100110 THEN CAST(v01.menge AS NUMBER(38,5)) ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
    vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby + vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
    CASE WHEN v01.bewart_det_id = 100121 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_loyalty_schwarz_media,
    CASE WHEN v01.bewart_det_id = 100210 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa_non_loyalty,
    CASE WHEN v01.bewart_det_id = 100211 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa_loyalty,
    CASE WHEN v01.bewart_det_id = 100220 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_bby_non_loyalty,
    CASE WHEN v01.bewart_det_id = 100221 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_bby_loyalty,
    CASE WHEN v01.bewart_det_id = 100231 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_kdn_bby_loyalty,
    CASE WHEN v01.bewart_det_id = 100241 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_kdp_bby_loyalty,
    CASE WHEN v01.bewart_det_id = 100130 THEN CAST(v01.menge AS NUMBER(38,5)) ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_bonrabatt_bby_non_loyalty,
    CASE WHEN v01.bewart_det_id = 100131 THEN CAST(v01.menge AS NUMBER(38,5)) ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_bonrabatt_bby_loyalty,
    vk_menge_bonrabatt_bby_non_loyalty + vk_menge_bonrabatt_bby_loyalty AS  vk_menge_bonrabatt_bby,
    v01.bonusbasis,
    v01.bonusbasis_konz,
    v01.ek_mep_vor_fwu,
    v01.ek_mep_vor_fwu_konz,
    v01.ek_kal_basis,
    v01.diff_ek_kal_basis_konz,
    v01.pv_aktion,
    v01.pv_aktion_konz,
    v01.pv_aktion_bby,
    v01.pv_aktion_bby_konz,
    v01.pv_aktion_kdn_bby,
    v01.pv_aktion_kdn_bby_konz,
    v01.pv_aktion_kdp_bby,
    v01.pv_aktion_kdp_bby_konz,
    v01.pv_bby,
    v01.pv_bby_konz,
    v01.pv_kdn_bby,
    v01.pv_kdn_bby_konz,
    v01.pv_kdp_bby,
    v01.pv_kdp_bby_konz,
    v01.pv_bonrabatt_bby,
    v01.pv_bonrabatt_bby_konz,
     v01.umrechnungskurs_hist

FROM dbp_view.v_artbew_wg_tp2_sum v01

LEFT JOIN t_wup_bereinigt v02
    ON v01.dat = v02.dat 
    AND v01.mandant_id = v02.mandant_id 
    AND v01.wup_id = v02.wup_id

WHERE v01.mandant_id <> 1
    AND v01.arthiertyp_id = 2;