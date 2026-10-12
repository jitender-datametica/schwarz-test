CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESTELLART_2 (mandant_id, bestellart_id)
AS
   SELECT mandant_id, bestellart_id FROM dbp_view.v_l_bestellart_2;