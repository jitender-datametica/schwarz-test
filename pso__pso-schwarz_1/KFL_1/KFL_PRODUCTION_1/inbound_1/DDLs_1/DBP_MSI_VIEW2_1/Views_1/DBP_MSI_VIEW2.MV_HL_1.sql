CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_HL_1 (hl_id , hl_name,mandant_id)
AS
   SELECT hl_id, hl_name, mandant_id from dbp_view.v_hl_1 where mandant_id=1;