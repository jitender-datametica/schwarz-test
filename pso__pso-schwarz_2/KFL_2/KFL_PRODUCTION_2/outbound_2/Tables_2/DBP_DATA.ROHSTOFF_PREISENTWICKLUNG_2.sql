--==============================================================
-- Table: rohstoff_preisentwicklung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_preisentwicklung_2
   generated from Powerdesigner on Mittwoch, 6. August 2025 15:18:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rohstoff_preisentwicklung_2 (
rohstoff_nr STRING(20) NOT NULL OPTIONS(description='Mintecs Interne ID des Rohstoffs.'),
dat_rohstoff_preis DATE NOT NULL OPTIONS(description='Datum des Preises des Rohstoffs.'),
rohstoff_einh_name STRING(100) NOT NULL
OPTIONS(description='Einheit des Rohstoffs. Für einen Rohstoff_2 gibt es verschiedene Einheiten in dem sie dargstellt werden können z.B. LITER - KG - TONNE etc. Nicht zur verwechseln mit der basis_einheit_name.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
frequenz_cd STRING(20) NOT NULL
OPTIONS(description='Sie gibt die native Preisfrequenz des Rohstoffs an, d.h. welcher Preis hat sie zu diesem Tag. Hier steht "Weekly", "Daily",\'Yearly\' etc.)'),
kjwo BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kalenderjahreswoche (Format JJJJWW) des Preis des Rohstoffs. Derzeit ein Preis pro Woche. ( Stand 17.03.2025).'),
preis_rohstoff_max BIGNUMERIC(38,10) NOT NULL
OPTIONS(description='Maximal Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'),
preis_rohstoff_min BIGNUMERIC(38,10) NOT NULL
OPTIONS(description='Minnimal Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'),
preis_rohstoff_avg BIGNUMERIC(38,10) NOT NULL
OPTIONS(description='Durchschnittspreis zwischen den maximalen und minimalen Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'),
preis_gefuellt_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Falls es für einen DAT keinen Preis gibt, wird es für den DAT in der Extraktion ein GapFillValue hinzugefügt mit dem Wert -9999. Bei einen Wert von -9999 wird preis_gefuellt_fg auf 1 gesetzt. Bei nachträglicher Preislieferung wird der Wert dann auf 0 gesetzt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_nr, dat_rohstoff_preis, wrg_id, rohstoff_einh_name) NOT ENFORCED
) OPTIONS(description='Preisentwicklung des Rohstoffspreises.');