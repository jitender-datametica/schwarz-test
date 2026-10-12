--==============================================================
-- Table: l_werbemittel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbemittel
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_WERBEMITTEL (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   werbemittelkanal_id                 VARCHAR(4)       NOT NULL DEFAULT '-1' COMMENT 'Werbemittel Art ID - medium through which the advertisement is shown (paper, digital)',
   werbemittel_id                      VARCHAR(2)       NOT NULL COMMENT 'Werbemittel - on what item the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)',
   werbemittel_avq_prio_nr             NUMBER(38,0)     COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbemittel bei der Berechnung der Abverkaufsquote (AVQ). Werbemittel mit der gleichen ID werden zusammengefasst.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_WERBEMITTEL PRIMARY KEY (mandant_id, werbemittelkanal_id, werbemittel_id) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Werbemittel, in denen die Werbung geschaltet wird (z.B. Online, Prospekt,...). Aus SAP P11. Die Tabelle enthält zudem Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).';
