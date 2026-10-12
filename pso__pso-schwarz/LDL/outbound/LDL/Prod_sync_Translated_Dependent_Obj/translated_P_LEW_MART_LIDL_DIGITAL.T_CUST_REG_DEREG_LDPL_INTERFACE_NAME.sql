CREATE OR REPLACE TABLE ldl_p_lew_mart_lidl_digital.t_cust_reg_dereg_ldpl_interface_name (
reg_interface_id INTEGER NOT NULL
OPTIONS(description='ID of the registration interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
reg_interface_name STRING(100) NOT NULL
OPTIONS(description='Name of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
reg_interface_grp_id INTEGER NOT NULL
OPTIONS(description='ID of the interface through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row created time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (reg_interface_id) NOT ENFORCED
) OPTIONS(description=' Lidlplus: Table to provide lookup for registration interface name');