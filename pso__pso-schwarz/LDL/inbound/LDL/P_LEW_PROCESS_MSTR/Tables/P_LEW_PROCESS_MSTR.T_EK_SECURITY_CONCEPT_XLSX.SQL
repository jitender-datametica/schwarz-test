/*
#----------------------------------------------------------------------------
# History:
#  1.0  16.05.2024    Aleksander Bialek         Table filled from P_LEW_PRECORE.T_EK_SECURITY_CONCEPT_XLSX. Initial version. EK Security Concept, ADO WI: 491935, 618120 
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_PROCESS_MSTR.T_EK_SECURITY_CONCEPT_XLSX
(
Usr_login   VARCHAR(100),
Cntry_CD    VARCHAR(10),
AF          VARCHAR(500),
UWG		    VARCHAR(500),
valid_from  DATE,
valid_to    DATE,
dwh_created TIMESTAMP_NTZ(9) NOT NULL
);	
