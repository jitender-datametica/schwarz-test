/*
#----------------------------------------------------------------------------
# Coupon Type Group
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-06 Pawel Wieczorek          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_PROCESS_MSTR.T_REF_LDPL_COUPON_TYPE_GROUP_2 (
    COUPON_TYPE_GROUP_ID NUMBER(38,0) NOT NULL,
    COUPON_TYPE_GROUP_DESC VARCHAR(250) NOT NULL,
    ACTIVE_FG NUMBER(38,0) NOT NULL DEFAULT 0,
    DWH_LOAD_ID NUMBER(38,0) NOT NULL DEFAULT -1,
    DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL,
    DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL,
    UNIQUE (COUPON_TYPE_GROUP_DESC),
    PRIMARY KEY (COUPON_TYPE_GROUP_ID)
);

