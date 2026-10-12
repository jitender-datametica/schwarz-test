/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for <schema name>.<table or view name>
#----------------------------------------------------------------------------
# History:
#   1.0            15.03.2021        Oguzhan Guenes           checking tables creating scripts
#                                                             https://jira.schwarz/browse/DDLE-1783
#                                                             Create scripts for snowflake standardisation.
#   1.1            23.01.2025        Ulrich, Ross             Add column price_special_cond Special Conditions like Zoll, Entsorgung Papier/Kunststoff...
#                                                             https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/704040
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_apt_buyprice_2 (
client_id BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
wh_id BIGNUMERIC(38) NOT NULL,
org_item_nr BIGNUMERIC(38) NOT NULL,
valid_from_item DATE NOT NULL,
case_size BIGNUMERIC(38) NOT NULL,
org_supplier_nr BIGNUMERIC(38) NOT NULL,
valid_from DATE,
valid_until DATE,
price_buying NUMERIC(18,5),
price_special_cond NUMERIC(18,5),
currency_iso_code STRING(20) COLLATE 'und:ci',
cs_updated DATETIME NOT NULL,
cs_created DATETIME NOT NULL,
cs_load_id BIGNUMERIC(38) NOT NULL
);