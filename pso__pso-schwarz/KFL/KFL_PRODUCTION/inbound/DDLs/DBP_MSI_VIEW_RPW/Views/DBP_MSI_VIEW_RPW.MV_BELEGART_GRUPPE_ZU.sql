CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BELEGART_GRUPPE_ZU
    (
    system_id
    ,mandant_id
    ,belegart_id
    ,belegart_gruppe_id
    ,belegreferenz_id
    )
    AS
       SELECT
       7,
       mandant_id,
       belegart_id,
       belegart_gruppe_id,
       CASE WHEN belegart_gruppe_id IN (3,4) THEN  '1' ELSE '0' END  AS  belegreferenz_id
       FROM dbp_view.v_belegart_gruppe_zu
       WHERE mandant_id = 1;