CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_WRG AS
-- 11.04.2013 twie:: Erstellung Lookup

   SELECT
   wrg_id,
   wrg_bez
   FROM dbp_view.v_wrg;