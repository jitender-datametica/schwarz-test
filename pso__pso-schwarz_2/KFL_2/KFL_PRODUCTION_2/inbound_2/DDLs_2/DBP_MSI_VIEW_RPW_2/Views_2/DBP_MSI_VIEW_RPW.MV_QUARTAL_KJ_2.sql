CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_QUARTAL_KJ_2
 (
 kjqu
 ,kj
 ,akt_kjqu
 ,akt_kjqu_komplett
 ,akt_kj
 ,akt_kj_komplett
 ,system_id
 )
 AS
    SELECT
    kjqu,
    kj,
    akt_kjqu,
    akt_kjqu_komplett,
    akt_kj,
    akt_kj_komplett,
    7
    FROM dbp_view.v_quartal_kj_2
    WHERE kj >= 2005
    AND kj <= EXTRACT(YEAR FROM CURRENT_DATE);