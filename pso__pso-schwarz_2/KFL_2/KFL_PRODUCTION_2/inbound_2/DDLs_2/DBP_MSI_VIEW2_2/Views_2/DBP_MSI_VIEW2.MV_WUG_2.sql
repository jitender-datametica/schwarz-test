CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WUG_2 (mandant_id, arthiertyp_id,wug_id,wg_id)
AS
   SELECT 1, arthiertyp_id, wug_id, wg_id from dbp_view.v_wug_2 where mandant_id=1 and arthiertyp_id=2;