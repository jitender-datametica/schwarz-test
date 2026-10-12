/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_ARTIKELSTAMM_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_KZP_ARTIKELSTAMM_1
/*
#DescStart#
#$Revision: 14194 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , country_iso_cd
    , subitemgroup_id
    , itemfamily_cd
    , vat_id
    , itemstatus_cd
    , orig_item_nr
    , orig_item_nr_int
    , item_valid_from
    , item_valid_until
    , deleted_fg
    , itemfamily_valid_from
    , itemfamaliy_valid_until
    , smallest_unit
    , weight_fg
    , dangerous_goods_fg
    , buying_list_type_id
    , brand_name
    , load_id
)
AS
SELECT
client_id,
country_iso_cd,
subitemgroup_id,
itemfamily_cd,
vat_id,
itemstatus_cd,
orig_item_nr,
orig_item_nr_int,
item_valid_from,
item_valid_until,
deleted_fg,
itemfamily_valid_from,
itemfamaliy_valid_until,
smallest_unit,
weight_fg,
dangerous_goods_fg,
buying_list_type_id,
brand_name,
load_id
FROM p_lew_mart_cs.v_kzp_artikelstamm_1
;


