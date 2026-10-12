--==============================================================
-- Table: l_werbeflaechenthema_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeflaechenthema_1
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_WERBEFLAECHENTHEMA_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   werbemittelkanal_id                 INTEGER     NOT NULL COMMENT 'ID des Werbemittelkanals',
   werbemittel_id                      INTEGER     NOT NULL COMMENT 'ID des Werbemittels',
   werbeflaechenthema_cd               VARCHAR(50)      NOT NULL COMMENT 'Code des Werbeflaechenthemas',
   werbeflaechenthema_bez              VARCHAR(200)     COMMENT 'Bezeichnung des Werbeflaechenthemas',
   werbeflaechenthema_wfl_bez          VARCHAR(200)     COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_1 Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird. ',
   werbeflaechenthema_avq_prio_nr      INTEGER     COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_WERBEFLAECHENTHEMA PRIMARY KEY (mandant_id, werbemittelkanal_id, werbemittel_id, werbeflaechenthema_cd) NOT ENFORCED
)  COMMENT = 'Lookup-Tabelle für die Werbeflächenthemen. Aus ZPMR_FKUERZEL (SAP P11). Enthält sowohl die Werbeflächenthemen-Bezeichnung aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen sowie Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).
             Das Werbeflächenthema gibt an, in welchem Bereich das Angebot_1 abgebildet ist (z.B. PANO01 = auf der ersten Panoseite im Prospekt).';
