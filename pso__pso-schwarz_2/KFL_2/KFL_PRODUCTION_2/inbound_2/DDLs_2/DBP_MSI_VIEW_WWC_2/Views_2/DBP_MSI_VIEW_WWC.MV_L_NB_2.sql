CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_NB_2
(
mandant_id
,mandant_kbez
,nb_id
,nb_bez
)
AS
   SELECT
   v02.mandant_id, v02.mandant_kbez, v01.nb_id, v01.nb_bez
   FROM dbp_view.v_nb_2 v01
   CROSS JOIN dbp_view.v_mandant_2 v02
   WHERE nb_id <> 6
   AND (mandant_id <> 1 AND nb_id NOT IN (-2,2,7))
   OR (mandant_id = 1 AND nb_id NOT IN (6));