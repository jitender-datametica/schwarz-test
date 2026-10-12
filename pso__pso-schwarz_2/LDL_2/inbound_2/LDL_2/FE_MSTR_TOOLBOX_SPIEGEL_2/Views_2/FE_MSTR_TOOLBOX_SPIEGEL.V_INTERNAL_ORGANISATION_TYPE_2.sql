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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_INTERNAL_ORGANISATION_TYPE_2
(
    int_org_type_cd
    ,int_org_type_name
    ,int_org_type_descr
)
AS
SELECT intorgtype.int_org_type_cd
     , intorgtype.int_org_type_name
     , intorgtype.int_org_type_descr
FROM   P_LEW_CORE_AC.v_internal_organisation_type_2 intorgtype
WHERE int_org_type_cd = 'SPACEMAN';