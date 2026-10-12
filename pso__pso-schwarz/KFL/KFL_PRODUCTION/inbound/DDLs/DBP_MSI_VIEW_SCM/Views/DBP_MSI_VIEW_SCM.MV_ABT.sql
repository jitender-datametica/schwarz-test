CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ABT as
   SELECT DISTINCT
   abt_id, arthiertyp_id
   FROM dbp_view.v_abt
   WHERE arthiertyp_id=2;