/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_REGIONAL_PRODUCT_MANAGER_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 19. September 2024 10:36:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_regional_product_manager_2 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
reg_prod_manager_cd STRING(10) NOT NULL OPTIONS(description='A code indentifiyng the regional product manager.'),
reg_prod_manager_name STRING(100)
OPTIONS(description='Full name (first name + family name) of the regional product manager.'),
reg_prod_manager_team_name STRING(100)
OPTIONS(description='Name of the team to which the regional product manager belongs.'),
reg_prod_manager_team_lead_name STRING(100)
OPTIONS(description='Full name (first name + family name) of the person who is the leader of the regional product management team.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, reg_prod_manager_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension contains data about regional product managers, their respective teams and team lead names.');