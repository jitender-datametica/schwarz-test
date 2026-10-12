/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_msi_ejr_org_checker_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  05.01.2017    Michael Ueding           Change Primary Index
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  30.01.2018    Wieber.Harald            Anpassung Index/Not Null/ PPI - Michael Üding
#  1.5  31.01.2018    Wieber.Harald            Release 2.3
#  1.6  31.01.2018    Wieber,Harald            Release 2.3
#  1.7  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_msi_ejr_org_checker_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0) NOT NULL,
checker_id BIGNUMERIC(38,0) NOT NULL,
void_fg BIGNUMERIC(38,0) NOT NULL,
deposit_fg BIGNUMERIC(38,0) NOT NULL,
return_fg BIGNUMERIC(38,0) NOT NULL,
aborted_suspended_fg BIGNUMERIC(38,0) NOT NULL,
discount_fg BIGNUMERIC(38,0) NOT NULL,
other_fg BIGNUMERIC(38,0) NOT NULL,
link_param STRING(1000) COLLATE 'und:ci'
);