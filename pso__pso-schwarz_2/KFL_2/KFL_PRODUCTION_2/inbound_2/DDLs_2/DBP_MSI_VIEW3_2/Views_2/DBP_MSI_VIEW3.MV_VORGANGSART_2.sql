CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VORGANGSART_2 (mandant_id, vorgangsart_id)
AS
   SELECT mandant_id, vorgangsart_id FROM dbp_view.v_l_vorgangsart_2;