CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WBS_RUNDUNGSPROFILE_1(
	MANDANT_ID,
	RUNDUNGSPROFIL_ID,
	WBS_RELEVANT_FG,
	AUFRUNDUNG_AB_PROZENT,
	ABRUNDUNG_BIS_PROZENT,
	RUNDUNG_ZIEL_EINH_ID
) AS
--2024-02-22, AP0195159, SPEC0233442, dknop, initial
SELECT 
 mandant_id
,rundungsprofil_id
,wbs_relevant_fg
,aufrundung_ab_prozent
,abrundung_bis_prozent
,rundung_ziel_einh_id

FROM dbp_msi_data.ts_wbs_rundungsprofile_1;