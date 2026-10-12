/*
#----------------------------------------------------------------------------
# Coupon Type Desc
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-06 Pawel Wieczork          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_PROCESS_MSTR.T_REF_LDPL_COUPON_TYPE_DESC_2 (
    COUPON_TYPE_ID NUMBER(38,0) NOT NULL,
    COUPON_TYPE_DESC VARCHAR(250) NOT NULL,
    LANG_CD VARCHAR(20) NOT NULL,
    DWH_LOAD_ID NUMBER(38,0) NOT NULL DEFAULT -1,
    DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL,
    DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL,
    PRIMARY KEY (COUPON_TYPE_ID, LANG_CD)
);

