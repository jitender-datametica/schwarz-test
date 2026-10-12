CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_MAIN_PILLAR_1
(
  main_pillar_id
, main_pillar_name
, dwh_created
, dwh_updated
)
AS
   SELECT
     main_pillar_id,
   main_pillar_name,
   dwh_created,
   dwh_updated
  FROM p_lew_mart_lead.v_main_pillar_1
;