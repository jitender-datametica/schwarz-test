CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ABSCHRIFTART_THEMA_INT_LU_1 as
   -- LOOKUP Abschriftart Thema Int
   -- 2017.0221 : Initial

   SELECT
   atil.abschriftart_thema_int_id
   FROM dbp_view.v_l_abschriftart_thema_int_1 atil
;