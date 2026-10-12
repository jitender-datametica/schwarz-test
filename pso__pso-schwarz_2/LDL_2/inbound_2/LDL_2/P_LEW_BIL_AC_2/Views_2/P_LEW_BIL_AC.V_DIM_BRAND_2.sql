CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_DIM_BRAND_2
AS
   SELECT  client_id,
   brand_sid,
   brand_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
   FROM p_lew_bil.t_dim_brand_2;