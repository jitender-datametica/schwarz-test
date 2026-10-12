CREATE TABLE IF NOT EXISTS ldl_logop_data.t_elke_hour_tracking (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lgnum)'),
tracking_dt DATE NOT NULL OPTIONS(description='Tracking date'),
net_hours_warehouse_organization BIGNUMERIC(38,5)
OPTIONS(description='Net working hours of logistics manager and the surrounding team (e.g. assistant, secretary, student)'),
subset_additional_and_reduced_hours_warehouse_organization BIGNUMERIC(38,5)
OPTIONS(description='This columns shows the difference of net working time in comparison to the planned working time of the day. It can be entered as positive or negative values. The figures are a partial value of net hours warehouse organization.'),
operational_onboarding_warehouse_organization BIGNUMERIC(38,5)
OPTIONS(description='This column adds the net working time of employees that are currently in the onboarding process. The operational onboarding includes employees who are assigned to their target position in warehouse operations.'),
strategic_onboarding_warehouse_organization BIGNUMERIC(38,5)
OPTIONS(description='This column adds the net working time of employees that are currently in the onboarding process. The strategic onboarding is aimed at all employees who will not work directly in the warehouse operations. The hours are just counting with 40% into the total hours of the area.'),
external_hours_warehouse_organization BIGNUMERIC(38,5)
OPTIONS(description='Actual working time of external employees and service providers. Data entry based on reference profiles for warehouse tasks.'),
subset_participation_training_warehouse_organization BIGNUMERIC(38,5)
OPTIONS(description='Training measures are supporting the learning and improvement of skills and abilities. Training hours include meetings, external events and internal training. In this column, the training hours are shown as a partial value of the total hours of warehouse organization.'),
subset_working_union BIGNUMERIC(38,5)
OPTIONS(description='Hours that are spent on activites for labor union. The hours are shown as a partial value of the total warehouse hours.'),
net_hours_process BIGNUMERIC(38,5)
OPTIONS(description='Net working hours of department leader and employees in control center (goods-in, tour and pick planning).'),
subset_additional_and_reduced_hours_process BIGNUMERIC(38,5)
OPTIONS(description='This columns shows the difference of net working time in comparison to the planned working time of the day. It can be entered as positive or negative values. The figures are a partial value of net hours process.'),
operational_onboarding_process BIGNUMERIC(38,5)
OPTIONS(description='This column adds the net working time of employees that are currently in the onboarding process. The operational onboarding includes employees who are assigned to their target position in warehouse operations.'),
strategic_onboarding_process BIGNUMERIC(38,5)
OPTIONS(description='This column adds the net working time of employees that are currently in the onboarding process. The strategic onboarding is aimed at all employees who will not work directly in the warehouse operations. The hours are just counting with 40% into the total hours of the area.'),
external_hours_process BIGNUMERIC(38,5)
OPTIONS(description='Actual working time of external employees and service providers. Data entry based on reference profiles for warehouse tasks.'),
subset_participation_training_process BIGNUMERIC(38,5)
OPTIONS(description='Training measures are supporting the learning and improvement of skills and abilities. Training hours include meetings, external events and internal training. In this column, the training hours are shown as a partial value of the total hours of process.'),
picks_scans_returns BIGNUMERIC(38,5)
OPTIONS(description='The cells contain all returned articels from stores. The scanning and counting is done in the warehouse. '),
net_hours_operation BIGNUMERIC(38,5)
OPTIONS(description='Net working hours of department leader and employees with operational tasks. (picker, forklift driver, goods-in counting, recycling, returns)'),
subset_additional_and_reduced_hours_operation BIGNUMERIC(38,5)
OPTIONS(description='This columns shows the difference of net working time in comparison to the planned working time of the day. It can be entered as positive or negative values. The figures are a partial value of net hours operation.'),
operational_onboarding_operation BIGNUMERIC(38,5)
OPTIONS(description='This column adds the net working time of employees that are currently in the onboarding process. The operational onboarding includes employees who are assigned to their target position in warehouse operations.'),
strategic_onboarding_operation BIGNUMERIC(38,5)
OPTIONS(description='This column adds the net working time of employees that are currently in the onboarding process. The strategic onboarding is aimed at all employees who will not work directly in the warehouse operations. The hours are just counting with 40% into the total hours of the area.'),
external_hours_operation BIGNUMERIC(38,5)
OPTIONS(description='Actual working time of external employees and service providers. Data entry based on reference profiles for warehouse tasks.'),
subset_goods_in BIGNUMERIC(38,5)
OPTIONS(description='Sum of hours that have been used for the goods-in process. It is a partial value of total hours operation that add up different tasks.'),
subset_supply_of_good BIGNUMERIC(38,5)
OPTIONS(description='Sum of hours that have been used for the goods supply process within the warehouse. It is a partial value of total hours operation that add up different tasks.'),
subset_returns BIGNUMERIC(38,5)
OPTIONS(description='This column shows the hours that have been used for the goods return from stores. It includes for example checking and scanning the products.'),
subset_participation_in_training_operations BIGNUMERIC(38,5)
OPTIONS(description='Training measures are supporting the learning and improvement of skills and abilities. Training hours include meetings, external events and internal training. In this column, the training hours are shown as a partial value of the total hours of operation.'),
subset_tax_stamp BIGNUMERIC(38,5)
OPTIONS(description='Hours spent on tax declaration from internal and external employees.'),
subset_stickers BIGNUMERIC(38,5)
OPTIONS(description='Hours spent on national declaration from internal and external employees.'),
subset_inventory_check BIGNUMERIC(38,5)
OPTIONS(description='Hours spent on stock-taking from internal and external employees.'),
subset_repacking BIGNUMERIC(38,5)
OPTIONS(description='Hours spent on repacking from internal and external employees. For example goods transfer from EP to DD pallet'),
net_hours_maintenance_automatization BIGNUMERIC(38,5)
OPTIONS(description='Net working hours of department leader and employees that are working with automated systems.'),
subset_additional_and_reduced_hours_maintenance_automatization BIGNUMERIC(38,5)
OPTIONS(description='This columns shows the difference of net working time in comparison to the planned working time of the day. It can be entered as positive or negative values. The figures are a partial value of net hours maintenance automatization.'),
operational_onboarding_maintenance_automatization BIGNUMERIC(38,5)
OPTIONS(description='This column adds the net working time of employees that are currently in the onboarding process. The operational onboarding includes employees who are assigned to their target position in warehouse operations.'),
strategic_onboarding_maintenance_automatization BIGNUMERIC(38,5)
OPTIONS(description='This column adds the net working time of employees that are currently in the onboarding process. The strategic onboarding is aimed at all employees who will not work directly in the warehouse operations. The hours are just counting with 40% into the total hours of the area.'),
external_hours_maintenance_automatization BIGNUMERIC(38,5)
OPTIONS(description='Actual working time of external employees and service providers. Data entry based on reference profiles for warehouse tasks.'),
subset_organizational_activities BIGNUMERIC(38,5)
OPTIONS(description='Net working time spent on administrative and organizational tasks. For example managing tender, invoice verification, comparison of offers or inquiries from authorities.'),
subset_processing_checklists BIGNUMERIC(38,5)
OPTIONS(description='Hours spent for maintaining checklists and implementing LOS.'),
subset_self_repair_and_troubleshooting BIGNUMERIC(38,5)
OPTIONS(description='Hours for maintenance, repair and trouble-shooting. For example testing and cleaning of technical systems and devices.'),
subset_on_call_service BIGNUMERIC(38,5)
OPTIONS(description='Net working time resulting from on-call duty. The hours resulting from unscheduled demand situations. The value is including set-up time, arrival, problem resolution and departure.'),
subset_supervision_external_service_providers BIGNUMERIC(38,5)
OPTIONS(description='Time spent on the support and control of external service providers. This includes briefing, checks and administrative activities. The working time of the external service provider needs to be recorded in the separate column External hours maintenance automatization.'),
subset_implementation_training BIGNUMERIC(38,5)
OPTIONS(description='Net working time required for the conception and implementation of training courses and further education. For example, instruction of logistics employees on handling forklifts.'),
subset_participation_in_training_maintenance_automatization BIGNUMERIC(38,5)
OPTIONS(description='Training measures are supporting the learning and improvement of skills and abilities. Training hours include meetings, external events and internal training. In this column, the training hours are shown as a partial value of the total hours of maintenance automatization.'),
warehouse_organization_1 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_2 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_3 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_4 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_5 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_6 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_7 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_8 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_9 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
warehouse_organization_10 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for warehouse organization department. It is country decision what information is entered.'),
process_1 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_2 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_3 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_4 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_5 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_6 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_7 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_8 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_9 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
process_10 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for process department. It is country decision what information is entered.'),
operation_1 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_2 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_3 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_4 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_5 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_6 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_7 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_8 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_9 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
operation_10 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for operation department. It is country decision what information is entered.'),
maintenance_automatization_1 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_2 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_3 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_4 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_5 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_6 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_7 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_8 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_9 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
maintenance_automatization_10 BIGNUMERIC(38,5)
OPTIONS(description='Individual data collection for maintenance automatization department. It is country decision what information is entered.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, wh_nr, tracking_dt) NOT ENFORCED
) OPTIONS(description='ELKE - Tracking of work hours');