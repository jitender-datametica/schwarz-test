/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead_ac.v_itm_item_list_type_hist_1
#----------------------------------------------------------------------------
# History:
#  1.0  19.06.2021    Bachmann, Torsten        Transfer to LEAD, new logic for listing-related Attributes, rename to _list_type_hist, PatchNo: 2915, REP3-8659
#  1.1  24.08.2021    Bachmann, Torsten        Migrated to Snowflake
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_itm_item_list_type_hist_1 (client_id
OPTIONS(description='Landeskennzeichen'), item_id OPTIONS(description='Artikelnummer'), dat_rec_start
OPTIONS(description='Gültigkeitsdatum von'), dat_rec_end OPTIONS(description='Gültigkeitsdatum bis'), brand_name
OPTIONS(description='The name of the brand.'), buying_list_type_id OPTIONS(description='Einkauf Listungstyp'),
buying_list_type_desc OPTIONS(description='Bezeichnung der Art_1 des Artikels ( Saison, ... )'), listing_type_id
OPTIONS(description='the type of listing article'), brand_type_id OPTIONS(description='the type of brand_1 of an article'),
buying_list_type_group_id OPTIONS(description='Gruppe_1 der Art_1 des Artikels ( Saison, ... )'), listing_type_group_id
OPTIONS(description='Guppe Einlistungstype Id'), brand_type_group_id OPTIONS(description='Guppen Markenart ID'))
OPTIONS(DESCRIPTION = `$Revision: 17248 $; HISTORY OF BUYING_LIST_TYPE_ID, BRAND_TYPE_ID AND LISTING_TYPE_ID PER ITEM_1`)
AS SELECT client_id,
 item_id,
 dat_rec_start,
 dat_rec_end,
 brand_name,
 buying_list_type_id,
 buying_list_type_desc,
 listing_type_id,
 brand_type_id,
 buying_list_type_group_id,
 listing_type_group_id,
 brand_type_group_id
FROM ldl_p_lew_mart_lead.v_itm_item_list_type_hist_1;