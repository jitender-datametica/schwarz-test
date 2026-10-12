--==============================================================
-- Table: pmr_werbethema
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pmr_werbethema
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:43:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PMR_WERBETHEMA (
   pmr_werbethema_id                   VARCHAR(6)      NOT NULL COMMENT 'Werbethema',
   pmr_werbethema_bez                  VARCHAR(50)     COMMENT 'Werbethemabezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'This table provides the name to the werbethema - means what is the topic of the promotion (Werbethema)
          Example: Asia-Week, 1€, Backside';
