/*

#===============================================================================
# History
#  1.0 2024-07-02 Pawel Wieczorek    Initial version feature/AP0225100_Attributes_About_Me


#===============================================================================
#
*/

/* ==============================================================================
   View DDL
   ============================================================================== */

CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_cust_demogr
COMMENT = 'Lidlplus : demographical data'
(
 client_id                      COMMENT 'Client identifier'
,customer_sid                   COMMENT 'Surrogate Key CUSTOMER'
,gender_cd                      COMMENT 'The code for the gender'
,age_range_cd                   COMMENT 'The code for the age range.'
,load_id                        COMMENT 'Load identifier'
,dwh_created                    COMMENT 'Row create time'
,dwh_updated                    COMMENT 'Row update time'
,household_type_id              COMMENT 'ID of the household type in which the customer lives.'
,child_age_range_group_id       COMMENT 'Group of one or more age ranges in which the child is categorized depending on the age.'
,child_age_range_group_fg       COMMENT 'Age range group indicator, Y when child_age_range_group_id > 0 else N'
)
AS
SELECT
 t.client_id
,t.customer_sid
,t.gender_cd
,t.age_range_cd
,t.load_id
,t.dwh_created
,t.dwh_updated
,t.household_type_id
,t.child_age_range_group_id
,t.child_age_range_group_fg
FROM p_lew_mart_lidl_digital.v_cust_demogr AS t
;