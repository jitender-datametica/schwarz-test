CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_BEWART_2
(
mandant_id
,mandant_kbez
,BWART

)
AS
   SELECT
   v01.mandant_id, v02.mandant_kbez, CAST(v01.lager_bewart_id as char(3)) AS BWART

   FROM dbp_view.v_l_lager_bewart_2 v01
   INNER JOIN dbp_view.v_mandant_2 v02
   ON v01.mandant_id = v02.mandant_id;