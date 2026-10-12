CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTURART_INT_LU as
   -- LOOKUP : Inventurart (INT)
   -- 2017.0620 : Initial, VTC Inventur

   SELECT DISTINCT
   v01.inventurart_int_id
   FROM dbp_view.v_l_inventurart_int v01

;