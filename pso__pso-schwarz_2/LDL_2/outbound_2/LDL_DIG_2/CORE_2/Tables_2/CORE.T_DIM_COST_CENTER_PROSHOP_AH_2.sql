/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COST_CENTER_PROSHOP_AH_2
   GENERATED FROM POWERDESIGNER ON Freitag, 10. Februar 2023 11:39:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_cost_center_proshop_ah_2 (
ctrl_area_cd STRING(5) NOT NULL OPTIONS(description='Code of the Controlling Area'),
cost_center_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the Cost Center'),
cc_valid_from_dt DATE NOT NULL OPTIONS(description='The date from which this Cost Center can be used in bookings'),
cc_valid_to_dt DATE OPTIONS(description='The date till which this Cost Center can be used in bookings'),
cc_group_lvl3_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group  to which the CC Group lvl 4 belongs according to the alternative Hierarchy_2 1'),
cc_group_lvl3_name_en STRING(100)
OPTIONS(description='Name of the level 3 Cost Center Group in English (alternative hierarchy_2 1)'),
cc_group_lvl3_name_de STRING(100)
OPTIONS(description='Name of the level 3 Cost Center Group in German (alternative hierarchy_2 1)'),
cc_group_lvl2_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group  to which the CC Group lvl 3 belongs according to the alternative Hierarchy_2 1'),
cc_group_lvl2_name_en STRING(100)
OPTIONS(description='Name of the level 2 Cost Center Group in English (alternative hierarchy_2 1)'),
cc_group_lvl2_name_de STRING(100)
OPTIONS(description='Name of the level 2 Cost Center Group in German (alternative hierarchy_2 1)'),
cc_group_lvl1_nr STRING(20)
OPTIONS(description='Identifier of the Cost Center Group  to which the CC Group lvl 2 belongs according to the alternative  Hierarchy_2 1'),
cc_group_lvl1_name_en STRING(100)
OPTIONS(description='Name of the level1 Cost Center Group in English (alternative hierarchy_2 1)'),
cc_group_lvl1_name_de STRING(100)
OPTIONS(description='Name of the level1 Cost Center Group in German (alternative hierarchy_2 1)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ctrl_area_cd, cost_center_nr, cc_valid_from_dt) NOT ENFORCED
)
OPTIONS(description='The table describes alternative hierarchy_2 of Cost Center Groups and their relationship to Cost Centers (top element =\'PSHOP_D888\')');