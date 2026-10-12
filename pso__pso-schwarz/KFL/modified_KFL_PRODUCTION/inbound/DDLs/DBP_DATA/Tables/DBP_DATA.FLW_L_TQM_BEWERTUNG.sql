--==============================================================
-- Table: flw_l_tqm_bewertung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_tqm_bewertung
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_TQM_BEWERTUNG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   fehler_prozent_bis                  NUMBER(29,2)      NOT NULL COMMENT 'oberer Wert des Prozentbereichs',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   fehler_prozent_von                  NUMBER(29,2)      NOT NULL COMMENT 'unterer Wert des Prozentbereichs',
   punkte_sap_kf                       INTEGER     NOT NULL COMMENT 'Anzahl Punkte für kritische Fehler',
   punkte_sap_vk                       INTEGER     NOT NULL COMMENT 'Anzahl Punkte für VK-Fehler',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_TQM_BEWERTUNG PRIMARY KEY (mandant_id, fehler_prozent_bis) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle zur Umrechnung von Fehlerprozentwerten in Fehlerpunkte';

