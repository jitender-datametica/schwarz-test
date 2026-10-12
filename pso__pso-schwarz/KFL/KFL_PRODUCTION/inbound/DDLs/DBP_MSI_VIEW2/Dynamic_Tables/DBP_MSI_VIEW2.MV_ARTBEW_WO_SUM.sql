create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW2.MV_ARTBEW_WO_SUM(
	KJWO_KL,
	ART_ID,
	AKTION_ID,
	BEWART_ID,
	BEWART_DET_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	EAN_KASSE,
	HERST_ID,
	DIFF_EK_NN_UMS_KONZ,
	DIFF_MWST_BETRAG_UMS_KONZ,
	DIFF_NETTO_UMS_KONZ,
	EK_MEP_UMSATZ,
	EK_NN_UMSATZ,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	DIFF_EK_KL_UMS_KONZ,
	EK_KL_UMSATZ,
	DIFF_EK_BRUTTO_UMS_KONZ,
	DIFF_EK_KBASIS_UMS_KONZ,
	DIFF_EK_MEP_UMS_KONZ,
	DIFF_EK_N_UMS_KONZ,
	DIFF_LOGKOSTENZUSCHLAG_KONZ,
	EK_BRUTTO_UMSATZ,
	EK_KBASIS_UMSATZ,
	EK_N_UMSATZ,
	EK_NETTO_BNK_UMSATZ,
	EK_NETTO_BNK_SACHK_UMSATZ,
	LOGKOSTENZUSCHLAG,
	DIFF_EK_NN2_UMS_KONZ,
	EK_NN2_UMSATZ,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO,
	AKTIONSART_LISTE_ID,
	AKTION_TYP_LISTE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_DE
 as
-- 20231205 WUP Bereinigt Berechnung voruebergehend hier berechnen. Zukuenftig soll es direkt in der ARTBEW vorhanden sein  
WITH t_wup_bereinigt AS(
    SELECT DISTINCT 
        v01.KJWO_KL, 
        v02.mandant_id,
        v02.wup_id,
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.UMZUGSFILIALE_FG = 1)) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.UMZUGSFILIALE_FG = 1)) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
        CASE WHEN v01.dat LIKE '%-02-29' 
            THEN wup_bereinigt_fg_vj_wo
        WHEN  (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.UMZUGSFILIALE_FG = 1)) 
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
        AND v02.mandant_id = 1
)

SELECT
v1.kjwo_kl,
v1.art_id,
COALESCE (v1.standard_aktion_id, v1.aktion_id, '0') AS aktion_id,
v1.bewart_id,
v1.bewart_det_id,
v1.mandant_id,
v1.wup_id,
v1.nb_id,
v1.gp_id,
(CASE             
 WHEN v1.ean_kasse BETWEEN 100000 AND 999999 THEN v1.ean_kasse * 10000000 -- 10 Milionen  
 ELSE v1.ean_kasse END) AS ean_kasse,
v1.herst_id,
CAST(v1.diff_ek_nettonetto_konz AS NUMBER(38,5)),
CAST(v1.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5)),
CAST(v1.diff_umsatz_netto_konz AS NUMBER(38,5)),
CAST(v1.ek_mep AS NUMBER(38,5)),
CAST(v1.ek_nettonetto AS NUMBER(38,5)),
CAST(v1.umsatz_mwst_betrag AS NUMBER(38,5)),
CAST(v1.umsatz_netto AS NUMBER(38,5)),
CAST(v1.menge AS NUMBER(38,5)),
CAST(v1.diff_einstandspreis_konz AS NUMBER(38,5)),
CAST(v1.einstandspreis AS NUMBER(38,5)),
--AP0052094, SPEC0065401
CAST(v1.diff_ek_brutto_konz AS NUMBER(38,5)),
CAST(v1.diff_ek_kal_basis_konz AS NUMBER(38, 5)),
CAST(v1.diff_ek_mep_konz AS NUMBER(38, 5)),
CAST(v1.diff_ek_netto_konz AS NUMBER(38, 5)),
CAST(v1.diff_logkostenzuschlag_konz AS NUMBER(38, 5)),
CAST(v1.ek_brutto AS NUMBER(38, 5)),
CAST(v1.ek_kal_basis AS NUMBER(38, 5)),
CAST(v1.ek_netto AS NUMBER(38, 5)),
CAST(v1.ek_netto_bnk AS NUMBER(38, 5)),
CAST(v1.ek_netto_bnk_sachk AS NUMBER(38, 5)),
CAST(v1.logkostenzuschlag AS NUMBER(38, 5)),
CAST(v1.diff_ek_kal_basis_konz - v1.diff_logkostenzuschlag_konz AS NUMBER(38,5)) diff_ek_nn2_ums_konz,
CAST(v1.ek_kal_basis - v1.logkostenzuschlag AS NUMBER(38,5)) ek_nn2_Umsatz,
v2.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
v2.wup_bereinigt_fg_vj,
v2.wup_bereinigt_fg_vj_wo,
 -- AP0286861/SPEC0357601 Xtra_Coupons / prescherad 02.03.2026
v1.aktionsart_liste_id,
v1.aktion_typ_liste_id,

FROM dbp_view.v_artbew_wo_sum v1

LEFT JOIN t_wup_bereinigt v2
ON v1.KJWO_KL = v2.KJWO_KL 
AND v1.mandant_id = v2.mandant_id 
AND v1.wup_id = v2.wup_id

WHERE v1.mandant_id = 1;
