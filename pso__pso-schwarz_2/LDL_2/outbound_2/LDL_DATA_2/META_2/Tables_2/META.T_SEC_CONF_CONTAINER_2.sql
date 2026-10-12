CREATE TABLE IF NOT EXISTS ldl_data_meta.t_sec_conf_container_2 (
idp_container_type_cd STRING(50) NOT NULL
OPTIONS(description='Container Type Code => L10 for application roles / L20 for for functional & data container => l2-ldl-sec-func or l2-ldl-sec-data'),
technical_role_group_type_cd STRING(50) NOT NULL
OPTIONS(description='Role Type Code for coupling to roles => func - functional & data - data role type'),
technical_role_type_cd STRING(50) NOT NULL
OPTIONS(description='Role Type Code for coupling to roles => func <name> - functional roles types & data <name> - data role types'),
container_purpose_type_name STRING(100) NOT NULL
OPTIONS(description='Container purpose type name like Row level security / Access Control List'),
container_name STRING(100) NOT NULL
OPTIONS(description='Container name being created in IdP like snow / l-mstr-leadenterprise / l-mstr-leadreporting4u. Convention => 1 l-mstr Role per MSTR-Project (environment independent!) & 1 snow-xx Role per database/division & scope (e.g. country_2 level)'),
container_name_separator STRING(10) NOT NULL OPTIONS(description='Separator => - or -xx- '),
dwh_create_tmsp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table. In case of role bundling data is added manually & filled with default values'),
dwh_updated_tmsp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.).  In case of role bundling data is added manually & filled with default values')
) OPTIONS(description='Table contains container name for L10 & L20 roles for usage in role generation process');