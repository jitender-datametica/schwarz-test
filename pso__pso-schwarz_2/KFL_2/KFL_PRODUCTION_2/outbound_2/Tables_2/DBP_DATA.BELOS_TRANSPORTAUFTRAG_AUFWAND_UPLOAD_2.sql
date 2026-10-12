--==============================================================
-- Table: belos_transportauftrag_aufwand_upload_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_transportauftrag_aufwand_upload_2
   generated from Powerdesigner on Friday, May 6, 2022 4:01:33 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_transportauftrag_aufwand_upload_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
belos_vorgang_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierte eindeutige ID für die Belos Vorgaenge. Ein Belos Vorgang setzt sich zusammen aus einem Transportauftrag_2 (Logistikdaten) und einer Sendung (Abrechnungsdaten).'),
transportauftrag_id STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Fachschluessel des referenzierten BELOS Transportauftrags der diesem Vorgang zugeodnet ist (nur eindeutige, keine Zusatztouren).'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
aufwand_vorlauf NUMERIC(11,3)
OPTIONS(description='Kosten fuer den Vorlauf vom Verteilzentrum, Warenanlieferung vom Spediteur fuer den spaeteren Hauptlauf.'),
aufwand_hauptlauf NUMERIC(11,3) OPTIONS(description='Kosten fuer den Hauptlauf. Der Haupttransportweg fuer die Ware.'),
aufwand_umschlag NUMERIC(11,3)
OPTIONS(description='Kosten fuer Nebenfahrten, z.B. wenn der Transporter Paletten fuer andere Auftraege mit transportiert und waehrend der Fahrt fuer diese einen Umweg vom Hauptlauf macht.'),
aufwand_diesel NUMERIC(11,3) OPTIONS(description='Kosten fuer Diesel zu dem Transportauftrag.'),
aufwand_gesamt NUMERIC(11,3) OPTIONS(description='Gesamtkosten fuer den Transportauftrag.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, belos_vorgang_id) NOT ENFORCED
)
OPTIONS(description='Kosten fuer BELOS Transportauftraege. Diese Tabelle wird ueber einen SharePoint-Upload versorgt. Die Daten kommen aus manuell befuellten Excel-Dateien die auf dem SharePoint liegen.');