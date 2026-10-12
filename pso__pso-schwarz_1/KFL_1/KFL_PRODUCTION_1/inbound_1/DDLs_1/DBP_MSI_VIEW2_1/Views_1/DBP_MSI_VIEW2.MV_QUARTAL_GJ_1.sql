CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_QUARTAL_GJ_1 (gjqu,akt_gjqu,akt_gjqu_komplett, gj, akt_gj, akt_gj_komplett )
AS
   SELECT gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj, akt_gj_komplett  FROM dbp_view.v_quartal_gj_1 where gjqu > 200104;