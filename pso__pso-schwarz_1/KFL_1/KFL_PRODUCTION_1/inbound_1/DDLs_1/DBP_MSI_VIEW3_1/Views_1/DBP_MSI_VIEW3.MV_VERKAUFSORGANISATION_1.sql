CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VERKAUFSORGANISATION_1 (mandant_id, verkaufsorganisation_id)
AS
   SELECT mandant_id, verkaufsorganisation_id FROM dbp_view.v_l_verkaufsorganisation_1;