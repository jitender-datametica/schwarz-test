CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZAEHL_GRUND_1 as
   SELECT
   v01.mandant_id, v01.zaehl_grund_id, v01.spr_id, v01.zaehl_grund_bez
   FROM dbp_view.v_zaehl_grund_spr_zu_1 v01
   WHERE spr_id = 22
;