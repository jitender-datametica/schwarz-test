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

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_LDPL_DISCOUNT_TYPE_DESC_1
COMMENT = 'Lidl Plus Discount Type Description'
(
 discount_type_id          COMMENT 'Discount type identifier'
,discount_type_desc        COMMENT 'Discount type description per language'
,lang_cd                   COMMENT 'Language code'
,dwh_load_id               COMMENT 'Load identifier'            
,dwh_created               COMMENT 'Row insert time'           
,dwh_updated               COMMENT 'Row update time'            
)
AS
SELECT
 discount_type_id
,discount_type_desc
,lang_cd
,dwh_load_id
,dwh_created
,dwh_updated
FROM P_LEW_PROCESS_MSTR.T_REF_LDPL_DISCOUNT_TYPE_DESC_1;
