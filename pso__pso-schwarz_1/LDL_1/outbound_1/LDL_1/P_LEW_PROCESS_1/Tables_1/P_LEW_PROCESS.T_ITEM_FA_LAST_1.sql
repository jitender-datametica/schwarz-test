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


CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_item_fa_last_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL
);