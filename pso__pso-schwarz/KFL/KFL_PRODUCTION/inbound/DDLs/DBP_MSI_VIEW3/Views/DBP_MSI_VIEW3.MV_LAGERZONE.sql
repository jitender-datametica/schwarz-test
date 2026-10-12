CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGERZONE (lagerzone_id, mandant_id)
AS
   SELECT lagerzone_id, mandant_id FROM dbp_view.v_l_lagerzone;