--==============================================================
-- Table: werbeflaechenabschnitt_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbeflaechenabschnitt_spr_zu_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WERBEFLAECHENABSCHNITT_SPR_ZU_2 (
   werbeflaechenabschnitt_id           INTEGER     NOT NULL COMMENT 'ID des Werbeflächenabschnitts',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   werbeflaechenabschnitt_name         VARCHAR(100)     COMMENT 'Bezeichnung des Werbeflächenabschnitts',
   werbeflaechenabschnitt_wfl_bez      VARCHAR(200)     COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_2 Bezeichnung für bestimmt Werbeflächenabschnitt definieren kann, welche im Frontend angezeigt wird.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WERBEFLAECHENABSCHNITT_SPR_ZU PRIMARY KEY (werbeflaechenabschnitt_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachzuordnungstabelle für den Werbeflächenabschnitt. Aus ZPMR_WBM_ABSBEZ(SAP P11). Enthält sowohl die Werbeflächenabschnitts-Bezeichnungen aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen.
             Der Werbeflächenabschnitt gibt an, in welchem Abschnitt eines Bereichs das Angebot_2 abgebildet ist (z.B. TOPLEFT1 = oben links auf der Seite im Prospekt).';
