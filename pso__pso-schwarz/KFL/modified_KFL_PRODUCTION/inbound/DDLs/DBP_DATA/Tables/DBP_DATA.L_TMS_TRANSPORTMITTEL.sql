--==============================================================
-- Table: l_tms_transportmittel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_transportmittel
   generated from Powerdesigner on Donnerstag, 24. April 2025 14:53:49
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_TMS_TRANSPORTMITTEL (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_transportmittel_id              INTEGER     NOT NULL COMMENT 'ID des Transportmittels (KEY0 / Werte: 0-50)',
   tms_transportmittel_lfd_nr          INTEGER     COMMENT 'ID des Transportmittels im Quellsystem.',
   art_id                              INTEGER     COMMENT 'Artikel-ID  des Transportmittels einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   tms_transportmittel_name            VARCHAR(100)     COMMENT 'Name des Transportmittels',
   tms_transportmittel_bez             VARCHAR(200)     COMMENT 'Kurzbezeichnung des Transportmittels',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_TMS_TRANSPORTMITTEL PRIMARY KEY (mandant_id, system_id, tms_transportmittel_id) NOT ENFORCED
)  COMMENT = 'TMS - Lookuptabelle für die Transportmittel';
