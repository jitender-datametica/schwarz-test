--==============================================================
-- Table: l_tms_transportmittel_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_transportmittel_2
   generated from Powerdesigner on Donnerstag, 24. April 2025 14:53:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_transportmittel_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_transportmittel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Transportmittels (KEY0 / Werte: 0-50)'),
tms_transportmittel_lfd_nr BIGNUMERIC(38,0) OPTIONS(description='ID des Transportmittels im Quellsystem.'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Artikel_2-ID  des Transportmittels einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
tms_transportmittel_name STRING(100) OPTIONS(description='Name des Transportmittels'),
tms_transportmittel_bez STRING(200) OPTIONS(description='Kurzbezeichnung des Transportmittels'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_transportmittel_id) NOT ENFORCED
) OPTIONS(description='TMS - Lookuptabelle für die Transportmittel');