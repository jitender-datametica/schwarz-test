CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_LOHNART_1
(
mandant_id
,lohnart_id

)
AS
   SELECT
   v01.mandant_id, v01.lohnart_id

   FROM dbp_view.v_l_lohnart_1 v01;