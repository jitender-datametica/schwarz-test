CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_FAKTURAART_2 (mandant_id, fakturaart_id)
AS
   SELECT mandant_id, fakturaart_id FROM dbp_view.v_l_fakturaart_2;