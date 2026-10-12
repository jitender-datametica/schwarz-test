CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_FUR_PROGNOSE_ARTBEW_WG_SUM_1
(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	WG_ID,
	DAT,
	MENGE_PROGNOSE,
	MENGE_PROGNOSE_BEF,
	MENGE_PROGNOSE_MAX,
	VK_MENGE,
	VK_MENGE_AF,
	VK_MENGE_SA,
	DIFF_MENGE_AF_PROGNOSE
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.wup_id, 
v01.nb_id, 
v01.mandant_id, 
v01.wg_id, 
v01.dat, 
CAST(v01.menge_prognose AS DECIMAL(18,3)) AS menge_prognose, 
CAST(v01.menge_prognose_bef AS DECIMAL(18,3)) AS menge_prognose_bef, 
CAST(v01.menge_prognose_max AS DECIMAL(18,3)) AS menge_prognose_max, 
CAST(v01.menge_af + v01.menge_sa AS NUMBER(38,5)) AS menge, 
CAST(v01.menge_af AS NUMBER(38,5)) AS vk_menge_af, 
CAST(v01.menge_sa AS NUMBER(38,5)) AS vk_menge_sa, 
CAST(v01.diff_menge_af_prognose AS DECIMAL (18,3)) AS diff_menge_af_prognose

FROM dbp_view.v_fur_prognose_wg_sum_1 v01
WHERE v01.mandant_id = 1;
