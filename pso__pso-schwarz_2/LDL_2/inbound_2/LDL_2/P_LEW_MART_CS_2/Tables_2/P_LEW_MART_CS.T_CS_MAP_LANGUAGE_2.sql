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


CREATE TABLE P_LEW_MART_CS.T_CS_MAP_LANGUAGE_2 (
	dwh_language_id NUMBER(38,0),
	cs_language_id NUMBER(38,0),
	cs_language_iso_cd VARCHAR(5) COLLATE 'en-ci',
	unique (cs_language_id)
);