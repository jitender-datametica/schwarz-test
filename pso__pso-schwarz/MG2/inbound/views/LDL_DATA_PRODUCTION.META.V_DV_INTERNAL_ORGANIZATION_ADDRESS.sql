create or replace view LDL_DATA_PRODUCTION.META.V_DV_INTERNAL_ORGANIZATION_ADDRESS(
	INT_ORG_SID,
	INTERNAL_ORGANIZATION_DWH_VALID_FROM_TMSP,
	INTERNAL_ORGANIZATION_DWH_VALID_TO_TMSP,
	PARTY_SID,
	ADDR_SID,
	PARTY_ADDRESS_DWH_VALID_TO_TMSP,
	PARTY_ADDRESS_DWH_VALID_FROM_TMSP,
	ADDR_TYPE_CD,
	ADDR_USG_TYPE_CD,
	STREET_ADDR_SID,
	DISTRICT_NAME,
	STREET_NAME,
	HOUSE_NR,
	ZIP,
	STREET_ADDRESS_DWH_VALID_FROM_TMSP,
	STREET_ADDRESS_DWH_VALID_TO_TMSP,
	FAILED_IO_STREET_ADDRESS_CONSISTENT,
	FAILED_IO_STREET_ADDRESS_COMPLETE,
	TOTAL
) COMMENT='Check consistency and completeness of internal organization address fields in core_rel.t_party_address and core_rel.t_street_address\ninput datasets:\ncore_rel.t_internal_organization\ncore_rel.t_party_address\ncore_rel.t_street_address'
 as SELECT internal_organization.int_org_sid, internal_organization.dwh_valid_from_tmsp AS internal_organization_dwh_valid_from_tmsp, internal_organization.dwh_valid_to_tmsp AS internal_organization_dwh_valid_to_tmsp, party_address.party_sid, party_address.addr_sid, party_address.dwh_valid_to_tmsp AS party_address_dwh_valid_to_tmsp, party_address.dwh_valid_from_tmsp AS party_address_dwh_valid_from_tmsp, party_address.addr_type_cd , party_address.addr_usg_type_cd, street_address.street_addr_sid, street_address.district_name, street_address.street_name, street_address.house_nr, street_address.zip, street_address.dwh_valid_from_tmsp AS street_address_dwh_valid_from_tmsp, street_address.dwh_valid_to_tmsp AS street_address_dwh_valid_to_tmsp, CASE WHEN party_address.addr_sid IS NULL THEN 1 ELSE 0 END AS FAILED_IO_STREET_ADDRESS_CONSISTENT, CASE WHEN ( party_address.addr_sid IS NOT NULL AND street_address.district_name IS NULL AND street_address.street_name IS NULL AND street_address.house_nr IS NULL AND street_address.zip IS NULL ) THEN 1 ELSE 0 END AS FAILED_IO_STREET_ADDRESS_COMPLETE, 1 AS TOTAL FROM CORE_REL.T_INTERNAL_ORGANIZATION internal_organization LEFT JOIN CORE_REL.T_PARTY_ADDRESS party_address ON internal_organization.int_org_sid = party_address.party_sid AND internal_organization.dwh_valid_from_tmsp <= party_address.dwh_valid_to_tmsp AND internal_organization.dwh_valid_to_tmsp >= party_address.dwh_valid_from_tmsp AND party_address.addr_type_cd = 'STAD' AND party_address.addr_usg_type_cd = 'SA_MN' LEFT JOIN CORE_REL.T_STREET_ADDRESS street_address ON street_address.street_addr_sid = party_address.addr_sid AND street_address.dwh_valid_from_tmsp <= least(internal_organization.dwh_valid_to_tmsp,party_address.dwh_valid_to_tmsp) AND street_address.dwh_valid_to_tmsp >= greatest(internal_organization.dwh_valid_from_tmsp,party_address.dwh_valid_from_tmsp);