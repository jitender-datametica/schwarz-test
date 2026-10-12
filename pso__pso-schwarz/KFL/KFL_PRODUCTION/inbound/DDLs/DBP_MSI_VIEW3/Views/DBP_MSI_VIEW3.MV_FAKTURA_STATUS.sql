CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_FAKTURA_STATUS (mandant_id, faktura_status_id)
AS
   SELECT mandant_id, faktura_status_id FROM dbp_view.v_l_fakturastatus;