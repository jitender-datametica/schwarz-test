/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-15 Pawel Wieczorek          SD-2524 Initial version
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_LDPL_COUPON_TYPE_SUBGROUP_DESC_1
COMMENT = 'Lidl Plus Coupon Type Subgroup Description'
(
 coupon_type_subgroup_id   COMMENT 'Coupon type subgroup identifier'
,coupon_type_subgroup_desc COMMENT 'Coupon type subgroup description per language'
,lang_cd                   COMMENT 'Language code'
,dwh_load_id               COMMENT 'Load identifier'            
,dwh_created               COMMENT 'Row insert time'           
,dwh_updated               COMMENT 'Row update time'            
)
AS
SELECT
 coupon_type_subgroup_id
,coupon_type_subgroup_desc
,lang_cd
,dwh_load_id
,dwh_created
,dwh_updated
FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_COUPON_TYPE_SUBGROUP_DESC_1;

