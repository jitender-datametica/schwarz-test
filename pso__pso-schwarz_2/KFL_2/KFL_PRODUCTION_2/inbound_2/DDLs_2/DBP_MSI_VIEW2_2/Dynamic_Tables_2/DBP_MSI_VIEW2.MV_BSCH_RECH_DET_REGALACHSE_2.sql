CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_BSCH_RECH_DET_REGALACHSE_2
(
	BSCH_ID,
	BSCH_POS_ID,
	ART_ID,
	FBB_NR,
	FACHBODEN_NR,
	FACHBODEN_POS,
	DAT,
	BEWART_ID,
	MANDANT_ID,
	NB_ID,
	GP_ID,
	BA_ID,
	BA_POS_ID,
	EK_MEP,
	STATUS_2,
	LIEF_EK_MEP_UMSATZ,
	LIEF_EK_MEP_UMSATZ_RET,
	LAGER_BEWART_ID,
	WUP_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.bsch_id, 
v01.bsch_pos_id, 
v01.art_id, 
r.fbb_nr, 
r.fachboden_nr, 
r.fachboden_pos, 
v01.dat, 
v01.bewart_id, 
v01.mandant_id, 
v01.nb_id, 
v01.gp_id, 
v01.ba_id, 
v01.ba_pos_id, 
v01.ek_mep, 
v01.status_2, 
CASE WHEN v01.lager_bewart_id IN (101, 102, 901, 902, 905, 906,913, 915) THEN v01.ek_mep END AS Lief_EK_mep_Umsatz, 
CASE WHEN v01.lager_bewart_id IN (161, 162, 907, 908, 912, 916) THEN v01.ek_mep END AS Lief_EK_mep_Umsatz_Ret, 
v01.lager_bewart_id, 
v01.wup_id

FROM dbp_view.v_bsch_rech_det_2 v01
INNER JOIN dbp_view.v_regalachse_akt_2 r
ON v01.art_id = r.art_id AND
v01.mandant_id = r.mandant_id AND
v01.wup_id = r.wup_id AND
v01.nb_id =r.nb_id

WHERE v01.mandant_id=1 AND r.mandant_id =1
AND v01.nb_id NOT IN (2,6,7)
AND v01.status_2 <> 2;