CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_price_scenario_2 (
mdm_price_scenario_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='identifier of the price scenario'),
mdm_price_type_cd STRING(100) OPTIONS(description='representing code of the price type'),
lob_cd STRING(5) COLLATE 'und:ci'
OPTIONS(description='line of business code \'LDL\',\'KFL\', distinguishes between Lidl and Kaufland related clients'),
market_sid BIGNUMERIC(38,0)
OPTIONS(description='''foreign key NFPO market
            depends on source column name by scenario'''),
incoterm_cd STRING(100) OPTIONS(description='code of the incoterm used to specify the scenario'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_price_scenario_nr) NOT ENFORCED
)
OPTIONS(description='''price scenarios used in the non food product development and ordering process drived from price types and the used additional dimentsion lob, market
             prices which are differenciated by targeted intenal organisation are not included here''');