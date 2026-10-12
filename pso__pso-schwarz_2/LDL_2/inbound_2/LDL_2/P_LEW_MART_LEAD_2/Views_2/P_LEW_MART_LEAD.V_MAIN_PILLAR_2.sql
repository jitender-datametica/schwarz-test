CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAIN_PILLAR_2
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
  FROM p_lew_process_mstr_ac.v_main_pillar_2
;