/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_apt_item_listing_type_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_apt_item_listing_type_1
(
client_id
, country_iso_cd
, itemlistingtype_cd
, cs_updated
, cs_created
, cs_load_id
)
AS
   SELECT
   a.client_id,
   a.country_iso_cd,
   a.itemlistingtype_cd,
   a.cs_updated,
   a.cs_created,
   a.cs_load_id
   FROM p_lew_mart_cs.t_apt_item_listing_type_1 a
   ;


