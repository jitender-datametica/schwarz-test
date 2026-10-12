CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_QUARTAL_GJ_2 (gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj, akt_gj_komplett)
AS
   SELECT gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj, akt_gj_komplett FROM dbp_view.v_quartal_gj_2 WHERE gjqu > 200104;