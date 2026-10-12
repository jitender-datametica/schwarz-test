--==============================================================
-- Table: in_l_wg
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_wg
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_WG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   in_wg_id                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Warengruppe aus dem Industriesystem. Quelle ist matkl',
   in_wg_struktur_id                   VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID der Warengruppenstruktur.Aus dem SAP-Klassensystem',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_WG PRIMARY KEY (mandant_id, in_wg_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle der Industriesystem-Warengruppen aus t023t';
