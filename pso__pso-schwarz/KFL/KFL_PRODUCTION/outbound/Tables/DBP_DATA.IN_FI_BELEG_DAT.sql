--==============================================================
-- Table: in_fi_beleg_dat
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_fi_beleg_dat
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_fi_beleg_dat (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
buchungskreis_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
in_fi_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer eines Buchhaltungsbelegs. Aus SAP Industrie belnr'),
in_fi_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Belegposition eines Buchhaltungsbelegs. Aus SAP Industrie buzei'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
dat_buch DATE NOT NULL OPTIONS(description='Buchungsdatum der Rechnung.'),
dat_beleg DATE NOT NULL OPTIONS(description='Belegdatum der Rechnung.'),
dat_basis DATE NOT NULL OPTIONS(description='Basisdatum für Fälligkeitsberechnung'),
in_lief_id BIGNUMERIC(38,0) OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
sonder_hauptbuch_kz STRING(1) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen für die Zuordnung zu Sonderhauptbuch, z.Bsp. A = Auszahlung, P = Zahlungsaufforderung. Aus umskz'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, buchungskreis_id, in_fi_beleg_id, in_fi_beleg_pos_id, gj) NOT ENFORCED
) OPTIONS(description='IMMO - Buchhaltung: Sekundärindex für Kreditoren aus der SAP-Quelle bsik');