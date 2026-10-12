create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_BSCH_BESTVOR_DET_1(
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
	STATUS_1,
	BEST_VOR_EINH,
	BEST_EINH,
	DISPOMERKMAL
) as
 
	
 
SELECT
 v02.best_vor_nr
 , v02.mandant_id
 , wup.aktuell_wup_id 															AS wup_id
 , v02.nb_id
 , v02.best_vor_pos
 , v02.dat_plan
 , v02.art_id
 , v02.gp_id
 , v02.menge_best_vor
 , v02.menge_best
 , v02.status_1
 , v02.best_vor_einh
 , v02.best_einh
 , v03.dispomerkmal
 
FROM dbp_data.bsch_bestvor_det_1 v02

JOIN dbp_data.art_wup_status_per_1 v03
ON v03.art_id = v02.art_id AND
v03.wup_id = v02.wup_id AND
v03.mandant_id = v02.mandant_id AND
v03.nb_id = v02.nb_id AND
v02.dat_plan BETWEEN v03.dat_von AND v03.dat_bis

INNER JOIN dbp_view.v_wup_1 wup_1
ON v02.mandant_id = wup.mandant_id AND v02.wup_id = wup.wup_id

WHERE
(NOT (menge_best = 0 AND status_1 = '0B' ))
AND ((v02.mandant_id = 1 AND v03.dispomerkmal IN ('10', '11', '12', '14') AND v03.kdis = 0)
OR (v02.mandant_id <> 1 AND v03.dispomerkmal IN ('10','S2','14')))
AND v02.nb_id IN (-1, 0)
;
