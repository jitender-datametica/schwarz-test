
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_GL_REGION 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* 
   #DescStart#  
   #$Revision: 6244 $, $LastChangedBy: hwieber $  
   #SubjectAreas#: Organisationsstruktur  
   #DescEnd#  
   */ 
   SELECT 
     client_id -- techn. Schlüssel zur Referenzierung des Landes  
   ,  
   gl_region_id -- techn. DWH- Schlüsse zur Referenzierung der Geschäftsleitungsregion  
   ,  
   gl_region_desc -- Name der Region  
   ,  
   gl_last_name -- Nachname des GL  
   ,  
   gl_first_name -- Vorname des GL  
  FROM p_lew_core_ac.v_wawi_ref_gl_region 
  
  UNION ALL 
  /* dummy region for country level */  
  SELECT  
    client_id                                         AS client_id, 
   -1*client_id                                      AS gl_region_id, 
   CAST('#'|| TRIM( cntr.country_iso_cd) AS VARCHAR(60))  
   AS gl_region_desc, 
   CAST(cntr.country_iso_cd AS VARCHAR(30))          AS gl_last_name, 
   CAST('#' AS VARCHAR(30))                          AS gl_first_name 
  
  FROM p_lew_core_ac.v_wawi_ref_client_country AS clnt  
   INNER JOIN p_lew_core_ac.v_wawi_ref_country  AS cntr 
   ON clnt.country_id = cntr.country_id 
  
   WHERE cntr.dashboard_relevant_fg = 1;
