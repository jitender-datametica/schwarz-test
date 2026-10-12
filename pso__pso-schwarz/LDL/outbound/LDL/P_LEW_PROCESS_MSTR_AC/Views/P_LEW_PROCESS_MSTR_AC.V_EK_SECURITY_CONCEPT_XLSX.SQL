/*
#----------------------------------------------------------------------------
# History:
#  1.0  16.05.2024    Aleksander Bialek         AC VIEW for ek Security concept table. Initial version. EK Security Concept, ADO WI: 491935, 618120 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_ek_security_concept_xlsx AS SELECT usr_login,
 cntry_cd,
 af,
 uwg,
 valid_from,
 valid_to,
 dwh_created
FROM ldl_p_lew_process_mstr.t_ek_security_concept_xlsx;