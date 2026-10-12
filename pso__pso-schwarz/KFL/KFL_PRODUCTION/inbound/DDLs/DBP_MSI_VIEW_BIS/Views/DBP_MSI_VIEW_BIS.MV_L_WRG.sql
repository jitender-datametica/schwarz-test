CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_WRG as
   -- 21.02.2013 A. Lipkin Initial
   SELECT
   wrg_id,
   wrg_bez
   FROM dbp_view.v_wrg  ;