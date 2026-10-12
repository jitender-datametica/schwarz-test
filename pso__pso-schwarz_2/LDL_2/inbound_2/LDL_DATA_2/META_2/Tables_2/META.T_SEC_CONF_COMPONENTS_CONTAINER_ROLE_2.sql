CREATE TABLE META.T_SEC_CONF_COMPONENTS_CONTAINER_ROLE_2 (
    ORG_UNIT_LEVEL_NAME VARCHAR(100) NOT NULL COMMENT 'Corrensponds to the grouping level of role defined by Controlling Department => INT - international / DL - Dienstleitung corr. to country_2 / GES - Gesellschaft corr. to company ',      
    RESSORT_NAME        VARCHAR(100) NOT NULL COMMENT 'Ressort name defined by Controlling Department => VT for Sales_2, VW for administration or VLZ - Vertrieb_Warengeschäft',      
    BUSINESS_ROLE_NAME  VARCHAR(100) NOT NULL COMMENT 'Business role name defined by Controlling Department => VS_2 Länder',
    TECHNICAL_ROLE_GROUP_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Role Type Code for coupling to roles => func - functional & data - data role type',
    TECHNICAL_ROLE_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'Role Type Code for coupling to roles => func <name> - functional roles types & data <name> - data role types',
    TECHNICAL_ROLE_NAME VARCHAR(100) NOT NULL COMMENT 'Technical role name used for role creation in IdP System like SIAM => int-vt-vs_2',      
    ROLE_NAME_SEPARATOR VARCHAR(10) NOT NULL COMMENT 'Separator => - ',
    ROLE_DESCR          VARIANT COMMENT 'Concatenation of ORG_UNIT_LEVEL_NAME - RESSORT_NAME - BUSINESS_ROLE_NAME with defined separator. Filled on later level dependent on requirement',
    DWH_CREATE_TMSP TIMESTAMP_LTZ(9) DEFAULT CURRENT_TIMESTAMP() NOT NULL COMMENT 'The point in time when this record was inserted into the table. In case of role bundling data is added manually & filled with default values',
    DWH_UPDATED_TMSP  TIMESTAMP_LTZ(9) DEFAULT CURRENT_TIMESTAMP() NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.).  In case of role bundling data is added manually & filled with default values'
)COMMENT='Table contains business data for ressort & business roles with applicable tech role name'
;