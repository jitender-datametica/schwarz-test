CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_BEWART
AS
   SELECT
   bewart_id

   FROM dbp_view.v_bewart
   WHERE bewart_id IN (1001,1002);