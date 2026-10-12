CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_SOND_BEST_2 (mandant_id, sond_best_id)
AS
   SELECT mandant_id, sond_best_id FROM dbp_view.v_l_sond_best_2;