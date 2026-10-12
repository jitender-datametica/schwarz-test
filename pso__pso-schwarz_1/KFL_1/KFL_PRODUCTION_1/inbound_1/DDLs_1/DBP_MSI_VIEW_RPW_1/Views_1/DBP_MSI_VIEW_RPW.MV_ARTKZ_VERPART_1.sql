CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_VERPART_1
    (
      verpart_id
      ,verpart_bez
      ,mandant_id
      ,spr_id
      ,system_id
    )
    AS
       SELECT
         verpart_id,
       verpart_bez,
       mandant_id,
       spr_id,
       7
       FROM dbp_view.v_artkz_verpart_1
       WHERE mandant_id = 1
 ;