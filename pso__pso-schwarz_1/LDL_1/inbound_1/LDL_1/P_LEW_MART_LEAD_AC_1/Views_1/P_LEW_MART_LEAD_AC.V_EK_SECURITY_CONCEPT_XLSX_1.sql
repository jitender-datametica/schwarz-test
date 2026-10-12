/*
#----------------------------------------------------------------------------
# History:
#  1.0  16.05.2024    Aleksander Bialek         LEAD AC VIEW for ek Security concept table. Initial version. EK Security Concept, ADO WI: 491935, 618120 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_EK_SECURITY_CONCEPT_XLSX_1
AS 
SELECT
  Usr_login
, Cntry_CD
, AF      
, UWG	
, valid_from
, valid_to	
, dwh_created
FROM P_LEW_PROCESS_MSTR_AC.V_EK_SECURITY_CONCEPT_XLSX_1;	
