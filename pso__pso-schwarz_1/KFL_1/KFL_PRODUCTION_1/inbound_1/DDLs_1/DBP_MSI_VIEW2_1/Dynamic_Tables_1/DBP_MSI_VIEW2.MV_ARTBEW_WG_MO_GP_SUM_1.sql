CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ARTBEW_WG_MO_GP_SUM_1
(
	BEWART_ID,
	BEWART_DET_ID,
	DIFF_EK_BRUTTO_UMS_KONZ,
	DIFF_EK_KBASIS_UMS_KONZ,
	DIFF_EK_MEP_UMS_KONZ,
	DIFF_EK_N_UMS_KONZ,
	DIFF_EK_NN_UMS_KONZ,
	DIFF_LOGKOSTENZUSCHLAG_KONZ,
	DIFF_MWST_BETRAG_UMS_KONZ,
	DIFF_NETTO_UMS_KONZ,
	EK_BRUTTO_UMSATZ,
	EK_KBASIS_UMSATZ,
	EK_MEP_UMSATZ,
	EK_N_UMSATZ,
	EK_NN_UMSATZ,
	KJMO,
	LOGKOSTENZUSCHLAG,
	MANDANT_ID,
	VK_MENGE,
	NB_ID,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	WG_ID,
	WUP_ID,
	DIFF_EK_NN2_UMS_KONZ,
	EK_NN2_UMSATZ,
	ARTHIERTYP_ID,
	EK_NETTO_BNK_UMSATZ,
	EK_NETTO_BNK_SACHK_UMSATZ,
	POSTEN_ID,
	POSTEN_KZ
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
bewart_id,
bewart_det_id,
CAST(diff_ek_brutto_konz AS NUMBER(38,5)), 
CAST(diff_ek_kal_basis_konz AS NUMBER(38,5)), 
CAST(diff_ek_mep_konz AS NUMBER(38,5)), 
CAST(diff_ek_netto_konz AS NUMBER(38,5)), 
CAST(diff_ek_nettonetto_konz AS NUMBER(38,5)), 
CAST(diff_logkostenzuschlag_konz AS NUMBER(38,5)), 
CAST(diff_umsatz_mwst_betrag_konz AS NUMBER(38,5)), 
CAST(diff_umsatz_netto_konz AS NUMBER(38,5)), 
CAST(ek_brutto AS NUMBER(38,5)), 
CAST(ek_kal_basis AS NUMBER(38,5)), 
CAST(ek_mep AS NUMBER(38,5)), 
CAST(ek_netto AS NUMBER(38,5)), 
CAST(ek_nettonetto AS NUMBER(38,5)), 
kjmo,
CAST(logkostenzuschlag AS FLOAT),
mandant_id,
CAST(menge AS FLOAT),
nb_id,
CAST(umsatz_mwst_betrag AS FLOAT),
CAST(umsatz_netto AS FLOAT),
wg_id,
wup_id,
(diff_ek_kal_basis_konz-diff_logkostenzuschlag_konz) diff_ek_nn2_ums_konz,
(ek_kal_basis-logkostenzuschlag)ek_nn2_Umsatz,
arthiertyp_id,
CAST(ek_netto_bnk  AS FLOAT),
CAST(ek_netto_bnk_sachk  AS FLOAT),
  --CAST(TRANSLATE(CASE WHEN bewart_id = 1001 AND posten_id NOT IN ('PN','PF') THEN '  ' ELSE 'PN' END USING unicode_to_latin) AS CHAR(2)) AS posten_id_
CASE WHEN BEWART_ID = 1001 AND POSTEN_ID NOT IN ('PN', 'PF', 'SP') 
     THEN '' ELSE 'PN' END :: CHAR(2) AS POSTEN_ID_,
CASE WHEN POSTEN_ID NOT IN ('PN', 'PF', 'SP') 
     THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ

FROM dbp_view.v_artbew_wg_mo_sum_1
WHERE mandant_id = 1
AND arthiertyp_id = 2;