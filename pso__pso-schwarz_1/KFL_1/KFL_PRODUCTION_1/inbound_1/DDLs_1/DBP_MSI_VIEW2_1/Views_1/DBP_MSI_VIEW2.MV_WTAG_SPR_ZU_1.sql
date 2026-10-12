CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WTAG_SPR_ZU_1  (wtag_id  ,spr_id, wtag_bez)
AS
   SELECT wtag_id, spr_id, wtag_bez from dbp_view.v_wtag_spr_zu_1 where spr_id=22;