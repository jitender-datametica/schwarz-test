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


CREATE TABLE P_LEW_MART_CS.T_APT_BUYPRICE
(
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
wh_id NUMBER(38) NOT NULL,
org_item_nr NUMBER(38) NOT NULL,
valid_from_item DATE NOT NULL,
case_size NUMBER(38) NOT NULL,
org_supplier_nr NUMBER(38) NOT NULL,
valid_from DATE,
valid_until DATE,
price_buying DECIMAL(18,5),
price_special_cond DECIMAL(18,5),
currency_iso_code VARCHAR(20) COLLATE 'en-ci',
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
;


