/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for <schema name>.<table or view name>
#----------------------------------------------------------------------------
# History:
#   1.0            15.03.2021        Oguzhan Gunes            checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_CS.T_CS_MAP_CLIENT (
	client_id NUMBER(38,0) NOT NULL,
	cs_lang_id NUMBER(38,0) NOT NULL,
	cs_client_id NUMBER(38,0) NOT NULL,
	cs_parent_client_id NUMBER(38,0) NOT NULL,
	cs_country_id NUMBER(38,0) NOT NULL,
	unique (CLIENT_ID)
);