--==============================================================
-- Table: ods_bon_leergut_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_leergut_2
   generated from Powerdesigner on Dienstag, 2. August 2022 15:58:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_leergut_2 (
bon_id STRING(100) NOT NULL OPTIONS(description='eindeutige ID eines Bons, generierter Hashwert'),
bon_zeile BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Zeile des Bons'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land_2'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey'),
ean_kasse BIGNUMERIC(38,0) OPTIONS(description='Hier ist der Barcode des Leergutbons hinterlegt'),
umsatz_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Umsatz Brutto Betrag'),
start_bon_zeile DATETIME OPTIONS(description='Zeitstempel bei Beginn der Bewegung'),
bon_nr_extern BIGNUMERIC(38,0) OPTIONS(description='Bonnummer eines externen Systems, hier vom Tomra-Leergut-Automaten'),
kpos_erfassung_id STRING(40) OPTIONS(description='Erfassungsart: Manuell, Scan, etc.'),
menge BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Menge / Anzahl an Leergut'),
kl_art_id BIGNUMERIC(38,0) OPTIONS(description='Kaufland Artikelnummer'),
einh_id STRING(12) OPTIONS(description='Einheit: Stueck, Kiste, etc.'),
mwst_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'),
barcode_leergut STRING(100) OPTIONS(description='Barcode des Pfandzettels'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bon_id, bon_dat, mandant_id, wup_id, bon_zeile) NOT ENFORCED
) CLUSTER BY mandant_id, bon_dat, wup_id
OPTIONS(description='ODS -Leergutbons aus den Bonzeilen. Redundant gespeichert zur Steigerung der Performance. Alternativ wäre_2 CROSS JOIN Index denkbar');