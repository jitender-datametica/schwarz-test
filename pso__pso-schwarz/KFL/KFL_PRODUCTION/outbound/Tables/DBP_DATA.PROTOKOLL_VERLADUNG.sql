--==============================================================
-- Table: protokoll_verladung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: protokoll_verladung
   generated from Powerdesigner on Dienstag, 28. September 2021 14:58:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.protokoll_verladung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
tour_id INTEGER NOT NULL OPTIONS(description='Nummer des Transportes (Tour)'),
handling_unit_id_ext STRING(20) NOT NULL OPTIONS(description='Externe Handling Unit Identifikation'),
datzeit_scan TIMESTAMP NOT NULL
OPTIONS(description='UTC-Zeitstempel in Langform (JJJJMMTThhmmssmmmuuun)'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
lagernummer_id STRING(4) OPTIONS(description='Lagernummer/Lagerkomplex'),
kunde_id STRING(10) OPTIONS(description='Warenempfänger'),
dat_scan DATE OPTIONS(description='Datum'),
zeit_scan TIMESTAMP OPTIONS(description='Tageszeit'),
versandeinheit_id STRING(20)
OPTIONS(description='Träger-Nummer-Versand-Einheit (bei Sammelpalette). Enthält 18-stelligen Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette'),
lief_beleg_id INTEGER OPTIONS(description='Vertriebsbelegnummer'),
dat_lief_soll DATE OPTIONS(description='Lieferdatum'),
arbeitsgebiet_id STRING(20) OPTIONS(description='Arbeitsgebiet'),
pruef_id STRING(3) OPTIONS(description='Arbeitsgebiet. Prüfungsgrund ID'),
gesamtgewicht_hu NUMERIC(15,3) OPTIONS(description='Gesamtgewicht der Handling Unit'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='\'Protokolltabelle Verladung');