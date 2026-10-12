--==============================================================
-- Table: l_bonuspunkte_kanal_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_bonuspunkte_kanal_1
   generated from Powerdesigner on Montag, 24. November 2025 08:30:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_BONUSPUNKTE_KANAL_1 (
   bonuspunkte_kanal_id                NUMBER(38,0)     NOT NULL COMMENT 'ID der Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.',
   bonuspunkte_kanal_bez               VARCHAR(200)     COMMENT 'Bezeichnung der Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_BONUSPUNKTE_KANAL PRIMARY KEY (bonuspunkte_kanal_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Plattform wo die Bonuspunkte erworben oder ausgegeben wurden.ZB: Markplatz, Filiale.';
