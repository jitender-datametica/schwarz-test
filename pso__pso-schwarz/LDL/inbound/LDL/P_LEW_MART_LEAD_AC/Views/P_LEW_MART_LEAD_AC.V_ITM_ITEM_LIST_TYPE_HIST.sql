/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead_ac.v_itm_item_list_type_hist
#----------------------------------------------------------------------------
# History:
#  1.0  19.06.2021    Bachmann, Torsten        Transfer to LEAD, new logic for listing-related Attributes, rename to _list_type_hist, PatchNo: 2915, REP3-8659
#  1.1  24.08.2021    Bachmann, Torsten        Migrated to Snowflake
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ITM_ITEM_LIST_TYPE_HIST COMMENT = '$Revision: 17248 $; History of buying_list_type_id, brand_type_id and listing_type_id per item'
(
  client_id                    COMMENT 'Landeskennzeichen'
, item_id                      COMMENT 'Artikelnummer'
, dat_rec_start                COMMENT 'Gültigkeitsdatum von'
, dat_rec_end                  COMMENT 'Gültigkeitsdatum bis'
, brand_name                   COMMENT 'The name of the brand.'
, buying_list_type_id          COMMENT 'Einkauf Listungstyp'
, buying_list_type_desc        COMMENT 'Bezeichnung der Art des Artikels ( Saison, ... )'
, listing_type_id              COMMENT 'the type of listing article'
, brand_type_id                COMMENT 'the type of brand of an article'
, buying_list_type_group_id    COMMENT 'Gruppe der Art des Artikels ( Saison, ... )'
, listing_type_group_id        COMMENT 'Guppe Einlistungstype Id'
, brand_type_group_id          COMMENT 'Guppen Markenart ID'
)
AS
SELECT
  client_id
, item_id
, dat_rec_start
, dat_rec_end
, brand_name
, buying_list_type_id
, buying_list_type_desc
, listing_type_id
, brand_type_id
, buying_list_type_group_id
, listing_type_group_id
, brand_type_group_id
FROM P_LEW_MART_LEAD.V_ITM_ITEM_LIST_TYPE_HIST
;
