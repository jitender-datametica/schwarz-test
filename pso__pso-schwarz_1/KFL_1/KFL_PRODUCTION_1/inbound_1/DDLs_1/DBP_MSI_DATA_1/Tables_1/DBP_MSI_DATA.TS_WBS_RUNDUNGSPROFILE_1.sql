--==============================================================
-- Table: ts_wbs_rundungsprofile_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_rundungsprofile_1
   generated from Powerdesigner on Montag, 8. Januar 2024 08:11:44
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WBS_RUNDUNGSPROFILE_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'KFL Country_1',
   rundungsprofil_id                   VARCHAR(10)      NOT NULL COMMENT 'rundungsprofil_id on article-store level (SAP, table: MARK)
            ',
   wbs_relevant_fg                     NUMBER(38,0)     COMMENT '1 = Roundingprofile should be used during WBS calculation
            0 = Roundingprofile should not be used during WBS calculation',
   aufrundung_ab_prozent               NUMBER(38,2)     COMMENT 'Percentage defined by user for rounding up to the amount defined in "RUNDUNG_ZIEL_EINHEIT"
            aufrundung_ab_prozent :   If demand >= treshold               ==> round up
            abrundung_bis_prozent   : If demand < treshold                ==> round down			
            If demand is between threshold down/up  ==> Skip rounding, only rounding to Standard order unit_1 (no additonal Pal rounding!!!)',
   abrundung_bis_prozent               NUMBER(38,2)     COMMENT 'Percentage defined by user for rounding down to the amount defined in "RUNDUNG_ZIEL_EINHEIT"
            aufrundung_ab_prozent :   If demand >= treshold               ==> round up
            abrundung_bis_prozent   : If demand < treshold                ==> round down			
            If demand is between threshold down/up  ==> Skip rounding, only rounding to Standard order unit_1 (no additonal Pal rounding!!!)',
   rundung_ziel_einh_id                VARCHAR(3)       COMMENT 'Target-value for Rounding (PAL,HPL)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_RUNDUNGSPROFILE PRIMARY KEY (mandant_id, rundungsprofil_id) NOT ENFORCED
)  COMMENT = 'WBS_TP1: This table contains settings for WB''s calculation on article-store level,
             the quantity from "intermidiate order quantity" of TP1 need to be rounded based on the customizing If a rounding profile is assigned to article-store compinationl in the SAP table'' Mark''
             the content is maintained by transaction services document(excel file "Customizing_CW_0_1")
             the table is loaded manually for the first time and the users can add or maintain the entries.';
