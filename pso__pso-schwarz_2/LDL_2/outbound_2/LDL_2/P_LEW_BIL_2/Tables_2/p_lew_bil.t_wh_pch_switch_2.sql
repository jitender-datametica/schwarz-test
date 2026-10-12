/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_wh_pch_switch_2
#----------------------------------------------------------------------------
# History:
#  1.0 2021-02-18 Marcin Malec       Copying mart_lead table to bil
#  1.1 2021-04-07 Aleksander Bialek  Adding dwh_updated column (part of the bigger patch moving the switch logic to BIL and other adjustments)
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_wh_pch_switch_2 (
client_id BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
pch_bnl_switch_fg BIGNUMERIC(38,0),
switch_date DATE,
dwh_updated DATETIME
)
OPTIONS(description='Part of PV-BNL solution: contains switch dates from old  to new Wawi versions per wh, it is filled manually with statements with info from Wawi');