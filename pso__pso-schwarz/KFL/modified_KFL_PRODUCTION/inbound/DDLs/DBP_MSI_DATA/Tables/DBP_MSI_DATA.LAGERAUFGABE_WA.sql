--==============================================================
-- Table: lageraufgabe_wa
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lageraufgabe_wa
   generated from Powerdesigner on Dienstag, 4. April 2023 14:21:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.LAGERAUFGABE_WA (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Lagernummer/Lagerkomplex',
   lageraufgabe_id                     INTEGER     NOT NULL COMMENT 'Lageraufgabe',
   handling_unit_id_nach               VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Nach-Handling-Unit',
   artikelsortiment_id                 VARCHAR(1)       COMMENT 'Kauflandspezifische Info Sortiments ID',
   handling_unit_id_ext                VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Externe Handling Unit Identifikation aus exidv. Nummer der Versandeinheit (NVE).',
   dat_lief_soll                       DATE             COMMENT 'Lieferdatum der Position.',
   lief_typ_id                         VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine Lieferung bearbeitet.',
   kunde_id                            INTEGER     COMMENT 'Die Kunde ID ist die wup_id des belieferten Marktes. Dazu gibt es auch eine mandant_id_kunde.',
   lief_pal_typ_id                     VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt, etc., handelt.',
   lief_pal_typ_dwh_id                 VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt),',
   werbeware_id                        VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Aus besch_lief: Wird gefüllt, wenn die Bestellart eine Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.',
   transportation_unit_id              INTEGER     COMMENT 'Transporteinheit (intern).',
   datzeit_start_max                   TIMESTAMP_NTZ(9) COMMENT 'Spätester Starttermin (SST)      ',
   datzeit_erstellung                  TIMESTAMP_NTZ(9) COMMENT 'Erstellungszeitpunkt',
   datzeit_start                       TIMESTAMP_NTZ(9) COMMENT 'Startzeitpunkt',
   datzeit_lezter_pick                 TIMESTAMP_NTZ(9) COMMENT 'zeitpunkt letzter pick',
   datzeit_quittierungs_bsf            TIMESTAMP_NTZ(9) COMMENT 'quittierungszeitpunkt bereitstellfläche',
   datzeit_verladung                 TIMESTAMP_NTZ(9) COMMENT 'zeitpunkt verladung',
   queue_id                            VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Queue',
   welle_id                            INTEGER     COMMENT 'Welle. Logical grouping of tasks (lageraufgabe) that are performed together (in one wave)',
   lagersortiment_id                   VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Lagersortiment ID.',
   lagerbereich_id_nach                VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Nachlagerbereich',
   lagertyp_id_nach                    VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Nach-Lagertyp',
   lagerplatz_id_nach                  VARCHAR(18)      NOT NULL COLLATE 'en-ci' COMMENT 'Nachlagerplatz',
   bsf_wechsel                         VARCHAR(1)       NOT NULL COMMENT 'flag: wechsel der bereitstellfläche',
   dat_aktion                          DATE             COMMENT 'Werbedatum.',
   datzeit_bereitstellung              TIMESTAMP_NTZ(9) COMMENT 'Bereitstelllzeitstempel',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LAGERAUFGABE_WA PRIMARY KEY (mandant_id, lagernummer_id, lageraufgabe_id, handling_unit_id_nach) NOT ENFORCED
)  COMMENT = 'Aggregated table that stores the result of joining LAGERAUFGABE , BESCH_LIEF_WA_DET, LAGERAUFTRAG, PROTOKOLL_VERLADUNG_EWM, BESCH_LIEF
             This table contains 1 rows per Warehouse (lagernummer_id), Warehouse Task (lageraufgabe_id), Handling Unit that is the destination of the task (handling_unit_id_nach) and Mandant';
