CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_LAND_2
    (
      land_bez
      ,land_iso
      ,eu_land_fg
      ,land_id
      ,mandant_id
      ,system_id
    )
    AS
       SELECT
         land_bez,
       land_iso,
       eu_land_fg,
       land_id,
       mandant_id,
       7
       FROM dbp_view.v_land_2
       WHERE mandant_id = 1
 ;