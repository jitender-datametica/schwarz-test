CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_JAHR_GJ
 (
 gj
 ,akt_gj
 ,akt_gj_komplett
 ,system_id
 )
 AS
    SELECT
    gj,
    akt_gj,
    akt_gj_komplett,
    7 AS system_id
    FROM dbp_view.v_jahr_gj
    WHERE gj >= 2005
    AND gj <= EXTRACT (YEAR FROM CURRENT_DATE);