CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTURART_INT_LU_2 as
   -- LOOKUP : Inventurart (INT)
   -- 2017.0620 : Initial, VTC Inventur_2

   SELECT DISTINCT
   v01.inventurart_int_id
   FROM dbp_view.v_l_inventurart_int_2 v01

;