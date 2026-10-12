CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_components_container_role_2 (
org_unit_level_name STRING(100) NOT NULL
OPTIONS(description='Corrensponds to the grouping level of role defined by Controlling Department => INTEGER - international / DL - Dienstleitung corr. to country_2 / GES - Gesellschaft corr. to company '),
ressort_name STRING(100) NOT NULL
OPTIONS(description='Ressort name defined by Controlling Department => VT for Sales_2, VW for administration or VLZ - Vertrieb_Warengeschäft'),
business_role_name STRING(100) NOT NULL
OPTIONS(description='Business role name defined by Controlling Department => VS_2 Länder'),
technical_role_group_type_cd STRING(50) NOT NULL
OPTIONS(description='Role Type Code for coupling to roles => func - functional & data - data role type'),
technical_role_type_cd STRING(50) NOT NULL
OPTIONS(description='Role Type Code for coupling to roles => func <name> - functional roles types & data <name> - data role types'),
technical_role_name STRING(100) NOT NULL
OPTIONS(description='Technical role name used for role creation in IdP System like SIAM => INTEGER-vt-vs_2'),
role_name_separator STRING(10) NOT NULL OPTIONS(description='Separator => - '),
role_descr JSON
OPTIONS(description='Concatenation of ORG_UNIT_LEVEL_NAME - RESSORT_NAME - BUSINESS_ROLE_NAME with defined separator. Filled on later level dependent on requirement'),
dwh_create_tmsp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table. In case of role bundling data is added manually & filled with default values'),
dwh_updated_tmsp TIMESTAMP DEFAULT CURRENT_TIMESTAMP() NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.).  In case of role bundling data is added manually & filled with default values')
) OPTIONS(description='Table contains business data for ressort & business roles with applicable tech role name');