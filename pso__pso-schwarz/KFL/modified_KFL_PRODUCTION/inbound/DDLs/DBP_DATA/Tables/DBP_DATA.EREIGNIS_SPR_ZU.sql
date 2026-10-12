--==============================================================
-- Table: ereignis_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignis_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EREIGNIS_SPR_ZU (
   ereignis_id                         INTEGER     NOT NULL COMMENT 'Ereignis ID (fortlaufende Nummer)',
   ereignistyp_id                      INTEGER     NOT NULL COMMENT 'Ereignistyp ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   ereignis_bez_lang                   VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Langbezeichnung eines Ereignisses, z.Bsp.
            Lang = Ostersonntag
            Mittel = Ostern
            Kurz = O',
   ereignis_bez_mittel                 VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Mittellangbezeichnung eines Ereignisses, z.Bsp.
            Lang = Ostersonntag
            Mittel = Ostern
            Kurz = O',
   ereignis_bez_kurz                   VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung eines Ereignisses, z.Bsp.
            Lang = Ostersonntag
            Mittel = Ostern
            Kurz = O',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EREIGNIS_SPR_ZU PRIMARY KEY (ereignis_id, ereignistyp_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Bezeichnung eines Ereignisses in den DWH-Sprachen';

