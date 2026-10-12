CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_INTERNAL_ORGANISATION
(
   int_org_sid       
   ,int_org_type_cd   
   ,int_org_nr        
   ,int_org_name      
   ,int_org_descr     
   ,dwh_load_id       
   ,dwh_created       
   ,dwh_updated 
)
AS
   SELECT
    int_org_sid       
   ,int_org_type_cd   
   ,int_org_nr        
   ,int_org_name      
   ,int_org_descr     
   ,dwh_load_id       
   ,dwh_created       
   ,dwh_updated 
  FROM P_LEW_CORE.T_INTERNAL_ORGANISATION ;