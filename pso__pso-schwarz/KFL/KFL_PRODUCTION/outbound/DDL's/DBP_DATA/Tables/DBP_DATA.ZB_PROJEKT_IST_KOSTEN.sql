CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_ist_kosten (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
buchung_beleg_nr STRING(20) NOT NULL OPTIONS(description='Belegnummer der Buchung'),
buchung_beleg_pos_nr INTEGER NOT NULL OPTIONS(description='Nummer der Belegposition / Buchungszeile der Buchung'),
dat_buchung_beleg DATE NOT NULL OPTIONS(description='Datum der Buchung'),
buchung_typ_cd STRING(20) NOT NULL
OPTIONS(description='Code gibt an ob es sich um eine Buchung zu einer Bestellung (B), eine Buchung zum Vertrag (V) oder um eine Buchung ohne Bestellung und Vertrag (O) handelt.'),
kosten_typ_cd STRING(20) NOT NULL
OPTIONS(description='Code gibt Art der Kosten- / Buchungsposition an: B = Baukostenzuschuss, F = Foerderung, R = Rueckstellung, K = normale Kosten.'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER NOT NULL
OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
konto_nr STRING(20) NOT NULL OPTIONS(description='Nummer des Kontos'),
gegen_konto_nr STRING(20) NOT NULL OPTIONS(description='Nummer des Gegenkontos'),
gp_id INTEGER NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
material_nr INTEGER NOT NULL OPTIONS(description='Nummer des Materials.'),
bestell_beleg_nr INTEGER NOT NULL
OPTIONS(description='Handelt es sich um eine Buchung zu einer Bestellung, Belegnummer der Bestellung.'),
bestell_beleg_pos_nr INTEGER NOT NULL
OPTIONS(description='Handelt es sich um eine Buchung zu einer Bestellung, Nummer der Belegposition der Bestellung.'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'),
mietvertrag_nr STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Hanelt es sich um den Buchung Typ V und die Buchung kann einem Vertrag zugeordnet werden, befindet sich hier der eindeutige Identfier des zugeordneten Vertrages.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_buchung NUMERIC(29,5) NOT NULL OPTIONS(description='Betrag der Buchung in Landeswährung.'),
buchung_beleg_txt STRING(500) OPTIONS(description='Freitext des Buchungsbeleges.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, buchung_beleg_nr, buchung_beleg_pos_nr) NOT ENFORCED
)
OPTIONS(description='Enthält alle Buchungen die für Immobilienprojekte relevant sind. Diese können entweder aus einer Bestellungen, aus Verträgen und Konditionen oder ohne Bezug zu diesen und nur mit einem referenzierten Konto veranlasst werden.');