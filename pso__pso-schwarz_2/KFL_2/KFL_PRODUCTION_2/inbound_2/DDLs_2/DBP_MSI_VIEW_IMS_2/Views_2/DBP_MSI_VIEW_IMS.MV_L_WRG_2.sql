CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_WRG_2 AS
-- 11.04.2013 twie:: Erstellung Lookup

   SELECT
   wrg_id,
   wrg_bez
   FROM dbp_view.v_wrg_2;