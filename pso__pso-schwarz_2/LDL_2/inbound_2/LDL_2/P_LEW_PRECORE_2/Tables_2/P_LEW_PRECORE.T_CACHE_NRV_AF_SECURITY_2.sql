/*
#----------------------------------------------------------------------------
# History:
#  1.0  16.05.2024    Aleksander Bialek             Precore table to be filled from the ref data xlsx delivered by the business via MS Teams. Part of EK Security Concept, ADO WI: 491935, 618120 
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_PRECORE.T_CACHE_NRV_AF_SECURITY_2
(
Usr_login  VARCHAR(100),
Cntry_CD   VARCHAR(10),
AF         VARCHAR(500),
UWG		   VARCHAR(500),
valid_from VARCHAR(20),
valid_to   VARCHAR(20),
FILE_NAME VARCHAR(100) COLLATE 'en-ci',
DWH_LOAD_ID NUMBER(38,0),
DWH_CREATED TIMESTAMP_NTZ(6),
DWH_UPDATED TIMESTAMP_NTZ(6)
);	


