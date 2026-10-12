CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_mstr_object (
mstr_obj_sid INTEGER NOT NULL
OPTIONS(description='The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups'),
mstr_proj_nr STRING(32) OPTIONS(description='The Project ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_obj_nr STRING(32) OPTIONS(description='The Object ID, which represents the GUID from MicroStrategy-Metadata'),
mstr_obj_name STRING(255) NOT NULL OPTIONS(description='The Name of the MicroStrategy Object default metadata language'),
obj_type_cd STRING(20) NOT NULL
OPTIONS(description='The Type of the MicroStrategy Apllication, if it is Report, Metric, Dossier ....'),
conf_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp, the configuration is updated or inserted'),
PRIMARY KEY (mstr_obj_sid) NOT ENFORCED
)
OPTIONS(description='The configuration table which contains the information about the objects like reports,dossiers but also ressort user groups of metrics for object security but');