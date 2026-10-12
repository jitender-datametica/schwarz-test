/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2024-06-28 Pawel Wieczorek    Initial version feature/AP0225100_Attributes_About_Me
#------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_ref_household_type_2
COMMENT = 'Lidlplus : type of the household'
(
 household_type_id              COMMENT 'ID of the household type in which the customer lives.'
,household_type_descr           COMMENT 'Description of the household type in which the customer lives.'
,load_id                        COMMENT 'Load identifier'
,dwh_created                    COMMENT 'Row create time'
,dwh_updated                    COMMENT 'Row update time'
)
AS
SELECT
 t.household_type_id
,t.household_type_descr
,t.load_id
,t.dwh_created
,t.dwh_updated
FROM p_lew_mart_lidl_digital.v_ref_household_type_2 AS t
;