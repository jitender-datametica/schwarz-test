/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of case orientation.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_SPACEMAN_CASE_ORIENTATION_1
(
     case_orientation_cd
    ,case_orientation_descr
)
AS
SELECT co.case_orientation_cd
     , co.case_orientation_descr
FROM   P_LEW_CORE_AC.v_ref_spaceman_case_orientation_1 co;