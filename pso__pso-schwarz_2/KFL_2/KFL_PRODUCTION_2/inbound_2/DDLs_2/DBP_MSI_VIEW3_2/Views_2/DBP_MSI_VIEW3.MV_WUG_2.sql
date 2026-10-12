CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WUG_2
(mandant_id, arthiertyp_id, wug_id, wg_id)
AS
   SELECT 1, arthiertyp_id, wug_id, wg_id
   FROM dbp_view.v_wug_2
   WHERE arthiertyp_id=2;