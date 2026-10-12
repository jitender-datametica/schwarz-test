/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_apt_item_details_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  16.08.2022    Ross, Uli                    User Story 363377
#                                                  Add column weight_fg
#  1.5  11.06.2024    Ross, Uli                    User Story 635594
#                                                  Add column brand_type_desc
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_apt_item_details_2
(
  client_id
, country_iso_cd
, org_item_nr
, valid_from_item
, case_size
, buying_emp_nat_name
, dat_rec_start
, dat_rec_end
, brand_name
, itemlistingtype_cd
, vat_no
, packageunit_size
, packageunit_type
, packagetype_descr
, palletfactor_euro
, int_item_nr
, itemstatus_cd
, weight_fg
, brand_type_desc
, cs_updated
, cs_created
, cs_load_id
)
AS
   SELECT
      client_id
    , country_iso_cd
    , org_item_nr
    , valid_from_item
    , case_size
    , buying_emp_nat_name
    , dat_rec_start
    , dat_rec_end
    , brand_name
    , itemlistingtype_cd
    , vat_no
    , packageunit_size
    , packageunit_type
    , packagetype_descr
    , palletfactor_euro
    , int_item_nr
    , itemstatus_cd
    , weight_fg
    , brand_type_desc
    , cs_updated
    , cs_created
    , cs_load_id
   FROM p_lew_mart_cs.t_apt_item_details_2
   ;