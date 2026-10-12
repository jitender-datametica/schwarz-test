CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_OWG_PER_2 as
   SELECT DISTINCT
   owg_id, arthiertyp_id, hwg_id
   FROM dbp_view.v_owg_per_2
   WHERE arthiertyp_id=2
   AND dat_bis = '9999-12-31';