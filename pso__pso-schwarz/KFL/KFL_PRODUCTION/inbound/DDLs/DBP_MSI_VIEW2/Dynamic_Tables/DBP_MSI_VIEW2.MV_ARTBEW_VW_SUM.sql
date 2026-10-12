create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW2.MV_ARTBEW_VW_SUM(
	MANDANT_ID,
	ART_ID,
	BEWART_ID,
	BEWART_DET_ID,
	GP_ID,
	HERST_ID,
	DAT,
	BEZUGSWEG_ID,
	EAN_KASSE,
	VK_MENGE,
	UMSATZ_NETTO,
	UMSATZ_MWST_BETRAG,
	EK_MEP_UMSATZ,
	EK_KL_UMSATZ,
	EK_NN_UMSATZ,
	DIFF_EK_KL_UMS_KONZ,
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
	EK_N_UMSATZ,
	EK_NETTO_BNK_UMSATZ,
	EK_NETTO_BNK_SACHK_UMSATZ,
	LOGKOSTENZUSCHLAG,
	DIFF_EK_NN2_UMS_KONZ,
	EK_NN2_UMSATZ,
	WRG_ID,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	WUP_BEREINIGT_FG,
	AKTIONSART_LISTE_ID,
	AKTION_TYP_LISTE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_AIS_DE
 as
SELECT
v1.mandant_id,
v1.art_id,
bewart_id,
bewart_det_id,
gp_id,
herst_id,
dat,
v1.bezugsweg_id,
(CASE WHEN ean_kasse BETWEEN 100000 AND 999999
      THEN ean_kasse * 10000000 -- 10 Milionen             
      ELSE ean_kasse END) AS ean_kasse,
CAST(menge AS NUMBER(38,5)),
CAST(umsatz_netto AS NUMBER(38,5)),
CAST(umsatz_mwst_betrag AS NUMBER(38,5)),
CAST(ek_mep AS NUMBER(38,5)),
CAST(einstandspreis AS NUMBER(38,5)),
CAST(ek_nettonetto AS NUMBER(38,5)),
--AP0052094, SPEC0065401
CAST(diff_einstandspreis_konz AS NUMBER(38, 5)),
CAST(diff_ek_brutto_konz AS NUMBER(38, 5)),
CAST(diff_ek_kal_basis_konz AS NUMBER(38, 5)),
CAST(diff_ek_mep_konz AS NUMBER(38, 5)),
CAST(diff_ek_netto_konz AS NUMBER(38, 5)),
CAST(diff_ek_nettonetto_konz AS NUMBER(38, 5)),
CAST(diff_logkostenzuschlag_konz AS NUMBER(38, 5)),
CAST(diff_umsatz_mwst_betrag_konz AS NUMBER(38, 5)),
CAST(diff_umsatz_netto_konz AS NUMBER(38, 5)),
CAST(ek_brutto AS NUMBER(38, 5)),
CAST(ek_kal_basis AS NUMBER(38, 5)),
CAST(ek_netto AS NUMBER(38, 5)),
CAST(ek_netto_bnk AS NUMBER(38, 5)),
CAST(ek_netto_bnk_sachk AS NUMBER(38, 5)),
CAST(logkostenzuschlag AS NUMBER(38, 5)),
CAST(diff_ek_kal_basis_konz - diff_logkostenzuschlag_konz AS NUMBER(38, 5)) diff_ek_nn2_ums_konz,
CAST(ek_kal_basis - logkostenzuschlag AS NUMBER(38,5)) ek_nn2_Umsatz,
wrg_id,
CASE WHEN BEWART_ID = 1001 AND v2.POSTEN_ID NOT IN ('PN', 'PF', 'SP') 
     THEN '' ELSE 'PN' END :: CHAR(2) AS POSTEN_ID_PER,
CASE WHEN v2.POSTEN_ID NOT IN ('PN', 'PF', 'SP') 
     THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER,
wup_bereinigt_fg,
-- AP0286861/SPEC0357601 Xtra_Coupons / prescherad 02.03.2026
aktionsart_liste_id,
aktion_typ_liste_id

FROM dbp_data.artbew_vw_sum v1

LEFT JOIN dbp_view.v_art_per v2
ON v1.art_id = v2.art_id
AND v1.mandant_id = v2.mandant_id
AND v1.dat BETWEEN v2.dat_von AND v2.dat_bis 

WHERE v1.mandant_id = 1;
