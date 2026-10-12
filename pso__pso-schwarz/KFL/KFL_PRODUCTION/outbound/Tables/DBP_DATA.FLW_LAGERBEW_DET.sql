--==============================================================
-- Table: flw_lagerbew_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lagerbew_det
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lagerbew_det (
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
lagerbew_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung.'),
lagerbew_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthält die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Quelle zeile'),
kj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
auto_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen für eine automatisch erzeugte Position aus SAP xauto'),
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
charge_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Charge aus charg'),
soll_haben_kz STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Soll-Haben-Kennzeichen aus SAP shkzg'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
betrag_lagerbew NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Betrag der Belegposition in der Hauswährung des Buchungskreises. Entspricht dem eknetto_bnk aus SAP mseg.dmbtr. Gilt für V-Preis gesteuertes Material'),
betrag_lagerbew_altnv NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Buchungsbetrag in alternativer Preissteuerung aus bualt. Gilt für S-Preis gesteuertes Material. Liefert für Standardpreisartikel die GLD-Bewertung'),
menge_lagerbew_bme NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge in Basismengeneinheit aus menge'),
menge_bstmg NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge in Bestellmengeneinheit aus bstmg'),
best_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bestellmengeneinheit aus SAP.bstme. Referenziert auf die Tabelle einh'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
empfaenger_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
best_beleg_id INTEGER NOT NULL OPTIONS(description='Bestellbeleg aus ebeln'),
best_beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Belegposition des Einkaufsbelegs aus ebelp'),
menge_erf NUMERIC(18,3) NOT NULL OPTIONS(description='Menge in der Erfassungsmengeneinheit aus erfmg'),
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lager Bewegungsart aus bwart'),
auftrag_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Auftragsnummer aus aufnr. Compress -1'),
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kostenstelle aus kostl'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Schlüssel für die Lagerorte'),
menge_bestellpreis NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge in Bestellpreismengeneinheit aus bprmg'),
bestellpreis_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Gibt die Maßeinheit an, auf die sich der Bestellpreis bezieht. aus bprme'),
erfsngs_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der alternativen Mengeneinheit aus meinh'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj) NOT ENFORCED
) CLUSTER BY kj
OPTIONS(description='FLW - Lagerbewegungen Positionen aus Quelle SAP mseg');