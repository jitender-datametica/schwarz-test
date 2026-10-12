CREATE TABLE META.T_SEC_CONF_MSTR_OBJECT_2 (
    mstr_obj_sid                        NUMERIC(38,0)   NOT NULL COMMENT 'The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups' 
 ,  mstr_proj_nr                        VARCHAR(32)     COMMENT 'The Project ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_obj_nr                         VARCHAR(32)     COMMENT 'The Object ID, which represents the GUID from MicroStrategy-Metadata' 
 ,  mstr_obj_name                       VARCHAR(255)    NOT NULL COMMENT 'The Name of the MicroStrategy Object default metadata language' 
 ,  obj_type_cd                         VARCHAR(20)     NOT NULL COMMENT 'The Type of the MicroStrategy Apllication, if it is Report, Metric, Dossier ....' 
 ,  conf_tmsp                           TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The timestamp, the configuration is updated or inserted' 
 ,  CONSTRAINT PK_T_SEC_CONF_MSTR_OBJECT PRIMARY KEY (mstr_obj_sid) NOT ENFORCED
 )  COMMENT= 'The configuration table which contains the information about the objects like reports,dossiers but also ressort user groups of metrics for object security but';
