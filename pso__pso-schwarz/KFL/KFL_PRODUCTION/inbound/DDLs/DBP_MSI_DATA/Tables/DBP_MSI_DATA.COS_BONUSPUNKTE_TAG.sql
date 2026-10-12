--==============================================================
-- Table: cos_bonuspunkte_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte_tag
   generated from Powerdesigner on Montag, 24. November 2025 17:42:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.COS_BONUSPUNKTE_TAG (
   crm_konto_id                        VARCHAR(144)     NOT NULL COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos.',
   dat                                 DATE             NOT NULL COMMENT 'Datum für Tagesstand der Bonuspunkte.',
   bonuspunkte_kanal_id                NUMBER(38,0)     NOT NULL COMMENT 'Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'KFL-Land des Kundenkontos, das an Loyalty-Programms teilnimmt.',
   anz_bonuspunkte                     NUMBER(38,0)     COMMENT 'Die tägliche gesamte anzahl an Bonuspunkten auf das Konto.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSPUNKTE_TAG PRIMARY KEY (crm_konto_id, dat, bonuspunkte_kanal_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält die täglichen Bonuspunkten eines Kunden.';
