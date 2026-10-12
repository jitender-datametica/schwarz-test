CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_LEAD_1
    (
      lead_id
      ,lead_bez
      ,mandant_id
      ,spr_id
      ,system_id
    )
    AS
       SELECT
         lead_id,
       lead_bez,
       mandant_id,
       spr_id,
       7
       FROM dbp_view.v_artkz_lead_1
       WHERE mandant_id = 1
 ;