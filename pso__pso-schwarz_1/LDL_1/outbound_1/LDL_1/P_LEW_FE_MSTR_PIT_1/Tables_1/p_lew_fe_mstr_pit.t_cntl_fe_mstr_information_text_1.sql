/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2023 
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_FE_MSTR_INFORMATION_TEXT_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Information for the Startpage and Report Pages
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-12-01 K Lukaszewska    Initial version 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 
DROP TABLE LDL.P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_INFORMATION_TEXT_1
*/ 

/*
---------------------------------------------------------------------
0. Create DIM Table in T_CNTL_FE_MSTR_INFORMATION_TEXT_1
------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_information_text_1 (
information_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique Identifier'),
information_html_descr_de STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='German:  Information Message, HTML Format simple. <b> <ul>, etc.'),
information_html_descr_en STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='English: Information Message, HTML Format simple. <b> <ul>, etc.'),
information_author STRING(16777216) OPTIONS(description='Author of the information message. '),
information_entry_dt DATE DEFAULT CURRENT_DATE NOT NULL OPTIONS(description='Entry Date of the information message.'),
information_visible_start_page_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / Indicator if the information should be visibale on Startpage'),
information_visible_report_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / Indicator if the information should be visibale on Report Page'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version Number of record ; Sequence starting from 0'),
current_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Technical Field 1 indicates the current record in case of several version'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / AB>Initio Process ID'),
PRIMARY KEY (information_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Control Table - Frontend Information for the Startpage and Report Pages ');