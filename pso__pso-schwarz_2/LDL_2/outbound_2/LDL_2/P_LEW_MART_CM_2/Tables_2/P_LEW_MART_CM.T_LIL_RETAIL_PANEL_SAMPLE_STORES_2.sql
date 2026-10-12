/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - Category Management 2022
#-------------------------------------------------------------------------------
# Interface : DDL for T_LIL_RETAIL_PANEL_SAMPLE_STORES_2
#-------------------------------------------------------------------------------
# Description: Create DDL for transaction services 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  03.11.2022 Mateusz Rek    Initial version
#  1.1  08.11.2022 Mateusz Rek 	  Removed LOC_SID
#  1.2  01.12.2022 Mateusz Rek 	  Added DATERIME_UPDATED
#-------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.t_lil_retail_panel_sample_stores_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Country_2 identifier'),
orig_store_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
partner_name STRING(100) NOT NULL OPTIONS(description='Name of partner'),
datetime_updated DATETIME OPTIONS(description='Insert/update Timestamp'),
PRIMARY KEY (partner_name, client_id, orig_store_nr) NOT ENFORCED
) OPTIONS(description='Transaction Services Table for Retail Panel');