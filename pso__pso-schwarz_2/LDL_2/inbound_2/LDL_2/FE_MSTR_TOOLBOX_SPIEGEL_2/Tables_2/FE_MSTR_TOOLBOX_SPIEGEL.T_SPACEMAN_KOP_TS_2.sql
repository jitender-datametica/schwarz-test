/*
#----------------------------------------------------------------------------
# Description:
# Transactional Service table for KOP
#
#-----------------------------------------------------------------------------
# History:
#  1.0     21.11.2024      Simeon Nikolaev         Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE TABLE FE_MSTR_TOOLBOX_SPIEGEL.T_SPACEMAN_KOP_TS_2(
INT_ORG_SID NUMBER(38,0) NOT NULL,
SPACEMAN_ITEM_SID NUMBER(38,0) NOT NULL,
HEAVY_SORT VARCHAR(300),
CENTER_PULL VARCHAR(300),
EASY_IDENT VARCHAR(300),
REASON VARCHAR(300),
DWH_CREATED TIMESTAMP_LTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_LTZ(9) NOT NULL
);