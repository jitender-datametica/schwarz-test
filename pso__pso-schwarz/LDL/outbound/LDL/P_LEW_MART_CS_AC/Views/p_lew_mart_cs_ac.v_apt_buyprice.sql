/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.v_apt_buyprice
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  23.01.2025    Ulrich, Ross                 Add column price_special_cond Special Conditions like Zoll, Entsorgung Papier/Kunststoff...
#                                                  https://dev.azure.com/schwarzit/schwarzit.biaid/_workitems/edit/704040
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_apt_buyprice (client_id, country_iso_cd, wh_id, org_item_nr,
valid_from_item, case_size, org_supplier_nr, valid_from, valid_until, price_buying, price_special_cond,
currency_iso_code, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_apt_buyprice;