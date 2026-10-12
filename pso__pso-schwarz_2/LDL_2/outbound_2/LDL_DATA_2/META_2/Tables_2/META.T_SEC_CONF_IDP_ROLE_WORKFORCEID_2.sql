CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_conf_idp_role_workforceid_2 (
idp_array_full_name ARRAY < STRING >OPTIONS(description='Value represents the full string exported from IdP includung container & role name'),
idp_container_name STRING(100) NOT NULL
OPTIONS(description='Container name being created in IdP like snow / l-mstr-leadenterprise / l-mstr-leadreporting4u. Convention => 1 l-mstr Role per MSTR-Project (environment independent!) & 1 snow-xx Role per database/division & scope (e.g. country_2 level)'),
idp_full_role_name STRING(100) OPTIONS(description='Full IdP (e.g. SIAM) role name generated via MERGE from Components'),
workforce_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Overarching IDs extracted from IDP for a global (SIT wide) identification of roles'),
dwh_create_tmsp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table. In case of role bundling data is added manually & filled with default values'),
dwh_updated_tmsp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.).  In case of role bundling data is added manually & filled with default values')
) OPTIONS(description='Table contains technical Idp container & role name with applicable tech workforce ID');