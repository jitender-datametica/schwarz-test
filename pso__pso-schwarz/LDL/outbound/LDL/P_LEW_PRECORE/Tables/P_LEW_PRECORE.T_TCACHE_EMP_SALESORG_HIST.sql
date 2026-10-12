/*

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2025-05-20 Pawel Wieczorek         AP0172232 747581 Init version
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_tcache_emp_salesorg_hist (
client_id BIGNUMERIC(38,0) NOT NULL,
country STRING(20) COLLATE 'und:ci' NOT NULL,
storeno STRING(20) COLLATE 'und:ci' NOT NULL,
loc_sid_store BIGNUMERIC(38,0),
warehouse STRING(20) COLLATE 'und:ci' NOT NULL,
sales_manager_id STRING(20) COLLATE 'und:ci' NOT NULL,
sales_manager_name STRING(100) COLLATE 'und:ci' NOT NULL,
account_manager_id STRING(20) COLLATE 'und:ci' NOT NULL,
account_manager_name STRING(100) COLLATE 'und:ci' NOT NULL,
store_manager_id STRING(20) COLLATE 'und:ci',
store_manager_name STRING(100) COLLATE 'und:ci',
general_manager_id STRING(20) COLLATE 'und:ci',
general_manager_name STRING(100) COLLATE 'und:ci',
salesarea STRING(100) COLLATE 'und:ci',
validfrom DATE,
deleted_fg BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (dwh_valid_from) NOT ENFORCED
);