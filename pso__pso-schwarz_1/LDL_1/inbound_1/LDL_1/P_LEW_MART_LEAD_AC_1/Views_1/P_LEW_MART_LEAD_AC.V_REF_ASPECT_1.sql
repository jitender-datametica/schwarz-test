CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_ASPECT_1
(
  aspect_id
, aspect_desc
)
AS
   SELECT
     aspect_id,
   aspect_desc
  FROM p_lew_mart_lead.v_ref_aspect_1
;