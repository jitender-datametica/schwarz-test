CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_OWG_PER as
   SELECT DISTINCT
   owg_id, arthiertyp_id, hwg_id
   FROM dbp_view.v_owg_per
   WHERE arthiertyp_id=2
   AND dat_bis = '9999-12-31';