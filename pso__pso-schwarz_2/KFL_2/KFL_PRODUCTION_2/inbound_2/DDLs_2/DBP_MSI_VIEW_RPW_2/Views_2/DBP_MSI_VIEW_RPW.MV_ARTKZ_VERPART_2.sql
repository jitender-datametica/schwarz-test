CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_VERPART_2
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
       FROM dbp_view.v_artkz_verpart_2
       WHERE mandant_id = 1
 ;