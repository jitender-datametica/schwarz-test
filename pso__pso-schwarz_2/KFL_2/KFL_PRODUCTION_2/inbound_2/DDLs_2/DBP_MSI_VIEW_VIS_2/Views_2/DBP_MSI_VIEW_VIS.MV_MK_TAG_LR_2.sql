CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MK_TAG_LR_2 as
   SELECT
   t01.dat dat, (ROW_NUMBER () OVER (ORDER BY t01.dat DESC NULLS LAST) -1) *(-1) akt_tag_lr
   FROM dbp_view.v_mk_zeroverkauf_2 t01
   GROUP BY 1
;