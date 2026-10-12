CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_BEWART
(
mandant_id
,mandant_kbez
,BWART

)
AS
   SELECT
   v01.mandant_id, v02.mandant_kbez, CAST(v01.lager_bewart_id as char(3)) AS BWART

   FROM dbp_view.v_l_lager_bewart v01
   INNER JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id;