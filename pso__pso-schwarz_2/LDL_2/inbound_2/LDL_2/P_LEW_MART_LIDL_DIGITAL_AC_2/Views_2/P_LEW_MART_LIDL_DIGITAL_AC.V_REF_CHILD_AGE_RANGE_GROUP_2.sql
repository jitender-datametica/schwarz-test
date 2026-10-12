/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2024-06-28 Pawel Wieczorek    Initial version feature/AP0225100_Attributes_About_Me
#  1.1 2024-09-12 Pawel Wieczorek    feature/AP0225100_Attributes_About_Me Added column
#------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_ref_child_age_range_group_2
COMMENT = 'Lidlplus : grouped age ranges of children'
(
 child_age_range_group_id       COMMENT 'Group age range identifier'
,child_age_range_cd             COMMENT 'Code of the age range in which the child is categorized depending on the age.'
,child_age_range_name           COMMENT 'Name of the child age range.'
,child_age_range_descr          COMMENT 'Description of the child age range.'
,child_age_range_short_descr    COMMENT 'Short description of the child age range.'
,load_id                        COMMENT 'Load identifier'
,dwh_created                    COMMENT 'Row create time'
,dwh_updated                    COMMENT 'Row update time'
)
AS
SELECT
 t.child_age_range_group_id
,t.child_age_range_cd
,t.child_age_range_name
,t.child_age_range_descr
,t.child_age_range_short_descr
,t.load_id
,t.dwh_created
,t.dwh_updated
FROM p_lew_mart_lidl_digital.v_ref_child_age_range_group_2 AS t
;