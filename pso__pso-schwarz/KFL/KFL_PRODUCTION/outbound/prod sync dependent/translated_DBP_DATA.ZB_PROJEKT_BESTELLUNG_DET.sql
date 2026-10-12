CREATE OR REPLACE TABLE kfl_production_dbp_data.zb_projekt_bestellung_det (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
bestell_beleg_nr INTEGER NOT NULL OPTIONS(description='Belegnummer der Bestellung.'),
bestell_beleg_pos_nr INTEGER NOT NULL OPTIONS(description='Nummer der Belegposition der Bestellung.'),
projekt_nr STRING(100) NOT NULL OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id INTEGER OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'),
bestell_beleg_pos_typ_cd STRING(20)
OPTIONS(description='Code der angibt, um welchen Positionstyp der Bestellung es sich handelt, bspw. N = Nachtrag.'),
dat_erstellung DATE OPTIONS(description='Erstelldatum der Belegposition.'),
material_nr INTEGER OPTIONS(description='Nummer des bestellten Materials.'),
warengruppe_cd STRING(20) NOT NULL OPTIONS(description='Code der Warengruppe'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR für betrag_netto'),
betrag_netto NUMERIC(29,5) NOT NULL OPTIONS(description='Nettobetrag der Bestellposition in Landeswährung'),
betrag_netto_konz NUMERIC(29,5) OPTIONS(description='Nettobetrag der Bestellposition in Konzernwährung (EUR)'),
rate_tageskurs NUMERIC(29,5)
OPTIONS(description='Rate für die Umrechnung der lokalen Währung zur Konzernwährung mit dem Tageskurs.'),
bestell_pos_txt STRING(500) OPTIONS(description='Freitext für die Belegposition.'),
endrechnung_fg INTEGER NOT NULL OPTIONS(description='Flag gibt an, ob ...............'),
loesch_fg INTEGER NOT NULL
OPTIONS(description='Flag gibt an, ob Belegposition gelöscht wurde und für das Reporting nicht relevant ist.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bestell_beleg_nr, bestell_beleg_pos_nr) NOT ENFORCED
) OPTIONS(description='Enthält die Bestellpositionen der getätigten Bestellung für Projekte aus den Zentralbereichen.');