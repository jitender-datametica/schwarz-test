/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_sys_revision_load_store_1
#----------------------------------------------------------------------------
# History:
#  1.0   6.11.2017    Gabriel Toth             Initial version
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.3  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.4  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.5  17.01.2018    Wieber.Harald            Release 2.2
#  1.6  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.7  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.8  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.9  25.04.2018    Wieber.Harald            Update Release 3.5
# 1.10  03.05.2018    Wieber.Harald            Release 3.6
# 1.11  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.12  05.03.2021    Wandtke,Andrzej          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SYS_REVISION_LOAD_STORE_1
(
client_id
, wh_id
, store_id
, orig_store_nr
, dat_formdate_from
, dat_formdate_until
, load_in_progress_fg
, void_fg
, deposit_fg
, return_fg
, aborted_suspended_fg
, discount_fg
, other_fg
, store_load_fg
, materialize_id
, revision_test_fg
, revision_fg
, revision_user
, revision_reason_cd
 )
AS
   SELECT
   client_id,
   wh_id,
   store_id,
   orig_store_nr,
   dat_formdate_from,
   dat_formdate_until,
   load_in_progress_fg,
   void_fg,
   deposit_fg,
   return_fg,
   aborted_suspended_fg,
   discount_fg,
   other_fg,
   store_load_fg,
   materialize_id,
   revision_test_fg,
   revision_fg,
   revision_user,
   revision_reason_cd
   FROM p_lew_mart_msi.v_sys_revision_load_store_1;