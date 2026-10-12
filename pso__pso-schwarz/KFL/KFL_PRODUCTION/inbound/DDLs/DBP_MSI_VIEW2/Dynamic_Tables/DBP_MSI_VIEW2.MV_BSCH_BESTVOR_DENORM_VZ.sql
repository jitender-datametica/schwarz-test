CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_BSCH_BESTVOR_DENORM_VZ
   (
	BEST_VOR_NR,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	BEST_VOR_POS,
	DAT_PLAN,
	ART_ID,
	GP_ID,
	MENGE_BEST_VOR,
	MENGE_BEST,
	STATUS,
	BEST_VOR_EINH,
	BEST_EINH,
	DISPOMERKMAL,
	BESTELLART_ID,
	DAT_LIEF_SOLL
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
--2024-03-14, dknop, adding dat_lief_soll
   SELECT
   pos.best_vor_nr,
   pos.mandant_id,
   pos.wup_id,
   pos.nb_id,
   pos.best_vor_pos,
   pos.dat_plan,
   pos.art_id,
   pos.gp_id,
   pos.menge_best_vor,
   pos.menge_best,
   pos.status,
   pos.best_vor_einh,
   pos.best_einh,
   dispomerkmal,
   bestellart_id,
   COALESCE(dat_lief_soll,'1900-01-01') AS dat_lief_soll

   FROM dbp_view.v_bsch_bestvor_det pos

   JOIN dbp_view.v_art_wup_status_per marc
   ON marc.art_id = pos.art_id
   AND marc.wup_id = pos.wup_id
   AND marc.mandant_id = pos.mandant_id
   AND marc.nb_id =pos.nb_id

   AND pos.dat_plan BETWEEN marc.dat_von AND marc.dat_bis
   WHERE NOT (menge_best = 0 AND status = '0B' )
   AND marc.dispomerkmal IN ('10', '11', '12', '14')
   AND pos.mandant_id = 1
   AND marc.kdis = 0
   AND pos.nb_id = -111;