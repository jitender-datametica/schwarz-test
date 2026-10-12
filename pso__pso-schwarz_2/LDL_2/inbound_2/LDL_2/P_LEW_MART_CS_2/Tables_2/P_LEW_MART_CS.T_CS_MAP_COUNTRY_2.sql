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


CREATE TABLE P_LEW_MART_CS.T_CS_MAP_COUNTRY_2 (
	cs_country_id NUMBER(38,0) NOT NULL,
	cs_country_iso_cd VARCHAR(2) NOT NULL COLLATE 'en-ci',
	unique (CS_COUNTRY_ID)
);