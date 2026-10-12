CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTURART_INT_LU_1 as
   -- LOOKUP : Inventurart (INT)
   -- 2017.0620 : Initial, VTC Inventur_1

   SELECT DISTINCT
   v01.inventurart_int_id
   FROM dbp_view.v_l_inventurart_int_1 v01

;