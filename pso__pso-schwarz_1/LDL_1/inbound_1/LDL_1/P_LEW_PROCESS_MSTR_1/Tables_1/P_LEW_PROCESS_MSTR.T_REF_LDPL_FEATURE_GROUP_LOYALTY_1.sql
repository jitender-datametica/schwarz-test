/*
#----------------------------------------------------------------------------
# feature group loyalty
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-05-21 Marcin Kikola          AP0206303 Introduction of Loyalty_attribute
#
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_GROUP_LOYALTY_1 (
 LOYALTY_ID NUMBER(38,0) COMMENT 'Loyalty attribute identifier',
 LOYALTY_DESC VARCHAR(250) COMMENT 'Loyalty attribute description',
 DWH_LOAD_ID NUMBER(38,0) NOT NULL DEFAULT -1  COMMENT 'Load identifier',
 DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Row create time',
 DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL COMMENT 'Row update time',
 UNIQUE (LOYALTY_DESC),
 PRIMARY KEY (LOYALTY_ID)
 NOT ENFORCED
 ) COMMENT = 'Lidl Plus Loyalty';