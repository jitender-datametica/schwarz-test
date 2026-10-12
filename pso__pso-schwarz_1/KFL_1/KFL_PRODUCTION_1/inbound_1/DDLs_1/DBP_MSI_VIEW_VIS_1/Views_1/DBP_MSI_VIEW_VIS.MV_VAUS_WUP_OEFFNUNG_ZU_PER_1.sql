CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VAUS_WUP_OEFFNUNG_ZU_PER_1
(
wup_id
,mandant_id
,mo_zeit_von
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
,heute_zeit_bis
)
AS
   -- Anpassungen mit snowconvert sind notwenig, da TD komischerweise in dieser view die timestamps implizit zu Integers konvertiert
   SELECT v01.wup_id, v01.mandant_id,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 1 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_von)
   END ) mo_zeit_von,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 1 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_bis)
   END ) mo_zeit_bis,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 2 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_von)
   END ) di_zeit_von,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 2 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_bis)
   END ) di_zeit_bis,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 3 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_von)
   END ) mi_zeit_von,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 3 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_bis)
   END ) mi_zeit_bis,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 4 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_von)
   END ) do_zeit_von,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 4 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_bis)
   END ) do_zeit_bis,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 5 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_von)
   END ) fr_zeit_von,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 5 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_bis)
   END ) fr_zeit_bis,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 6 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_von)
   END ) sa_zeit_von,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 6 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_bis)
   END ) sa_zeit_bis,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 7 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_von)
   END ) so_zeit_von,
   MAX(
   CASE WHEN v02.wup_oeffnungs_typ_id = 7 THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_bis)
   END ) so_zeit_bis,
   MAX(CASE WHEN DAYOFWEEKISO ("CURRENT_DATE") = v02.wup_oeffnungs_typ_id THEN SNOWCONVERT.PUBLIC.TIME_TO_INT_UDF(v02.zeit_bis)
   END) AS heute_zeit_bis

   FROM dbp_view.v_wup_1 v01
   LEFT OUTER JOIN dbp_view.v_vaus_wup_oeffnung_zu_per_1 v02
   ON       v01.wup_id = v02.wup_id
   AND    v01.mandant_id = v02.mandant_id
   AND  v02.dat_bis='9999-12-31'
   AND  v02.wup_oeffnungs_typ_id BETWEEN  1 AND 7
   GROUP BY v01.wup_id, v01.mandant_id
   ;