CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_BSCH_BESTVOR_DET_2
   (
	BEST_VOR_NR,
	BEST_VOR_POS,
	MANDANT_ID,
	DAT_PLAN,
	ART_ID,
	GP_ID,
	MENGE_BEST_VOR,
	MENGE_BEST,
	STATUS_2,
	BEST_VOR_EINH,
	BEST_EINH,
	BESTELLART_ID,
	DISPOMERKMAL,
	DAT_LIEF_SOLL
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
--2024-03-14, dknop, adding dat_lief_soll
   SELECT
   v01.best_vor_nr,
   v01.best_vor_pos,
   v01.mandant_id, 
   v01.dat_plan,
   v01.art_id,
   v01.gp_id,
   v01.menge_best_vor,
   v01.menge_best,
   v01.status_2,
   v01.best_vor_einh,
   v01.best_einh,
   v01.bestellart_id, 
   v02.dispomerkmal,
   COALESCE(dat_lief_soll,'1900-01-01') AS dat_lief_soll
   
   FROM dbp_view.v_bsch_bestvor_det_2 v01
   JOIN dbp_view.v_art_wup_status_per_2 v02
   ON v01.art_id = v02.art_id AND
   v01.wup_id = v02.wup_id AND
   v01.mandant_id = v02.mandant_id AND
   v01.nb_id = v02.nb_id
   WHERE v02.dat_bis = '9999-12-31';
