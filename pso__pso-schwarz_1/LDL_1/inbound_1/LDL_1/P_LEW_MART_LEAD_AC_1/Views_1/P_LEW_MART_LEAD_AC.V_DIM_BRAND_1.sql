CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_DIM_BRAND_1
AS
   SELECT  client_id,
   brand_sid,
   brand_name,
   dwh_load_id,
   dwh_created,
   dwh_updated
   FROM p_lew_mart_lead.v_dim_brand_1;