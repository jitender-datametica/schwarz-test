CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_STORE_HIST_1 
AS 
SELECT
 core.t_dim_store_hist.store_sid
,core.t_dim_store_hist.lob_cd
,core.t_dim_store_hist.lob_name
,core.t_dim_store_hist.company_name
,core.t_dim_store_hist.company_id
,core.t_dim_store_hist.store_nr
,core.t_dim_store_hist.store_name
,core.t_dim_store_hist.store_active_fg
,core.t_dim_store_hist.street_name
,core.t_dim_store_hist.house_nr
,core.t_dim_store_hist.city_name
,core.t_dim_store_hist.zip
,core.t_dim_store_hist.country_pol_cd
,core.t_dim_store_hist.country_pol_name
FROM 
core.t_dim_store_hist_1
WHERE 
dwh_valid_fg = True
AND STORE_ACTIVE_FG = TRUE
;