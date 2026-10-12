CREATE OR REPLACE view DBP_MSI_VIEW_RPW.MV_ARTKZ_ESB_2
(
  esb_id
  ,esb_bez
  ,mandant_id
  ,spr_id
  ,system_id
) AS
SELECT
  esb_id
  ,esb_bez
  ,mandant_id
  ,spr_id
  ,7 AS system_id 
FROM dbp_view.v_artkz_esb_2
WHERE mandant_id = 1
;