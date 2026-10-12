CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_INTERNAL_ORGANISATION_TYPE_1
(
   int_org_type_cd       
   ,int_org_type_name   
   ,int_org_type_descr            
   ,dwh_load_id       
   ,dwh_created       
   ,dwh_updated 
)
AS
   SELECT
   int_org_type_cd       
   ,int_org_type_name   
   ,int_org_type_descr    
   ,dwh_load_id       
   ,dwh_created       
   ,dwh_updated 
  FROM P_LEW_CORE.T_INTERNAL_ORGANISATION_TYPE_1 ;