/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2023-11-08 Pawel Wieczorek    Initial version AP0069622 demographics
#  1.1 2024-06-28 Pawel Wieczorek    feature/AP0225100_Attributes_About_Me Added columns: household_type_id, child_age_range_group_id  
#  1.2 2024-10-28 Pawel Wieczorek    feature/AP0225100_Attributes_About_Me remove empty line
#  1.3 2024-10-29 Pawel Wieczorek    feature/AP0225100_Attributes_About_Me I need to change to n cause that way the pipeline created table on the Q!?!
#
#------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_cust_demogr (
client_id INTEGER NOT NULL OPTIONS(description='Client identifier'),
customer_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key CUSTOMER'),
gender_cd STRING(5) NOT NULL OPTIONS(description='The code for the gender'),
age_range_cd STRING(10) NOT NULL OPTIONS(description='The code for the age range.'),
load_id INTEGER NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
household_type_id INTEGER DEFAULT 0 OPTIONS(description='ID of the household type in which the customer lives.'),
child_age_range_group_id INTEGER DEFAULT 0
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
child_age_range_group_fg STRING(1) DEFAULT 'n'
OPTIONS(description='Age range group indicator, Y when child_age_range_group_id > 0 else N'),
PRIMARY KEY (customer_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : demographical data');