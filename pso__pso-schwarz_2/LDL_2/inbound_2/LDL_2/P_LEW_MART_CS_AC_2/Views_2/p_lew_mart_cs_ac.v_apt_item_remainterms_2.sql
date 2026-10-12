/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.v_apt_item_remainterms_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_apt_item_remainterms_2
(
  client_id
, country_iso_cd
, item_nr_nat
, valid_from
, case_size
, dat_rec_start
, dat_rec_end
, remain_period_cd_wh
, remain_term_value_wh
, remain_period_cd_store
, remain_term_value_store
, remain_period_cd_customer
, remain_term_value_customer
, cs_updated
, cs_created
, cs_load_id
)
AS
   SELECT
   a.client_id,
   a.country_iso_cd,
   a.item_nr_nat,
   a.valid_from,
   a.case_size,
   a.dat_rec_start,
   a.dat_rec_end,
   a.remain_period_cd_wh,
   a.remain_term_value_wh,
   a.remain_period_cd_store,
   a.remain_term_value_store,
   a.remain_period_cd_customer,
   a.remain_term_value_customer,
   a.cs_updated,
   a.cs_created,
   a.cs_load_id
   FROM p_lew_mart_cs.v_apt_item_remainterms_2 a
   ;


