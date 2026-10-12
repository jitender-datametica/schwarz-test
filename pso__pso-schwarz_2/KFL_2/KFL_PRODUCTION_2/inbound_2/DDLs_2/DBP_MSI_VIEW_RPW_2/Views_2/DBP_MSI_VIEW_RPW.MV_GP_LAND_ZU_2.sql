CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_GP_LAND_ZU_2
    (
    land_id
    ,land_bez
    ,mandant_id
    ,system_id
    )
    AS
       SELECT
       a.land_id,
       b.land_bez,
       b.mandant_id,
       7
       FROM dbp_view.v_gp_2 a
       LEFT OUTER JOIN dbp_view.v_land_2 b
       ON a.land_id = b.land_id
       AND a.mandant_id=b.mandant_id
       WHERE a.mandant_id = 1
       GROUP BY 1,2,3,4;