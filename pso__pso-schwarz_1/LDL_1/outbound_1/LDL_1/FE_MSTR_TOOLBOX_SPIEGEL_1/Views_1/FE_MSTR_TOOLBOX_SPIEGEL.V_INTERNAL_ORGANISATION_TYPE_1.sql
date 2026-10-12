/*
#----------------------------------------------------------------------------
# Description:
# # This view provides the lookup for internal organisation type.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_internal_organisation_type_1 (int_org_type_cd, int_org_type_name,
int_org_type_descr) AS SELECT int_org_type_cd,
 int_org_type_name,
 int_org_type_descr
FROM ldl_p_lew_core_ac.v_internal_organisation_type_1 AS INTORGTYPE
WHERE int_org_type_cd = 'SPACEMAN';