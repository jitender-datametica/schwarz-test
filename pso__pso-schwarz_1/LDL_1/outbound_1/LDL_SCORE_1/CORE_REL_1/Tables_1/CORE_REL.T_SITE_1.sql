--==============================================================
-- Table: t_site_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_site_1
   generated from Powerdesigner on Montag, 2. September 2024 14:43:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_site_1 (
site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
site_nr STRING(20) NOT NULL
OPTIONS(description='A numeric or alphanumeric value which identifies the site for the business.'),
site_abbr_name STRING(100) OPTIONS(description='A short abbreviation for the site that identifies it.'),
site_name STRING(100) OPTIONS(description='The name by which the site is known.'),
site_type_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of site e.g. TRANS = Warenumschlagplatz.'),
site_type_descr STRING(100)
OPTIONS(description='The description of the action which takes place at that particular site. TRANS = Warenumschlagsplatz'),
transpoint_type_cd STRING(20)
OPTIONS(description='The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.'),
transpoint_type_descr STRING(100)
OPTIONS(description='Describes the function of the party at that particular site. WH = Lager, HEAD = Firmensitz. '),
site_status_cd STRING(20) OPTIONS(description='The code for the status_1 of the site.'),
addr_sid BIGNUMERIC OPTIONS(description='Is the unique identifier surrogate key of the address_1'),
gln_nr STRING(13)
OPTIONS(description='The Global Location_1 Number (GLN) is part of the GS1 systems of standards. It is a simple tool used to identify a location_1 and can identify locations uniquely where required.'),
operating_company_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the company / hauler which operates the site. Either its operated by internal organization or external party. '),
operating_org_unit_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the internal organization unit_1 which operates the site. Either its operated by internal organization or external party. '),
external_wh_fg BOOL
OPTIONS(description='An indicator showing whether the warehouse is an external one to add capacity to a central warehouse.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (site_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This entity contains all sites that are known, e.g. central warehouses, cross-docks or supplier_1 sites where products are collected by the hauler.                          A site is a physical (or electronic) facility, place or area that is used in the course of conducting business. This includes, buildings, such as office buildings, factories or warehouses, as well as public (or semi-public) places, such as ports, airports or container terminals.                          A site has a physical address_1 and, typically, serves a certain purpose. (Note that large sites may have several addresses, e.g. in case there are several entrances.) A change in the address_1 does not necessarily result in a new site. A site may be located within another site.                          A site may or may not be owned or operated by the enterprise (Lidl).');