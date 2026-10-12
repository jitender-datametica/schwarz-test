--==============================================================
-- Table: ereignis
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignis
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EREIGNIS (
   ereignis_id                         INTEGER     NOT NULL COMMENT 'Ereignis ID (fortlaufende Nummer)',
   ereignistyp_id                      INTEGER     NOT NULL COMMENT 'Ereignistyp ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   default_offen                       INTEGER     COMMENT 'gibt an, ob bei dem Ereignis der Markt normalerweise offen ist',
   sap_ereignis_id                     INTEGER     COMMENT 'Die durch das SAP-System gelieferte ID wird im DWH auf die DWH-interne ID umgesetzt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EREIGNIS PRIMARY KEY (ereignis_id, ereignistyp_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Bildet Ereignisse ab, die sich auf den Umsatz auswirken können, wie Feiertage';

