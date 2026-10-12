CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_DIM_BRAND
AS
   SELECT  client_id,
   brand_sid,
   brand_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
   FROM p_lew_bil_ac.v_dim_brand;