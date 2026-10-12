CREATE TABLE s_conl_workbench.t_i_cost_sapbw_logistics_2
(
booking_month INTEGER,
business_year INTEGER,
booking_period INTEGER,
booking_date DATE /*** MSC-WARNING - MSCEWI2040 - FORMAT 'YY/MM_2/DD' NOT SUPPORTED ***/,
corporate_division_id VARCHAR(2),
corporate_division_desc VARCHAR(25),
warehouse_desc_short VARCHAR(5),
warehouse_desc VARCHAR(20),
cost_center INTEGER,
referencekey INTEGER,
cost_category VARCHAR(75),
nat_account_number INTEGER,
nat_account_desc VARCHAR(75),
inat_account_number2 VARCHAR(25),
inat_account_desc2 VARCHAR(75),
inat_account_number VARCHAR(25),
inat_account_desc VARCHAR(75),
value_costs DECIMAL(20,5));


