--==============================================================
-- Table: ts_wbs_rundungsprofile_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_rundungsprofile_2
   generated from Powerdesigner on Montag, 8. Januar 2024 08:11:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_wbs_rundungsprofile_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='KFL Country_2'),
rundungsprofil_id STRING(10) NOT NULL
OPTIONS(description='rundungsprofil_id on article-store level (SAP, table: MARK)            '),
wbs_relevant_fg BIGNUMERIC(38,0)
OPTIONS(description='1 = Roundingprofile should be used during WBS calculation            0 = Roundingprofile should not be used during WBS calculation'),
aufrundung_ab_prozent BIGNUMERIC(38,2)
OPTIONS(description='Percentage defined by user for rounding up to the amount defined in "RUNDUNG_ZIEL_EINHEIT"            aufrundung_ab_prozent :   If demand >= treshold               ==> round up            abrundung_bis_prozent   : If demand < treshold                ==> round down			            If demand is between threshold down/up  ==> Skip rounding, only rounding to Standard order unit_2 (no additonal Pal rounding!!!)'),
abrundung_bis_prozent BIGNUMERIC(38,2)
OPTIONS(description='Percentage defined by user for rounding down to the amount defined in "RUNDUNG_ZIEL_EINHEIT"            aufrundung_ab_prozent :   If demand >= treshold               ==> round up            abrundung_bis_prozent   : If demand < treshold                ==> round down			            If demand is between threshold down/up  ==> Skip rounding, only rounding to Standard order unit_2 (no additonal Pal rounding!!!)'),
rundung_ziel_einh_id STRING(3) OPTIONS(description='Target-value for Rounding (PAL,HPL)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, rundungsprofil_id) NOT ENFORCED
)
OPTIONS(description='WBS_TP1: This table contains settings for WB\'s calculation on article-store level,             the quantity from "intermidiate order quantity" of TP1 need to be rounded based on the customizing If a rounding profile is assigned to article-store compinationl in the SAP table\' Mark\'             the content is maintained by transaction services document(excel file "Customizing_CW_0_2")             the table is loaded manually for the first time and the users can add or maintain the entries.');