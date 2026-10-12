CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTURART_INT_HWG_ZU as
   -- LOOKUP-ZUORDNUNG : Inventurart (INT) pro HWG
   -- haendisch zugeordnet
   -- 2017.0620 : Initial, VTC Inventur
   -- 2017.0815 : Update

   SELECT DISTINCT
   lia.inventurart_int_id * 100 + wgh.wg_hierarchie_id::INTEGER AS inventur_hwg_id, lia.inventurart_int_id                               AS inventurart_int_id, wgh.wg_hierarchie_id                                 AS hwg_id
   FROM dbp_view.v_wg_hierarchie_zu_per  wgh
   CROSS JOIN dbp_view.v_l_inventurart_int  lia

   WHERE wgh.arthiertyp_id = 5 AND wgh.wg_hierarchie_ebene_id = 3 -- HWG
   AND wgh.dat_bis = '9999-12-31'

   GROUP BY 1,2,3
   ;