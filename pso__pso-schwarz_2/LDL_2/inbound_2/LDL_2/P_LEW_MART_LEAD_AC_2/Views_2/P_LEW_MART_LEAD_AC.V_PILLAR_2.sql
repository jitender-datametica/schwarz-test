CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_PILLAR_2
(
  pillar_id
, main_pillar_id
, pillar_name
, dwh_created
, dwh_updated
)
AS
   SELECT
     pillar_id,
   main_pillar_id,
   pillar_name,
   dwh_created,
   dwh_updated
  FROM p_lew_mart_lead.v_pillar_2
;