--==============================================================
-- Table: rohstoff_preisentwicklung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_preisentwicklung_2
   generated from Powerdesigner on Mittwoch, 6. August 2025 15:18:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ROHSTOFF_PREISENTWICKLUNG_2 (
   rohstoff_nr                         VARCHAR(20)      NOT NULL COMMENT 'Mintecs Interne ID des Rohstoffs.',
   dat_rohstoff_preis                  DATE             NOT NULL COMMENT 'Datum des Preises des Rohstoffs.',
   rohstoff_einh_name                  VARCHAR(100)     NOT NULL COMMENT 'Einheit des Rohstoffs. Für einen Rohstoff_2 gibt es verschiedene Einheiten in dem sie dargstellt werden können z.B. LITER - KG - TONNE etc. Nicht zur verwechseln mit der basis_einheit_name.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   frequenz_cd                         VARCHAR(20)      NOT NULL COMMENT 'Sie gibt die native Preisfrequenz des Rohstoffs an, d.h. welcher Preis hat sie zu diesem Tag. Hier steht "Weekly", "Daily", ''Yearly'' etc.)',
   kjwo                                INTEGER     NOT NULL COMMENT 'Kalenderjahreswoche (Format JJJJWW) des Preis des Rohstoffs. Derzeit ein Preis pro Woche. ( Stand 17.03.2025).',
   preis_rohstoff_max                  NUMBER(38,10)    NOT NULL COMMENT 'Maximal Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.',
   preis_rohstoff_min                  NUMBER(38,10)    NOT NULL COMMENT 'Minnimal Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.',
   preis_rohstoff_avg                  NUMBER(38,10)    NOT NULL COMMENT 'Durchschnittspreis zwischen den maximalen und minimalen Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.',
   preis_gefuellt_fg                   INTEGER     DEFAULT 0 COMMENT 'Falls es für einen DAT keinen Preis gibt, wird es für den DAT in der Extraktion ein GapFillValue hinzugefügt mit dem Wert -9999. Bei einen Wert von -9999 wird preis_gefuellt_fg auf 1 gesetzt. Bei nachträglicher Preislieferung wird der Wert dann auf 0 gesetzt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ROHSTOFF_PREISENTWICKLUNG PRIMARY KEY (rohstoff_nr, dat_rohstoff_preis, wrg_id, rohstoff_einh_name) NOT ENFORCED
)  COMMENT = 'Preisentwicklung des Rohstoffspreises.';
