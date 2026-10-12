CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_DISPLAY_1
          (
            display_id
            ,display_bez
            ,mandant_id
            ,spr_id
            ,system_id
          )
          AS
             SELECT
               display_id,
             display_bez,
             mandant_id,
             spr_id,
             7 AS system_id
             FROM dbp_view.v_artkz_display_1
             WHERE mandant_id = 1
 ;