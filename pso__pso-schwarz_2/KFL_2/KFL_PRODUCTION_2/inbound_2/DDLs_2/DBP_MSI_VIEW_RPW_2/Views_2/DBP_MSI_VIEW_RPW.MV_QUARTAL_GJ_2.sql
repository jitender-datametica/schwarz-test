CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_QUARTAL_GJ_2
          (
          gjqu
          ,akt_gjqu
          ,akt_gjqu_komplett
          ,gj
          ,akt_gj
          ,akt_gj_komplett
          ,system_id
          )
          AS
             SELECT
             gjqu,
             akt_gjqu,
             akt_gjqu_komplett,
             gj,
             akt_gj,
             akt_gj_komplett,
             7
             FROM dbp_view.v_quartal_gj_2
             WHERE gj >= 2005
             AND gj <= EXTRACT(YEAR FROM CURRENT_DATE);