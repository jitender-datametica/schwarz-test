CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_LOESCH_1
 (
   loesch_id
   ,loesch_bez
   ,mandant_id
   ,spr_id
   ,system_id
 )
 AS
    SELECT
      loesch_id,
    loesch_bez,
    mandant_id,
    spr_id,
    7
    FROM dbp_view.v_artkz_loesch_1
    WHERE mandant_id = 1
 ;