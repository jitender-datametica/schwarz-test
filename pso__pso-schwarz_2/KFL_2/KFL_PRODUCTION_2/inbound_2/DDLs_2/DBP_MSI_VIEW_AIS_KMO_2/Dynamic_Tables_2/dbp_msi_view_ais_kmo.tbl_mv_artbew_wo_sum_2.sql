CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_ARTBEW_WO_SUM_2
(
    KJWO_KL,
	ART_ID,
	MANDANT_ID,
	GP_ID,
	HERST_ID,
	NB_ID,
	WUP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	BEZUGSWEG_ID,
	EAN_KASSE,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO,
	VK_MENGE_AF,
	VK_MENGE_SA,
	DIFF_EINSTANDSPREIS_KONZ,
	DIFF_EK_NETTONETTO_KONZ,
	DIFF_UMSATZ_MWST_BETRAG_KONZ,
	DIFF_UMSATZ_NETTO_KONZ,
	EINSTANDSPREIS,
	EK_NETTONETTO,
	MENGE,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	DIFF_EK_BRUTTO_KONZ,
	DIFF_EK_GLD_KONZ,
	DIFF_EK_MEP_KONZ,
	DIFF_EK_NETTO_BNK_KONZ,
	DIFF_EK_NETTO_KONZ,
	EK_BRUTTO,
	EK_GLD,
	EK_NETTO,
	EK_NETTO_BNK,
	EK_MEP,
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
-- AP0217036, SPEC0244515 - PV hinzufuegen

-- 20231205 WUP_2 Bereinigt Berechnung voruebergehend hier berechnen. Zukuenftig soll es direkt in der ARTBEW_2 vorhanden sein  
WITH t_wup_bereinigt AS(
    SELECT DISTINCT 
        v01.KJWO_KL, 
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
    FROM DBP_DATA.TAG_2 v01
    JOIN DBP_DATA.WUP_2 v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    LEFT JOIN DBP_DATA.TAG_2 v03
        ON (v01.dat = v03.dat_vj_kt)
    LEFT JOIN DBP_DATA.TAG_2 v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
        AND v02.nb_id = 0
        AND v02.mandant_id <> 1
)

SELECT
v01.kjwo_kl,
v01.art_id,
v01.mandant_id,
v01.gp_id,
v01.herst_id,
v01.nb_id,
v01.wup_id,
v01.bewart_id,
v01.bewart_det_id,
CAST(CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS VARCHAR(2)) AS posten_id_per,
CASE WHEN v01.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per,
v01.bezugsweg_id,
v01.ean_kasse,
v02.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
v02.wup_bereinigt_fg_vj,
v02.wup_bereinigt_fg_vj_wo,
CASE WHEN v01.bewart_id IN(1001,1010) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af,
CASE WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa,
v01.diff_einstandspreis_konz,
v01.diff_ek_nettonetto_konz,
v01.diff_umsatz_mwst_betrag_konz,
v01.diff_umsatz_netto_konz,
v01.einstandspreis,
v01.ek_nettonetto,
v01.menge,
v01.umsatz_mwst_betrag,
v01.umsatz_netto,
v01.diff_ek_brutto_konz,
v01.diff_ek_gld_konz,
v01.diff_ek_mep_konz,
v01.diff_ek_netto_bnk_konz,
v01.diff_ek_netto_konz,
v01.ek_brutto,
v01.ek_gld,
v01.ek_netto,
v01.ek_netto_bnk,
v01.ek_mep,
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
FROM DBP_DATA.ARTBEW_WO_SUM_2 v01

LEFT JOIN t_wup_bereinigt v02
ON v01.KJWO_KL = v02.KJWO_KL 
AND v01.mandant_id = v02.mandant_id 
AND v01.wup_id = v02.wup_id

WHERE v01.mandant_id <> 1
--AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
--AP0227085/SPEC0284781 Filter E-Loading Artikel_2 / sschuecke 25.02.2025
AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);