CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WG_PER as
   SELECT DISTINCT
   wg_id, arthiertyp_id, abt_id, owg_id
   FROM dbp_view.v_wg_per
   WHERE arthiertyp_id=2
   AND dat_bis = '9999-12-31'
   AND abt_id <> 0;