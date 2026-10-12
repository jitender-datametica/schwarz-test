CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_STORE_HIST 
AS SELECT
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
core.t_dim_store_hist
WHERE 
dwh_valid_fg = True
;