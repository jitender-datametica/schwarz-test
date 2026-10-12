CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_BEZUGSWEG_2
(
mandant_id
,BWSCL
,mandant_kbez
)
AS
   SELECT
   v01.mandant_id, v01.bezugsweg_id AS BWSCL, v02.mandant_kbez
   FROM dbp_view.v_l_bezugsweg_2 v01
   INNER JOIN dbp_view.v_mandant_2 v02
   ON v01.mandant_id = v02.mandant_id
   WHERE v01.mandant_id <> 1
   ;