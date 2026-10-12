CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_obligo_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
bestell_beleg_nr INTEGER NOT NULL OPTIONS(description='Belegnummer der Bestellung auf die sich das Obligo bezieht.'),
bestell_beleg_pos_nr INTEGER NOT NULL
OPTIONS(description='Belegposition der Bestellung auf die sich das Obligo bezieht.'),
dat_beleg DATE NOT NULL OPTIONS(description='Datum des Beleges für das Obligo.'),
krk_id STRING(4) NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
kostenart_id STRING(10) NOT NULL OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_obligo NUMERIC(29,5) NOT NULL OPTIONS(description='Betrag des Obligo. Noch ausstehender Betrag zur Zahlung.'),
loesch_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob Eintrag im Quellsystem wieder gelöscht wurde und nicht für das Reporting relevant ist.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bestell_beleg_nr, bestell_beleg_pos_nr, dat_beleg) NOT ENFORCED
)
OPTIONS(description='Enthält das Obligo für die Bestellpositionen einer Bestellung. Unter Obligo versteht man die noch offenen Verbindlichkeiten.');