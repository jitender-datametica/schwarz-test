CREATE OR REPLACE VIEW ldl_data_production_meta.v_dv_internal_organization_address_2 (int_org_sid,
internal_organization_dwh_valid_from_tmsp, internal_organization_dwh_valid_to_tmsp, party_sid, addr_sid,
party_address_dwh_valid_to_tmsp, party_address_dwh_valid_from_tmsp, addr_type_cd, addr_usg_type_cd, street_addr_sid,
district_name, street_name, house_nr, zip, street_address_dwh_valid_from_tmsp, street_address_dwh_valid_to_tmsp,
failed_io_street_address_consistent, failed_io_street_address_complete, total)
OPTIONS(DESCRIPTION = `CHECK CONSISTENCY AND COMPLETENESS OF INTERNAL ORGANIZATION ADDRESS_2 FIELDS IN CORE_REL.T_PARTY_ADDRESS_2 AND CORE_REL.T_STREET_ADDRESS_2\\NINPUT DATASETS:\\NCORE_REL.T_INTERNAL_ORGANIZATION_2\\NCORE_REL.T_PARTY_ADDRESS_2\\NCORE_REL.T_STREET_ADDRESS_2`)
AS SELECT internal_organization.int_org_sid,
 internal_organization.dwh_valid_from_tmsp AS internal_organization_dwh_valid_from_tmsp,
 internal_organization.dwh_valid_to_tmsp AS internal_organization_dwh_valid_to_tmsp,
 party_address.party_sid,
 party_address.addr_sid,
 party_address.dwh_valid_to_tmsp AS party_address_dwh_valid_to_tmsp,
 party_address.dwh_valid_from_tmsp AS party_address_dwh_valid_from_tmsp,
 party_address.addr_type_cd,
 party_address.addr_usg_type_cd,
 street_address.street_addr_sid,
 street_address.district_name,
 street_address.street_name,
 street_address.house_nr,
 street_address.zip,
 street_address.dwh_valid_from_tmsp AS street_address_dwh_valid_from_tmsp,
 street_address.dwh_valid_to_tmsp AS street_address_dwh_valid_to_tmsp,
  CASE
  WHEN party_address.addr_sid IS NULL
  THEN 1
  ELSE 0
  END AS failed_io_street_address_consistent,
  CASE
  WHEN street_address.district_name IS NULL AND street_address.street_name IS NULL AND street_address.house_nr IS NULL
    AND street_address.zip IS NULL AND party_address.addr_sid IS NOT NULL
  THEN 1
  ELSE 0
  END AS failed_io_street_address_complete,
 1 AS total
FROM ldl_data_production_core_rel.t_internal_organization_2 AS internal_organization
 LEFT JOIN ldl_data_production_core_rel.t_party_address_2 AS party_address ON internal_organization.int_org_sid =
      party_address.party_sid AND internal_organization.dwh_valid_from_tmsp <= party_address.dwh_valid_to_tmsp AND
     internal_organization.dwh_valid_to_tmsp >= party_address.dwh_valid_from_tmsp AND party_address.addr_type_cd =
    'STAD' AND party_address.addr_usg_type_cd = 'SA_MN'
 LEFT JOIN ldl_data_production_core_rel.t_street_address_2 AS street_address ON party_address.addr_sid = street_address.street_addr_sid
     AND street_address.dwh_valid_from_tmsp <= LEAST(internal_organization.dwh_valid_to_tmsp, party_address.dwh_valid_to_tmsp
     ) AND street_address.dwh_valid_to_tmsp >= GREATEST(internal_organization.dwh_valid_from_tmsp, party_address.dwh_valid_from_tmsp
    );