CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTART_2 (mandant_id, transportart_id)
AS
   SELECT mandant_id, transportart_id
   FROM dbp_view.v_l_transportart_2;