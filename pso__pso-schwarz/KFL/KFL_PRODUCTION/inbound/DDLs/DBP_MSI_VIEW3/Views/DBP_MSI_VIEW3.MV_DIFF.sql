CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_DIFF (mandant_id, diff_id)
AS
   SELECT mandant_id, diff_id FROM dbp_view.v_l_kz_differenz;