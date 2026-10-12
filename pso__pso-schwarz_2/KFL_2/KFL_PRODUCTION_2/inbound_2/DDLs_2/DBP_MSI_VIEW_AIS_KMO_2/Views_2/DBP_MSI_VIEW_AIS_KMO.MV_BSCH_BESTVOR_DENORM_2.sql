CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_BSCH_BESTVOR_DENORM_2
--27/06/2019, mcie1607, added bestellart_id
--16/10/2019,mcie1607, where clause change
--2024-03-14, dknop, adding dat_lief_soll

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
	STATUS_2,
	BEST_VOR_EINH,
	BEST_EINH,
	DISPOMERKMAL,
	BESTELLART_ID,
    DAT_LIEF_SOLL
)
AS
 SELECT
  v02.best_vor_nr,
   v02.mandant_id,
   v02.wup_id,
   v02.nb_id,
   v02.best_vor_pos,
   v02.dat_plan,
   v02.art_id,
   v02.gp_id,
   v02.menge_best_vor,
   v02.menge_best,
   v02.status_2,
   v02.best_vor_einh,
   v02.best_einh,
   v03.dispomerkmal,
   v02.bestellart_id,
   COALESCE(v02.dat_lief_soll,'1999-12-31') AS dat_lief_soll
   FROM dbp_view.v_bsch_bestvor_det_2 v02
   JOIN dbp_view.v_art_wup_status_per_2 v03
   ON v03.art_id = v02.art_id AND
   v03.wup_id = v02.wup_id AND
   v03.mandant_id = v02.mandant_id AND
   v03.nb_id = v02.nb_id
   AND
   v02.dat_plan BETWEEN v03.dat_von AND v03.dat_bis
   WHERE (NOT (menge_best = 0 AND status_2 = '0B' ))
   AND ((v02.mandant_id = 1 AND v03.dispomerkmal = '11')
   OR (v02.mandant_id <> 1 AND v03.dispomerkmal IN ('10','S2','14')))
   AND v02.nb_id NOT IN (-111)
   AND v02.mandant_id <> 1;