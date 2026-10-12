CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_HL_2 (hl_id , hl_name,mandant_id)
AS
   SELECT hl_id, hl_name, mandant_id from dbp_view.v_hl_2 where mandant_id=1;