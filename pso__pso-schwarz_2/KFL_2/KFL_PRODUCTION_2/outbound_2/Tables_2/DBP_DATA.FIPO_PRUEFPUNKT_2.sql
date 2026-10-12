--==============================================================
-- Table: fipo_pruefpunkt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_pruefpunkt_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_pruefpunkt_2 (
fipo_pruefpunkt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Prüfpunkts aus ppu_id'),
fipo_bereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id'),
fipo_kriterium_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='FIPO - Eindeutige ID eines FIPO Kriteriums aus der Quelltabelle kriterien'),
fipo_pruefpunkt_nr BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
fipo_kategorie_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID einer FIPO-Kategorie aus dem Quellfeld kat_id'),
fipo_pruefpunkt_typ STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Kriterientyp des Prüfpunkt (Handelt es sich um eine_2 Zählfrage, Textfrage, OK / NOTOK - Frage, etc.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_pruefpunkt_id) NOT ENFORCED
) OPTIONS(description='FIPO - Pruefpunkte aus der Quelltabelle pruefpunkte');