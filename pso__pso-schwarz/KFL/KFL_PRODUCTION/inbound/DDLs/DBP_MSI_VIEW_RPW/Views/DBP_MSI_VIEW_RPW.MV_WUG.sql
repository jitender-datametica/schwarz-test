CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WUG
    (
    wug_id
    , wg_id
    , arthiertyp_id
    , mandant_id
    , system_id
    )
    AS
       SELECT
       wug_id,
       wg_id,
       arthiertyp_id,
       mandant_id,
       7
FROM dbp_view.v_wug
WHERE mandant_id = 1
AND  arthiertyp_id = 2;