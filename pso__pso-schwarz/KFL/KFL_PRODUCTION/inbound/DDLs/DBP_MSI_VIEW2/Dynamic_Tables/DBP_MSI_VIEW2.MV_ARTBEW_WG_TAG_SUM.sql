create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW2.MV_ARTBEW_WG_TAG_SUM(
	DAT,
	WG_ID,
	ARTHIERTYP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DIFF_LOGKOSTENZUSCHLAG_KONZ,
	DIFF_EK_BRUTTO_UMS_KONZ,
	DIFF_EK_KBASIS_UMS_KONZ,
	DIFF_EK_MEP_UMS_KONZ,
	DIFF_EK_N_UMS_KONZ,
	DIFF_EK_NN_UMS_KONZ,
	DIFF_MWST_BETRAG_UMS_KONZ,
	DIFF_NETTO_UMS_KONZ,
	EK_BRUTTO_UMSATZ,
	EK_KBASIS_UMSATZ,
	EK_MEP_UMSATZ,
	EK_N_UMSATZ,
	EK_NN_UMSATZ,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	VK_MENGE_OHNE_PSEUDO,
	DIFF_EK_NN2_UMS_KONZ,
	DIFF_EK_KL_UMS_KONZ,
	EK_KL_UMSATZ,
	EK_NN2_UMSATZ,
	LOGKOSTENZUSCHLAG,
	EK_NETTO_BNK_UMSATZ,
	EK_NETTO_BNK_SACHK_UMSATZ,
	POSTEN_ID,
	POSTEN_KZ,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO,
	AKTIONSART_LISTE_ID,
	AKTION_TYP_LISTE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_DE
 as
-- 20231205 WUP Bereinigt Berechnung voruebergehend hier berechnen. Zukuenftig soll es direkt in der ARTBEW vorhanden sein  
WITH t_wup_bereinigt AS(
    SELECT
        v01.dat, 
        v02.mandant_id,
        v02.wup_id,
        --SPEC0256280 sschuecke 24.07.2024 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo
    FROM dbp_view.v_tag v01
    JOIN dbp_view.v_wup v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    JOIN dbp_view.v_tag v03
        ON (v01.dat = v03.dat_vj_kt)
    JOIN dbp_view.v_tag v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
        AND v02.nb_id = 0
        AND v02.mandant_id = 1
)

SELECT
v1.dat,
v1.wg_id,
v1.arthiertyp_id,
v1.bewart_id,
v1.bewart_det_id,
v1.mandant_id,
v1.wup_id,
v1.nb_id,
CAST(v1.DIFF_LOGKOSTENZUSCHLAG_KONZ AS NUMBER(38,5)) ,
       CAST(v1.DIFF_EK_BRUTTO_KONZ AS NUMBER(38,5)) ,
       CAST(v1.DIFF_EK_KAL_BASIS_KONZ AS NUMBER(38,5)) ,
       CAST(v1.DIFF_EK_MEP_KONZ AS NUMBER(38,5)) ,
       CAST(v1.DIFF_EK_NETTO_KONZ AS NUMBER(38,5)) ,
       CAST(v1.DIFF_EK_NETTONETTO_KONZ AS NUMBER(38,5)) ,
       CAST(v1.DIFF_UMSATZ_MWST_BETRAG_KONZ AS NUMBER(38,5)) ,
       CAST(v1.DIFF_UMSATZ_NETTO_KONZ AS NUMBER(38,5)) ,
       CAST(v1.EK_BRUTTO AS NUMBER(38,5)) ,
       CAST(v1.EK_KAL_BASIS AS NUMBER(38,5)) ,
       CAST(v1.EK_MEP AS NUMBER(38,5)) ,
       CAST(v1.EK_NETTO AS NUMBER(38,5)) ,
       CAST(v1.EK_NETTONETTO AS NUMBER(38,5)) ,
       CAST(v1.UMSATZ_MWST_BETRAG AS NUMBER(38,5)) ,
       CAST(v1.UMSATZ_NETTO AS NUMBER(38,5)) ,
       CAST(v1.MENGE AS NUMBER(38,5)) ,
       CAST(v1.MENGE_OHNE_WG_ERF_ART AS NUMBER(38,5)) ,
       CAST((v1.DIFF_EK_KAL_BASIS_KONZ-v1.DIFF_LOGKOSTENZUSCHLAG_KONZ) AS NUMBER(38,5)) DIFF_EK_NN2_UMS_KONZ ,
       CAST(v1.DIFF_EINSTANDSPREIS_KONZ AS NUMBER(38,5)) ,
       CAST(v1.EINSTANDSPREIS AS NUMBER(38,5)) ,
       CAST((v1.EK_KAL_BASIS-v1.LOGKOSTENZUSCHLAG) AS NUMBER(38,5)) EK_NN2_UMSATZ ,
       CAST(v1.LOGKOSTENZUSCHLAG AS NUMBER(38,5)) ,
       CAST(v1.EK_NETTO_BNK AS NUMBER(38,5)) ,
       CAST(v1.EK_NETTO_BNK_SACHK AS NUMBER(38,5)) ,
       CASE WHEN v1.BEWART_ID = 1001 AND v1.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN '' ELSE 'PN' END :: CHAR(2) AS POSTEN_ID_,
/*,CASE
WHEN bewart_id = 1001 AND posten_id <> 'PN'
THEN ' '
ELSE 'PN'
END AS posten_id*/
CASE WHEN v1.POSTEN_ID NOT IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ,
v2.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
v2.wup_bereinigt_fg_vj,
v2.wup_bereinigt_fg_vj_wo,
-- AP0286861/SPEC0357601 Xtra_Coupons / prescherad 02.03.2026
aktionsart_liste_id,
aktion_typ_liste_id

FROM dbp_data.artbew_wg_tp2_sum v1

LEFT JOIN t_wup_bereinigt v2
ON v1.dat = v2.dat 
AND v1.mandant_id = v2.mandant_id 
AND v1.wup_id = v2.wup_id

WHERE v1.mandant_id = 1
AND v1.arthiertyp_id = 2;
