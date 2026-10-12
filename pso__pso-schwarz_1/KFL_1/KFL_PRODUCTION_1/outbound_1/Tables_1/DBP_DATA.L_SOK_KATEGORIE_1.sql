--==============================================================
-- Table: l_sok_kategorie_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_sok_kategorie_1
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 11:49:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_sok_kategorie_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
sok_kategorie_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der SOK Kategorie. Fasst mehrere primäre_1 Platzierungswarengruppen zu einer übergeordneten Berichtshierarchie-Ebene zusammen.'),
sok_fima_baustein_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='"ID des SOK FIMA Baustein - im DWH generierter numerischer Schlüssel. Fasst mehrere SOK Kategorien zu einer übergeordneten Hierarchie-Ebene zusammen."'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, sok_kategorie_id) NOT ENFORCED
)
OPTIONS(description='Ebene der SOK Berichtsstruktur. Die SOK Kategorie fasst mehrere primäre_1 Platzierungswarengruppe zu einer übergeordneten Hierarchie-Ebene zusammen. Wird manuell in VIS SOK gepflegt.');