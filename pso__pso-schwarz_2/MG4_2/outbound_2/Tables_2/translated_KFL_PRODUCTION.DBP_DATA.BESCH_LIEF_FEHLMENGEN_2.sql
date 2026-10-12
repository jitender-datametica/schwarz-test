DROP TABLE IF EXISTS kfl_production_dbp_data.besch_lief_fehlmengen_2;
CREATE OR REPLACE TABLE kfl_production_dbp_data.besch_lief_fehlmengen_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_id INTEGER NOT NULL OPTIONS(description='Artikel_2 aus BESCH_LIEF_DET_2 oder angereichert aus BESCH_BEST_DET_2(EKKO_2)'),
wup_id INTEGER NOT NULL OPTIONS(description='Verteilzentrum aus BESCH_LIEF_2 bzw. BESCH_BEST_2'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
empfaenger_wup_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Empfangende Filiale aus BESCH_LIEF_2 bzw. BESCH_BEST_2'),
empfaenger_nb_id INTEGER NOT NULL
OPTIONS(description='Nebenbetriebs-ID des empfangenden Marktes. In der Tabelle nur deswegen enthalten, weil FrontEnd ein bestehendes Attribut aus mandant_2, wup_2, nb_2 verwendet'),
mandant_id_empfaenger INTEGER NOT NULL
OPTIONS(description='Der Empfaenger kann zu einem anderen Mandanten als der liefernde WUP_2 gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagerort_id'),
dat_lief_soll DATE NOT NULL OPTIONS(description='Soll Lieferdatum'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Angereichert aus BESCH_BEST_2(EKKO_2)'),
diff_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Wenn Eintrag in BESCH_LIEF_DET_2 vorhanden dann diff_id aus BESCH_LIEF_DET_2 ansonsten leer'),
kuerzung_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Wenn entsprechenden Eintrag in besch_lief_kuerzung_2 vorhanden dann 1 ansonsten 0'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
menge_lief_soll_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='bestellte Menge in Kolli umgerechnet'),
menge_lief_ist_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='tatsächlich gelieferte Menge in Kolli'),
ek_netto_bnk_soll NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die bestellte Menge.'),
ek_netto_bnk_ist NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gelieferte Menge.'),
vk_netto_ist NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die gelieferte Menge'),
vk_netto_soll NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die bestellte Menge'),
umrechnungskurs NUMERIC(29,5) NOT NULL
OPTIONS(description='Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs_2 angereichert'),
umrechnungskurs_hist NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '),
kuerz_menge_lief_soll_kolli NUMERIC(18,3) NOT NULL OPTIONS(description='Gekürzte Soll-Liefermenge in Kolli'),
kuerz_menge_lief_ist_kolli NUMERIC(18,3) NOT NULL OPTIONS(description='Gekürzte Ist-Liefermenge in Kolli'),
kuerz_ek_netto_bnk_soll NUMERIC(18,4) NOT NULL
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Soll-Menge'),
kuerz_ek_netto_bnk_ist NUMERIC(18,4) NOT NULL
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Ist-Menge'),
kuerz_vk_netto_soll NUMERIC(18,4) NOT NULL
OPTIONS(description='Verkaufspreis netto_bnk bezogen auf die gekürzte Soll-Menge'),
kuerz_vk_netto_ist NUMERIC(18,4) NOT NULL OPTIONS(description='Verkaufspreis  bezogen auf die gekürzte Ist-Menge'),
best_beleg_id INTEGER
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln'),
best_beleg_pos_id INTEGER
OPTIONS(description='Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung.Aus ebelp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, empfaenger_wup_id, empfaenger_nb_id, mandant_id_empfaenger,
 dat_lief_soll, kuerzung_fg) NOT ENFORCED
) CLUSTER BY mandant_id, dat_lief_soll
OPTIONS(description='AIS KMO - Aggregat für nicht gelieferte Ware in KMO. Wird aus besch_lief_det_2 und besch_lief_kuerzung_2 versorgt und mit Preisen angereichert ');