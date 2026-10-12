CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_DIM_COUNTRY_GROUP
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
FROM p_lew_bil.t_dim_country_group
;