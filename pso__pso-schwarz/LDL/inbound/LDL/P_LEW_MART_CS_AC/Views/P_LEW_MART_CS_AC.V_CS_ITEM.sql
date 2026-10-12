/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_ITEM
/*
#DescStart#
#$Revision: 14710 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , orig_item_nr
    , case_size
    , orig_item_nr_int
    , country_iso_cd
    , is_plu_item
    , buying_list_type_id
    , plu_nr
    , unitsize
    , dwh_updated
    , dwh_created
    , dwh_load_id
)
AS
SELECT
client_id,
orig_item_nr,
case_size,
orig_item_nr_int,
country_iso_cd,
is_plu_item,
buying_list_type_id,
plu_nr,
unitsize,
dwh_updated,
dwh_created,
dwh_load_id
FROM p_lew_mart_cs.v_cs_item
;