--==============================================================
-- Table: as_phasen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: as_phasen
   generated from Powerdesigner on Mittwoch, 21. Juli 2021 12:08:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.as_phasen (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
posten_kz_sap STRING(2) NOT NULL
OPTIONS(description='Postenkennzeichen. Für Artikel, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert)'),
wtag_phasenbeginn BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Wochentag Phasenbeginn aus dem Quellfeld WEEKDAY (Montag = 1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='AIS - Länderspezifische Einstellungen für Artikelauslistung - SAP RET - ZRS_RVCUST');