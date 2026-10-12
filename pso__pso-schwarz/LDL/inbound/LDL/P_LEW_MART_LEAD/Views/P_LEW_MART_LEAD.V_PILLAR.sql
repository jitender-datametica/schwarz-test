CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_PILLAR
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
  FROM p_lew_process_mstr_ac.v_pillar
;