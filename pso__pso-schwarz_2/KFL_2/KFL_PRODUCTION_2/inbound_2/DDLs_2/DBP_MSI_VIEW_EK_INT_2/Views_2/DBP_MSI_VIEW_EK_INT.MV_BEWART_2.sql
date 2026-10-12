CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_BEWART_2
AS
   SELECT
   bewart_id

   FROM dbp_view.v_bewart_2
   WHERE bewart_id IN (1001,1002);