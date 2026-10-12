CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DIM_COUNTRY_GROUP_2
(
   country_grp_sid,
   country_grp_manager_nr,
   country_grp_manager_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
)
AS
   SELECT
      country_grp_sid,
   country_grp_manager_nr,
   country_grp_manager_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
FROM p_lew_mart_lead.v_dim_country_group_2
;