/*
#----------------------------------------------------------------------------
# History:
#  1.0  16.05.2024    Aleksander Bialek             Precore table to be filled from the ref data xlsx delivered by the business via MS Teams. Part of EK Security Concept, ADO WI: 491935, 618120 
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_nrv_af_security_2 (
usr_login STRING(100),
cntry_cd STRING(10),
af STRING(500),
uwg STRING(500),
valid_from STRING(20),
valid_to STRING(20),
file_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME
);