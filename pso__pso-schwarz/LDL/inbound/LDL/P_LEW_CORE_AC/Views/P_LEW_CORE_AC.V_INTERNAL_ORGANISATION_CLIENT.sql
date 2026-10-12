CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_INTERNAL_ORGANISATION_CLIENT
(
   int_org_sid       
   ,int_org_type_cd   
   ,client_id            
   ,dwh_load_id       
   ,dwh_created       
   ,dwh_updated 
)
AS
   SELECT
   int_org_sid       
   ,int_org_type_cd   
   ,client_id    
   ,dwh_load_id       
   ,dwh_created       
   ,dwh_updated 
  FROM P_LEW_CORE.T_INTERNAL_ORGANISATION_CLIENT ;