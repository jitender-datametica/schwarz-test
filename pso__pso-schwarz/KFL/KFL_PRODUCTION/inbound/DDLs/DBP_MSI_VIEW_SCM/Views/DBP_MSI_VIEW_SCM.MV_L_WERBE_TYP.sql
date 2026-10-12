CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_WERBE_TYP as
   SELECT DISTINCT
  werbe_typ_id
  FROM dbp_view.v_l_werbe_typ;