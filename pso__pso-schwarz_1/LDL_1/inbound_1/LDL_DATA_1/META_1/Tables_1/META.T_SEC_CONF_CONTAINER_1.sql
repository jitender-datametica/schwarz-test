CREATE TABLE META.T_SEC_CONF_CONTAINER_1 (
    IDP_CONTAINER_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Container Type Code => L10 for application roles / L20 for for functional & data container => l2-ldl-sec-func or l2-ldl-sec-data',
    TECHNICAL_ROLE_GROUP_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Role Type Code for coupling to roles => func - functional & data - data role type',
    TECHNICAL_ROLE_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Role Type Code for coupling to roles => func <name> - functional roles types & data <name> - data role types',
    CONTAINER_PURPOSE_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'Container purpose type name like Row level security / Access Control List',
    CONTAINER_NAME VARCHAR(100) NOT NULL COMMENT 'Container name being created in IdP like snow / l-mstr-leadenterprise / l-mstr-leadreporting4u. Convention => 1 l-mstr Role per MSTR-Project (environment independent!) & 1 snow-xx Role per database/division & scope (e.g. country_1 level)',
    CONTAINER_NAME_SEPARATOR VARCHAR(10) NOT NULL COMMENT 'Separator => - or -xx- ',
    DWH_CREATE_TMSP TIMESTAMP_LTZ(9) DEFAULT CURRENT_TIMESTAMP() NOT NULL COMMENT 'The point in time when this record was inserted into the table. In case of role bundling data is added manually & filled with default values',
    DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) DEFAULT CURRENT_TIMESTAMP() NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.).  In case of role bundling data is added manually & filled with default values'
)COMMENT='Table contains container name for L10 & L20 roles for usage in role generation process'
;