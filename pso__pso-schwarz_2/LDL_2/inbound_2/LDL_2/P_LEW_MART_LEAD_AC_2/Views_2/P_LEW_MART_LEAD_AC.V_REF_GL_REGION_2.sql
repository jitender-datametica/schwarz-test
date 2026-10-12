CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_GL_REGION_2
(
  client_id
, gl_region_id
, gl_region_desc
, gl_last_name
, gl_first_name
)
AS
   SELECT
     client_id,
   gl_region_id,
   gl_region_desc,
   gl_last_name,
   gl_first_name

  FROM p_lew_mart_lead.v_ref_gl_region_2
;