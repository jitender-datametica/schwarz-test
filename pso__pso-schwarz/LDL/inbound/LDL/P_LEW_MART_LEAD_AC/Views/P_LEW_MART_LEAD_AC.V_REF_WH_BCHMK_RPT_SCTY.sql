CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_WH_BCHMK_RPT_SCTY
(
  client_bchmk_rpt_scty_id
, wh_bchmk_rpt_scty_id
, aspect_bchmk_rpt_scty_id
, wh_bchmk_rpt_scty_desc
, client_id
, aspect_id
, wh_id
, wh_desc
)
AS
   SELECT
     client_bchmk_rpt_scty_id,
   wh_bchmk_rpt_scty_id,
   aspect_bchmk_rpt_scty_id,
   wh_bchmk_rpt_scty_desc,
   client_id,
   aspect_id,
   wh_id,
   wh_desc
  FROM p_lew_mart_lead.v_ref_wh_bchmk_rpt_scty
;