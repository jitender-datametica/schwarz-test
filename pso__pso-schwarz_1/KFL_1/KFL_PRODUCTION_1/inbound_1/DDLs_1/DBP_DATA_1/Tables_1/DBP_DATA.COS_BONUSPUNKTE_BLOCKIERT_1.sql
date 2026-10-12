--==============================================================
-- Table: cos_bonuspunkte_blockiert_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuspunkte_blockiert_1
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COS_BONUSPUNKTE_BLOCKIERT_1 (
   crm_konto_id                        VARCHAR(144)     NOT NULL COMMENT 'CRM-interne ID des Loyaltyaccounts/Bonuskontos.',
   dat_bonuspunkte_blockiert_bis       DATE             NOT NULL COMMENT 'Datum bis wann die Bonuspunkte blockiert sind. Bonuspunkte werden nicht direkt auf Konto_1 gutgeschrieben, sondern z.B. nach Ablauf der Rückgabefrist.',
   dat_verfall_bonuspunkte_blockiert   DATE             NOT NULL COMMENT 'Datum, an dem die gesammelten Bonuspunkte verfallen werden.',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'KFL-Land_1 des Kundenkontos, das an Loyalty-Programms teilnimmt.',
   anz_bonuspunkte_blockiert           NUMBER(38,0)     COMMENT 'Die gesamte anzahl der blockierten Bonuspunkten auf das Konto.',
   datzeit_update                      TIMESTAMP_LTZ(9) COMMENT 'Timestamp of when the record was last updated in the source system. It is used to monitor the correctness of the loading process by comparing what is in the DWH and in the source.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COS_BONUSPUNKTE_BLOCKIERT PRIMARY KEY (crm_konto_id, dat_bonuspunkte_blockiert_bis) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält, die erworbenen Bonuspunkte bei Kunden, die bis zu einem Datum blockiert sind und später gutgeschrieben werden.,z.B. nach Ablauf der Rückgabefrist.';
