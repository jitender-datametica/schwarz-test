/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_CLIENT
#-------------------------------------------------------------------------------
# Description: Create DDL for Client Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.3  2022-02-10 Andreas kurz		Removed COUTRY_GROUP columns not needed any more
#									Parallel execution will be done by client_id and Data_size param
#  1.4  2022-02-16 Andreas Kurz 	Added EXCHANGE_RATE_TO_EUR
#  1.5  2022-06-01 Andreas Kurz 	Added COUNTRY_ORIG_DESCR COUNTRY_DESCR represent in Germna Language
#  1.6  2022-08-25 Andreas Kurz		Added CTR_STORE_NBR used for paralell execution
#-------------------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
0. Create DIM Table in T_DIM_CLIENT
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT;
DROP TABLE LDL.P_LEW_MART_PIT.T_DIM_CLIENT; 
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_CLIENT
ADD CTR_STORE_NBR								NUMBER(38,5)		NOT NULL 		DEFAULT -1										COMMENT 'Countrie Number of Stores, see also Param , needed for parallel processing'


------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_client (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(10) DEFAULT 'INTEGER ' NOT NULL OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) DEFAULT 'Lidl International' NOT NULL
OPTIONS(description='Country Name (Language German)'),
country_orig_descr STRING(16777216) DEFAULT 'Lidl International' NOT NULL
OPTIONS(description='Country Name Orginal from Source'),
country_nat_descr STRING(16777216) DEFAULT 'Lidl International' NOT NULL
OPTIONS(description='Country Name - national (Local Language)'),
country_int_descr STRING(16777216) DEFAULT 'Lidl International' NOT NULL
OPTIONS(description='Country Name - international (Language German)'),
lang_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='[FK]: to Language SID '),
curr_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[FK] Unique Currency SID based Local Currency of Lidl Country'),
curr_cd STRING(16777216) OPTIONS(description='Currency Code'),
exchange_rate_to_eur BIGNUMERIC(38,5) DEFAULT 1 NOT NULL OPTIONS(description='Exchange Rate to EUR'),
ctr_adv_week_start_weekday_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Start Day of the Adv-Week ID e.g. BE = 1, CH=4. Please see also the PIT_PARAM'),
ctr_store_nbr BIGNUMERIC(38,5) DEFAULT - 1 NOT NULL
OPTIONS(description='Countrie Number of Stores, see also Param , needed for parallel processing'),
ctr_ex_elvis_country_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag / Indicator if the Country was migrated from SAP (ELWIS) to WaWi. This true for Norther Ireland, Austria and Serbia. Please see also the PIT_PARAM'),
ctr_ex_elvis_country_migration_date_from DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Ex Elivs Country Migration Date From (von)'),
ctr_ex_elvis_country_migration_date_to DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Ex Elivs Country Migration Date To (bis)'),
pit_country_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag / Indicator indicating 1::= PIT Country. Please see also the PIT_PARAM'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version Number of record ; Sequence starting from 0'),
current_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Technical Field 1 indicates the current record in case of several version'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='PIT Dimension table client / country.');