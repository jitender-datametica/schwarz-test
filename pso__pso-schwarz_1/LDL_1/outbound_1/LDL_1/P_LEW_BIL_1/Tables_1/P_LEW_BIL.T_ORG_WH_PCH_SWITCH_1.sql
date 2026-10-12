/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_wh_pch_switch_1
#----------------------------------------------------------------------------
# History:
#  1.0 2021-04-07 Aleksander Bialek  Moving the switch table on aspec_id level to BIL
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_org_wh_pch_switch_1 (
aspect_id BIGNUMERIC(38,0),
client_id BIGNUMERIC(38,0),
wh_id BIGNUMERIC(38,0),
pch_bnl_switch_fg BIGNUMERIC(38,0),
switch_date DATE,
dwh_updated DATETIME
)
OPTIONS(description='$Revision: 16853 $ : Part of PV-BNL solution: contains switch dates from LDL.P_LEW_TMP.old  to new Wawi versions per wh, it is filled manually with statements with info from Wawi');