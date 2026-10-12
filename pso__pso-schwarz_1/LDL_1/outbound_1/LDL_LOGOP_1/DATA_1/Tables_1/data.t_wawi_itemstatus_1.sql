CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_itemstatus_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='CLIENT ID - CALCULATED BASED ON THE COUNTRY_1 CODE'),
wawi_instanz_kzl STRING(3) NOT NULL,
itemno STRING(18) NOT NULL,
warehouseno INTEGER NOT NULL,
status_1 INTEGER NOT NULL,
updatedby STRING(8) NOT NULL,
updatedon DATETIME NOT NULL,
reason STRING(254),
first_sale_date DATETIME,
scn BIGNUMERIC(38,0) DEFAULT 0,
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LOAD ID'),
dwh_created DATETIME NOT NULL OPTIONS(description='RECORD CREATED AT'),
dwh_updated DATETIME NOT NULL OPTIONS(description='RECORD UPDATED AT'),
dwh_valid_from DATE NOT NULL OPTIONS(description='VALID FROM DATE'),
dwh_valid_to DATE NOT NULL OPTIONS(description='VALID TO DATE'),
deleted_fg BOOL NOT NULL OPTIONS(description='FLAG IF RECORD IS DELETED'),
PRIMARY KEY (client_id, itemno, warehouseno, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - HQWAWIADM.T117_ITEMSTATUS_1 TABLE');