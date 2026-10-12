/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for <schema name>.<table or view name>
#----------------------------------------------------------------------------
# History:
#   1.0            15.03.2021        Oguzhan Guenes            checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_apt_buying_emp_1 (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
buying_employee_skey BIGNUMERIC(38) NOT NULL,
buying_employee_name STRING(200) COLLATE 'und:ci',
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);