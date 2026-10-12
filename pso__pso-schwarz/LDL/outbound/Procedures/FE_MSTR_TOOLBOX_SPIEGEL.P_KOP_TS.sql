/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.P_KOP_TS
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  21.11.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/



CREATE OR REPLACE PROCEDURE fe_mstr_toolbox_spiegel.p_kop_ts(IN P_INT_ORG_SID INT64, IN P_SPACEMAN_ITEM_SID INT64, IN P_HEAVY_SORT STRING, IN P_CENTER_PULL STRING, IN P_EASY_IDENT STRING, IN P_REASON STRING, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
MERGE INTO fe_mstr_toolbox_spiegel.t_spaceman_kop_ts AS TARGET
USING (SELECT P_INT_ORG_SID AS int_org_sid, P_SPACEMAN_ITEM_SID AS spaceman_item_sid, P_HEAVY_SORT AS heavy_sort, P_CENTER_PULL AS center_pull, P_EASY_IDENT AS easy_ident, P_REASON AS reason) AS SOURCE
ON TARGET.spaceman_item_sid = SOURCE.spaceman_item_sid AND TARGET.int_org_sid = SOURCE.int_org_sid
WHEN MATCHED THEN UPDATE SET
    heavy_sort = SOURCE.heavy_sort,
    center_pull = SOURCE.center_pull,
    easy_ident = SOURCE.easy_ident,
    reason = SOURCE.reason,
    dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHEN NOT MATCHED THEN INSERT VALUES(SOURCE.int_org_sid, SOURCE.spaceman_item_sid , SOURCE.heavy_sort, SOURCE.center_pull, SOURCE.easy_ident, SOURCE.reason, CAST(CURRENT_TIMESTAMP() AS DATETIME), CAST(CURRENT_TIMESTAMP() AS DATETIME));
COMMIT TRANSACTION;
SET out_param  =  'Data Updated';
SELECT out_param;
RETURN;
END;