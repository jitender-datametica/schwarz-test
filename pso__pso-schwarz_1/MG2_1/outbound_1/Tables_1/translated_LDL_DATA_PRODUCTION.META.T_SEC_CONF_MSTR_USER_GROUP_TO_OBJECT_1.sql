CREATE OR REPLACE TABLE ldl_data_production_meta.t_sec_conf_mstr_user_group_to_object_1 (
mstr_bus_user_grp_sid INTEGER NOT NULL
OPTIONS(description='The surrogate key of business user groups will be created in MicroStrategy Environment'),
mstr_obj_sid INTEGER NOT NULL
OPTIONS(description='The surrogate key of MicroStrategy Objects will be created in MicroStrategy Project or User Groups'),
conf_active_from_dt DATE NOT NULL OPTIONS(description='The point in time when this record became valid.'),
conf_active_to_dt DATE NOT NULL OPTIONS(description='The point in time when this record was no longer valid.'),
conf_active_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between conf_valid_from and conf_valid_to.'),
request_status_cd STRING(20) NOT NULL
OPTIONS(description='The status_1 of a grant status_1 if it is approved, requested or denied.'),
granted_fg BOOL NOT NULL OPTIONS(description='The value of granted flag, if a user group has an access or not'),
requestor_user_name STRING(100) NOT NULL OPTIONS(description='The MSTR-User who enters the value to the system'),
request_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point of the time, when the entry is done.'),
approver_user_name STRING(100) OPTIONS(description='The MSTR-User who approves the value entered to the system'),
approved_tmsp TIMESTAMP OPTIONS(description='The point of the time when the entry is approved.'),
PRIMARY KEY (mstr_bus_user_grp_sid, mstr_obj_sid, conf_active_from_dt) NOT ENFORCED
)
OPTIONS(description='The relationship table which contains the information which user is allowed to access which object ( Report,Dossier, Metric ACL)');