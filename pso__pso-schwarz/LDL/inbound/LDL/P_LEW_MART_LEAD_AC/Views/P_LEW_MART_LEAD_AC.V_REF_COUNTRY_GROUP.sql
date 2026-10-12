CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_COUNTRY_GROUP
(
  country_group_id
, country_group_desc
)
AS
   SELECT
     country_group_id,
   country_group_desc
  FROM p_lew_mart_lead.v_ref_country_group
;