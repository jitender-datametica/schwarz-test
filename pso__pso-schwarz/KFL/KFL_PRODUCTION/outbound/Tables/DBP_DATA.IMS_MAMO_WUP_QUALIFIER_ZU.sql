--==============================================================
-- Table: ims_mamo_wup_qualifier_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_mamo_wup_qualifier_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_mamo_wup_qualifier_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
qualifier_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines Qualifiers (Surrogate Key DWH - Basis Qualifier Bezeichnung (Upload Fachbereich))'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, qualifier_id) NOT ENFORCED
)
OPTIONS(description='IMS - Mapping einer Fokusfiliale (WUP) zu einem Qualifier (Zuweisung von Referenzmärkten) - manueller Upload via Sharepoint');