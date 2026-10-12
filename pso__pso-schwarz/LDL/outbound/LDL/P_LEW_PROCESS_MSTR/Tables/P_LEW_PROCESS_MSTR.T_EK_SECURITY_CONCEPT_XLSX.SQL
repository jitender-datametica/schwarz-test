/*
#----------------------------------------------------------------------------
# History:
#  1.0  16.05.2024    Aleksander Bialek         Table filled from LDL.P_LEW_PRECORE.T_EK_SECURITY_CONCEPT_XLSX. Initial version. EK Security Concept, ADO WI: 491935, 618120 
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_process_mstr.t_ek_security_concept_xlsx (
usr_login STRING(100),
cntry_cd STRING(10),
af STRING(500),
uwg STRING(500),
valid_from DATE,
valid_to DATE,
dwh_created DATETIME NOT NULL
);