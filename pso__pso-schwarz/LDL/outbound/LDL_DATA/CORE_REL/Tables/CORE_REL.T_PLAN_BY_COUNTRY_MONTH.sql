/* --------------------------------------------------------------------------------
   DDL for table: t_plan_by_country_month
   generated from Powerdesigner on Dienstag, 5. März 2024 20:59:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_plan_by_country_month (
reporting_country_cd STRING(20) NOT NULL OPTIONS(description='The code which identifies the reporting country.'),
cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of a calendar month in the form YYYYMM. E.g. 202101 für January 2021.'),
planned_val_type_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.'),
plan_pos_nr STRING(20) NOT NULL
OPTIONS(description='The planning position is identified in the operational planning system by a number. As several positions may be planned for the same Planned Value Type, this attribute is part of the key. In particular, the planning position number is used for plan values for stores, which have not been opened yet. A dummy number is assigned for these stores, and the planned value is related to the related internal company. (Once the real store number is known, the plan value for the internal company is expired in history, and a new plan value is added for the store.)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
planned_kpi_meas BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The planned value.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (reporting_country_cd, planned_val_type_sid, cal_month, plan_pos_nr, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Certain KPIs get planned ahead of time. This entity tracks values which are planned for a particular reporting country on monthly level. The kind of KPI is defined by the Planned Value Type Code.');