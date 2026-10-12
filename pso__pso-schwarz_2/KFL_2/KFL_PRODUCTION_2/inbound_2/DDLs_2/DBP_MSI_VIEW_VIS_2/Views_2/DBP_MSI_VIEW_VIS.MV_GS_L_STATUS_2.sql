CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_L_STATUS_2 as
   -- LOOKUP Geschenkkarten Status_2 [Transaktion]
   -- 2011KW46: Initial

   SELECT
   v01.mandant_id, v01.transaktion_id   --> Status_2
   FROM dbp_view.v_l_transaktion_2  v01
   WHERE v01.transaktion_id <> 18;