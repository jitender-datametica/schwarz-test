--==============================================================
-- Table: l_sok_fima_baustein_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_sok_fima_baustein_2
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 12:04:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_sok_fima_baustein_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
sok_fima_baustein_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des SOK FIMA Baustein - im DWH generierter numerischer Schlüssel. Fasst mehrere SOK Kategorien zu einer übergeordneten Hierarchie-Ebene zusammen.'),
sok_fima_baustein_nr STRING(10)
OPTIONS(description='Nummer des SOK FIMA Baustein - nicht-numerischer Schlüssel aus dem Quellsystem. Fasst mehrere SOK Kategorien zu einer übergeordneten Hierarchie-Ebene zusammen.'),
sok_abteilung_id BIGNUMERIC(38,0)
OPTIONS(description='ID der SOK Abteilung. Fasst die SOK Fima Bausteine zu einer übergeordneten Berichtshierarchie-Ebene zusammen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, sok_fima_baustein_id) NOT ENFORCED
)
OPTIONS(description='Ebene der SOK Berichtsstruktur. Der SOK FIMA (Filialmaßnahmen) Baustein fasst die SOK Kategorien zu den FIMA Bausteinen seitens Immo in einer übergeordneten Hierarchie Ebene zusammen. Wird manuell in VIS SOK gepflegt.');