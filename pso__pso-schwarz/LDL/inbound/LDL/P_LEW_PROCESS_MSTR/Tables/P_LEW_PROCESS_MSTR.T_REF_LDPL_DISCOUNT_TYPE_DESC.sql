/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-07 Pawel Wieczorek          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_PROCESS_MSTR.T_REF_LDPL_DISCOUNT_TYPE_DESC (
    DISCOUNT_TYPE_ID NUMBER(38,0) NOT NULL,
    DISCOUNT_TYPE_DESC VARCHAR(250) NOT NULL,
    LANG_CD VARCHAR(20) NOT NULL,
    DWH_LOAD_ID NUMBER(38,0) NOT NULL DEFAULT -1,
    DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL,
    DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL,
    PRIMARY KEY (DISCOUNT_TYPE_ID, LANG_CD)
);