/* --------------------------------------------------------------------------------
   DDL for table: t_ref_work_group_1
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:02:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_work_group_1 (
wh_work_grp_nr STRING(100) NOT NULL
OPTIONS(description='Queue identifier from EWM which is used to group work package_1 and task.'),
wh_work_grp_descr STRING(250) OPTIONS(description='Description of the WH work group.'),
pick_area_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Picking area ID as per WAMAS.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_work_grp_nr) NOT ENFORCED
)
OPTIONS(description='The table holds references of EWM Queue to WAMAS Pick Area.             This is a global mapping that business will maintain.');