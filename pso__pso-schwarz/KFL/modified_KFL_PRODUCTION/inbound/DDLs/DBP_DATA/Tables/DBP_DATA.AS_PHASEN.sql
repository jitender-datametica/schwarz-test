--==============================================================
-- Table: as_phasen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: as_phasen
   generated from Powerdesigner on Mittwoch, 21. Juli 2021 12:08:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AS_PHASEN (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   wg_id                               INTEGER    NOT NULL COMMENT 'ID der Warengruppe',
   posten_kz_sap                       VARCHAR(2)      NOT NULL COMMENT 'Postenkennzeichen. Für Artikel, die nicht ständig im Sortiment sind (Unterschied zur posten_id: für KMO werden die tatsächlichen Werte aus SAP gespeichert)',
   wtag_phasenbeginn                   INTEGER    NOT NULL COMMENT 'Wochentag Phasenbeginn aus dem Quellfeld WEEKDAY (Montag = 1)'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'AIS - Länderspezifische Einstellungen für Artikelauslistung - SAP RET - ZRS_RVCUST';
