--==============================================================
-- Table: l_bonuspunkte_grund_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_bonuspunkte_grund_2
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_BONUSPUNKTE_GRUND_2 (
   bonuspunkte_grund_cd                VARCHAR(100)     NOT NULL COMMENT 'Code des Grunds der Bonuspunktevergabe.',
   bonuspunkte_grund_bez               VARCHAR(200)     COMMENT 'Bezeichnung des Grunds der Bonuspunktevergabe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_BONUSPUNKTE_GRUND PRIMARY KEY (bonuspunkte_grund_cd) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für den Grund der Bonuspunktevergabe.Zb:checkout, cancellation, Registrierung von PDP.Unterschiedliche Werte die frei gewählt werden können. In Zukunft kontinuierlich wechselnde Werte. Keine fixen Wert.';
