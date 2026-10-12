CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_VAUS_WUP_OEFFNUNG_1
(
mo_zeit_von
,mo_zeit_bis
,di_zeit_von
,di_zeit_bis
,mi_zeit_von
,mi_zeit_bis
,do_zeit_von
,do_zeit_bis
,fr_zeit_von
,fr_zeit_bis
,sa_zeit_von
,sa_zeit_bis
,so_zeit_von
,so_zeit_bis
)
AS

SELECT
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 1 THEN v02.zeit_von
   END,'00:00:00') mo_zeit_von,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 1 THEN v02.zeit_bis
   END,'00:00:00') mo_zeit_bis,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 2 THEN v02.zeit_von
   END,'00:00:00') di_zeit_von,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 2 THEN v02.zeit_bis
   END,'00:00:00') di_zeit_bis,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 3 THEN v02.zeit_von
   END,'00:00:00') mi_zeit_von,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 3 THEN v02.zeit_bis
   END,'00:00:00') mi_zeit_bis,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 4 THEN v02.zeit_von
   END,'00:00:00') do_zeit_von,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 4 THEN v02.zeit_bis
   END,'00:00:00') do_zeit_bis,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 5 THEN v02.zeit_von
   END,'00:00:00') fr_zeit_von,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 5 THEN v02.zeit_bis
   END,'00:00:00') fr_zeit_bis,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 6 THEN v02.zeit_von
   END,'00:00:00') sa_zeit_von,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 6 THEN v02.zeit_bis
   END,'00:00:00') sa_zeit_bis,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 7 THEN v02.zeit_von
   END,'00:00:00') so_zeit_von,
   COALESCE( CASE WHEN v02.wup_oeffnungs_typ_id = 7 THEN v02.zeit_bis
   END,'00:00:00') AS so_zeit_bis
    FROM dbp_view.v_vaus_wup_oeffnung_zu_per_1 v02
   WHERE
     v02.dat_bis='9999-12-31'
     AND    v02.wup_oeffnungs_typ_id BETWEEN  1 AND 7
     GROUP BY
     1,2,3,4,5,6,7,8,9,10,11,12,13,14
;