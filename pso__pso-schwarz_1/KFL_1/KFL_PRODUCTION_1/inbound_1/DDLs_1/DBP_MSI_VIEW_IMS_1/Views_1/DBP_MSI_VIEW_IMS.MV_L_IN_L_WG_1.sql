CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IN_L_WG_1 AS
-- 31.05.2013 twie Erstellung Lookup für Warengruppe

   SELECT
   v01.in_wg_id,
   v01.mandant_id

  FROM dbp_view.v_in_l_wg_1 v01
;