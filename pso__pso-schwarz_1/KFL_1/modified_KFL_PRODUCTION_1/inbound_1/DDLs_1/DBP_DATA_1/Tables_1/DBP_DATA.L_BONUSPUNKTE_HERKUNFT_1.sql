--==============================================================
-- Table: l_bonuspunkte_herkunft_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_bonuspunkte_herkunft_1
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_BONUSPUNKTE_HERKUNFT_1 (
   bonuspunkte_herkunft_id             INTEGER     NOT NULL COMMENT 'Code für die Herkunft der Punkte.',
   bonuspunkte_herkunft_bez            VARCHAR(200)     COMMENT 'Bezeichnung für die Herkunft der Punkte.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_BONUSPUNKTE_HERKUNFT PRIMARY KEY (bonuspunkte_herkunft_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Herkunft der Bonuspunkte-Wie sie vergeben wurden.ZB:Transaktion, manuelle Eingabe, Daily Suprises usw..';
