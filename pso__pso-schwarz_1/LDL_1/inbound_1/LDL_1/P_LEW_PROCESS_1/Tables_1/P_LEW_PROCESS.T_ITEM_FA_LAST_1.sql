/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
#  1.0  27.09.2018    Michael Ueding           Ersterstellung
#  1.1  09.10.2018    Ueding,Michael           Strukturanpassung
#  1.2  13.10.2021    Bachmann, Torsten        Adjust structure to fit to BIL.v_item_foodaction_hist_1 (dwh_valid_from and dwh_valid_to)
#                                              REP3-9444, PatchNo: 2949, INC3542030
#----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_PROCESS.T_ITEM_FA_LAST_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL,
	ITEM_SID NUMBER(38,0) NOT NULL,
	DWH_VALID_FROM DATE NOT NULL,
	DWH_VALID_TO DATE NOT NULL
);