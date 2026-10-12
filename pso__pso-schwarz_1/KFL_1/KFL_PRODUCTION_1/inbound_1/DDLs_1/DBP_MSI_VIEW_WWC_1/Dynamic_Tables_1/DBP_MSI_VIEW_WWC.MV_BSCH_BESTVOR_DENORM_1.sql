CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_BSCH_BESTVOR_DENORM_1
-- AP0032822, SPEC0041631 - 31.10.2108, mkub1811 neue View
(
best_vor_nr
,mandant_id
,wup_id
,nb_id
,best_vor_pos
,dat_plan
,art_id
,gp_id
,menge_best_vor
,menge_best
,status_1
,best_vor_einh
,best_einh
,dispomerkmal
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
   SELECT
  v02.best_vor_nr, v02.mandant_id, v02.wup_id, v02.nb_id, v02.best_vor_pos, v02.dat_plan, v02.art_id, v02.gp_id, v02.menge_best_vor, v02.menge_best, v02.status_1, v02.best_vor_einh, v02.best_einh, v03.dispomerkmal
   FROM dbp_view.v_bsch_bestvor_det_1 v02
   JOIN dbp_view.v_art_wup_status_per_1 v03
   ON v03.art_id = v02.art_id AND
   v03.wup_id = v02.wup_id AND
   v03.mandant_id = v02.mandant_id AND
   v03.nb_id = v02.nb_id
   AND
   v02.dat_plan BETWEEN v03.dat_von AND v03.dat_bis
   WHERE (NOT (menge_best = 0 AND status_1 = '0B' ))
   AND ((v02.mandant_id = 1 AND v03.dispomerkmal = '11')
   OR (v02.mandant_id <> 1 AND v03.dispomerkmal = 'S2'))
   AND v02.nb_id NOT IN (-111);