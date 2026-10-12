--==============================================================
-- Table: charge_ist_qa_check_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: charge_ist_qa_check_det
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:47:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.charge_ist_qa_check_det (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
seq_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer, wird bei mehreren Meldungen zur selben Charge in SAP einfach hochgezählt'),
charge_nr_qa STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Chargennummer, die bei einer QS-Meldung erzeugt wird  / QA steht für O&G, PF für Pflanzen, FL für Fleischwerk -> aber nicht zwingend - Feld CHARG_QA'),
qa_mangel_id STRING(3) OPTIONS(description='QA-Mangel (z. B. 001 = Frischemangel)'),
qa_deklarationsfehler_id STRING(3) OPTIONS(description='QA-Deklarationsfehler (, z. B. 002 = Etikett fehlt)'),
kommentar_qa_txt STRING(500) OPTIONS(description='User-Kommentar QA'),
kommentar_ek_txt STRING(500) OPTIONS(description='User-Kommentar Einkauf'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, seq_nr) NOT ENFORCED
)
OPTIONS(description='Detailinformationen zu QA-Prüfungen Obst & Gemüse -  fasst Meldungen zu Qualitäts- und Deklarationsmängeln + Kommentare seitens QA und Einkauf zusammen');