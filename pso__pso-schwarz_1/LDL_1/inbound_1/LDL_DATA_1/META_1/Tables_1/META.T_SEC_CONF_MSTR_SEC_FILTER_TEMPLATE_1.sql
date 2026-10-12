CREATE TABLE META.T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE_1 (
    mstr_proj_nr                        VARCHAR(32)     NOT NULL COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_sec_filter_template_name       VARCHAR(255)    NOT NULL COMMENT 'The name of the security filter (also kind of Identifier)' 
 ,  mstr_sec_filter_extension_txt       VARCHAR(255)    NOT NULL COMMENT 'The name extension of security filter, which will be append to prefix defined at project level' 
 ,  sf_role_user_lvl_cd                 VARCHAR(20)     NOT NULL COMMENT 'The level of the organisation unit_1 COUNTRY_1/SALES_1 COMPANY/SALES_1 MANAGER... that the security filter is used' 
 ,  conf_tmsp                           TIMESTAMP_LTZ(9) COMMENT 'The timestamp, the configuration is updated or inserted' 
 ,  CONSTRAINT PK_T_SEC_CONF_MSTR_SEC_FILTER_TEMPLATE PRIMARY KEY (mstr_proj_nr, mstr_sec_filter_template_name) NOT ENFORCED
 )  COMMENT= 'The configuration table which contains the relationship which security filter is set to which organisation unit_1';
