--==============================================================
-- Table: besch_lief_fehlmengen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_fehlmengen
   generated from Powerdesigner on Freitag, 28. März 2025 10:36:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_fehlmengen (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel aus BESCH_LIEF_DET oder angereichert aus BESCH_BEST_DET(EKKO)'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Verteilzentrum aus BESCH_LIEF bzw. BESCH_BEST'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
empfaenger_wup_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Empfangende Filiale aus BESCH_LIEF bzw. BESCH_BEST'),
empfaenger_nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nebenbetriebs-ID des empfangenden Marktes. In der Tabelle nur deswegen enthalten, weil FrontEnd ein bestehendes Attribut aus mandant, wup, nb verwendet'),
mandant_id_empfaenger BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Empfaenger kann zu einem anderen Mandanten als der liefernde WUP gehoeren, z.Bsp. Lager aus CZ beliefert Markt in SK'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagerort_id'),
dat_lief_soll DATE NOT NULL OPTIONS(description='Soll Lieferdatum'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Angereichert aus BESCH_BEST(EKKO)'),
diff_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Wenn Eintrag in BESCH_LIEF_DET vorhanden dann diff_id aus BESCH_LIEF_DET ansonsten leer'),
kuerzung_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Wenn entsprechenden Eintrag in besch_lief_kuerzung vorhanden dann 1 ansonsten 0'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
menge_lief_soll_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='bestellte Menge in Kolli umgerechnet'),
menge_lief_ist_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='tatsächlich gelieferte Menge in Kolli'),
ek_netto_bnk_soll NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die bestellte Menge.'),
ek_netto_bnk_ist NUMERIC(18,4) OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gelieferte Menge.'),
vk_netto_ist NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die gelieferte Menge'),
vk_netto_soll NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die bestellte Menge'),
umrechnungskurs BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs angereichert'),
umrechnungskurs_hist BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs '),
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
best_beleg_pos_id BIGNUMERIC(38,0)
OPTIONS(description='Die Belegposition ID der Bestellung dient der eindeutigen Identifikation der Bestellpositionen pro Bestellung.Aus ebelp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, empfaenger_wup_id, empfaenger_nb_id, mandant_id_empfaenger,
 dat_lief_soll, kuerzung_fg) NOT ENFORCED
) CLUSTER BY mandant_id, dat_lief_soll
OPTIONS(description='AIS KMO - Aggregat für nicht gelieferte Ware in KMO. Wird aus besch_lief_det und besch_lief_kuerzung versorgt und mit Preisen angereichert ');