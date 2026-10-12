CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ABT_2 as
   SELECT DISTINCT
   abt_id, arthiertyp_id
   FROM dbp_view.v_abt_2
   WHERE arthiertyp_id=2;