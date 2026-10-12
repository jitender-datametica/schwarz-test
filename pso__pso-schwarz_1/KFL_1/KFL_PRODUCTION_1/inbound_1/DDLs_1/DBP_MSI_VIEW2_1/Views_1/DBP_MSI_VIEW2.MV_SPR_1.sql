CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_SPR_1 (spr_id,spr_name,spr_iso,dwh_spr)
AS
   SELECT spr_id, spr_name, spr_iso, dwh_spr from dbp_view.v_spr_1 where spr_id=22;