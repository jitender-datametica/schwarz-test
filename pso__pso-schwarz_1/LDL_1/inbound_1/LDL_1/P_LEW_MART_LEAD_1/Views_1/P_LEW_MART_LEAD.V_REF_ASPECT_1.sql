CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_ASPECT_1
(
  aspect_id
, aspect_desc
)
AS
   SELECT
     aspect_id,
   aspect_desc
  FROM p_lew_core_ac.v_wawi_ref_aspect_1
;