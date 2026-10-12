CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_QUARTAL_GJ_1 as
   SELECT
   gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj, akt_gj_komplett
   FROM dbp_view.v_quartal_gj_1
   WHERE gjqu > 200104;