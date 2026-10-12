CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_L_DATUMSART_1
(
mandant_id
, datumsart_id
)
AS
   SELECT
   v01.mandant_id, v01.datumsart_id

   FROM dbp_view.v_l_datumsart_1 v01;