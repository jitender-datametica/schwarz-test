--==============================================================
-- Table: flw_art_wup_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_wup_status_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_wup_status_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
dme_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Doppelte Mengeneinheit aus spmeat/dmein'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
beschaffungsart_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Beschaffungsart aus BESKZ'),
zerlege_gruppe_id BIGNUMERIC(38,0) OPTIONS(description='Zerlegegruppe aus zgrup.'),
mat_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die Materialgruppe kann Fleisch, Wurst, Hawa oder Produktion sein. Wird aus Produkthierarchiestufe, Ausprägung der Stufe und der Beschaffungsart gebildet'),
loesch_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='MMSTA - Löschkennzeichen: Betriebsspezifischer Artikelstatus. Die möglichen Stati sind in artkz_loesch_2 hinterlegt. aus lvorm'),
dat_von_loesch_id DATE
OPTIONS(description='MMSTD - Datum, ab dem der btrbsspezifische Artikelstatus (DWH: loesch_id) gültig ist'),
indentifikation_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Identifikation: Steuerung zur Prüfung der EXTNR'),
herkunftsnachweis_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Herkunftsnachweis (1=vorhanden)'),
hackfleischpruef_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Flag Hackfleischprüfung (1=erfolgt)'),
herkunft_id BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='ID der Herkunft'),
tiergattung_id BIGNUMERIC(38,0) OPTIONS(description='Eindeutige ID der Tiergattung, z.Bsp 1 = Schwein aus tgtky'),
tierkategorie_id BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='ID der Tierkategorie (Bsp. 1=Jungbulle;2=Rind)'),
toleranz_ueber_prozent NUMERIC(9,2)
OPTIONS(description='Toleranzprüfung WE-Menge Über Fert.auftragsmenge in Prozent aus SAP Quelle MARC./SPDGS/UETEH'),
toleranz_unter_prozent NUMERIC(9,2)
OPTIONS(description='Toleranzprüfung WE-Menge Unter Fert.auftragsmenge in Prozent aus SAP Quelle MARC./SPDGS/UNTEH'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, werk_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Artikel_2 - Werksbezogene Attribute aus marc_2');