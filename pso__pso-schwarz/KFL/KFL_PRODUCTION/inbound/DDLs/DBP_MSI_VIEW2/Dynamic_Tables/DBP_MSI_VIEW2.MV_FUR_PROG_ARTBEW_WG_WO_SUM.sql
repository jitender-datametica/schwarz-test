CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_FUR_PROG_ARTBEW_WG_WO_SUM
(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	WG_ID,
	KJWO_KL,
	MENGE_PROGNOSE,
	MENGE_PROGNOSE_BEF,
	MENGE_PROGNOSE_MAX,
	VK_MENGE,
	VK_MENGE_AF,
	VK_MENGE_SA,
	DIFF_MENGE_AF_PROGNOSE,
	SUM_PROGN_GROESSER,
	SUM_MENGE_AF_GROESSER,
	MENGE_AF_MITTEL_3WO,
	PROGN_GROESSER_WO_FG,
	MENGE_AF_GROESSER_WO_FG,
	PROGN_GROSSER_WO0_FG,
	PROGN_GROESSER_WO1_FG,
	PROGN_GROESSER_WO2_FG,
	MENGE_AF_GROESSER_WO0_FG,
	MENGE_AF_GROESSER_WO1_FG,
	MENGE_AF_GROESSER_WO2_FG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.wup_id, 
v01.nb_id, 
v01.mandant_id, 
v01.wg_id, 
v01.kjwo_kl, 
CAST(v01.menge_prognose AS DECIMAL(18,3)) AS menge_prognose, 
CAST(v01.menge_prognose_bef AS DECIMAL(18,3)) AS menge_prognose_bef, 
CAST(v01.menge_prognose_max AS DECIMAL(18,3)) AS menge_prognose_max, 
CAST(v01.menge_af + v01.menge_sa AS NUMBER(38,5)) AS menge, 
CAST(v01.menge_af AS NUMBER(38,5)) AS vk_menge_af, 
CAST(v01.menge_sa AS NUMBER(38,5)) AS vk_menge_sa, 
CAST(v01.diff_menge_af_prognose AS DECIMAL (18,3)) AS diff_menge_af_prognose, 
v01.sum_progn_groesser, v01.sum_menge_af_groesser, 
CAST(v01.menge_af_mittel_3wo AS DECIMAL(18,3)) AS menge_af_mittel_3wo, 
v01.progn_groesser_wo_fg, 
v01.menge_af_groesser_wo_fg, 
v01.progn_grosser_wo0_fg, 
v01.progn_groesser_wo1_fg, 
v01.progn_groesser_wo2_fg, 
v01.menge_af_groesser_wo0_fg, 
v01.menge_af_groesser_wo1_fg, 
v01.menge_af_groesser_wo2_fg

FROM dbp_view.v_fur_prognose_wg_wo_sum v01
WHERE v01.mandant_id = 1;