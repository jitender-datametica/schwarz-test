--==============================================================
-- Table: ecom_res
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ecom_res
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ecom_res (
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer im DWH'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_von DATE NOT NULL OPTIONS(description='Gültigkeitbeginn für diesen Datensatz.'),
dat_bis DATE NOT NULL
OPTIONS(description='Gültigkeitsende des Datensatzes. Wenn dieser Datensatz die momentan gültige Version darstellt besitzt dieses Attribut den Wert 31.12.9999.'),
aktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennung einer Aktion. Referenz zur Tabelle aktion (wakh.aktnr)'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat_von) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Die Tabelle enthält die reservierbaren Artikel für E-Commerce. Quelle ist zek_ecom_res');