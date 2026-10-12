--==============================================================
-- Table: platzierungswg_flaeche_flachetyp_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: platzierungswg_flaeche_flachetyp_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 15:09:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.platzierungswg_flaeche_flachetyp_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
platzierungswg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.'),
ginfo_flaeche_id STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID einer Fläche. Z.Bsp. ABF-F6.14'),
ginfo_flaeche_typ_id STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ der Flaeche.'),
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit.'),
flaeche_quelle_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flaechendaten kommen aus drei Quellen. 1 = Grundstuecks-, 2 = Immobilien-, 3 = Handelsflaechen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, platzierungswg_id, flaeche_quelle_id) NOT ENFORCED
) OPTIONS(description='Zuordnung von Platzierungswarengruppen zu ginfo Fläche und ginfo Fläche Typ.');