--==============================================================
-- Table: l_werbeflaechenthema_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeflaechenthema_2
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbeflaechenthema_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
werbemittelkanal_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbemittelkanals'),
werbemittel_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbemittels'),
werbeflaechenthema_cd STRING(50) NOT NULL OPTIONS(description='Code des Werbeflaechenthemas'),
werbeflaechenthema_bez STRING(200) OPTIONS(description='Bezeichnung des Werbeflaechenthemas'),
werbeflaechenthema_wfl_bez STRING(200)
OPTIONS(description='Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_2 Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird. '),
werbeflaechenthema_avq_prio_nr BIGNUMERIC(38,0)
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbemittelkanal_id, werbemittel_id, werbeflaechenthema_cd) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Werbeflächenthemen. Aus ZPMR_FKUERZEL (SAP P11). Enthält sowohl die Werbeflächenthemen-Bezeichnung aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen sowie Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).             Das Werbeflächenthema gibt an, in welchem Bereich das Angebot_2 abgebildet ist (z.B. PANO01 = auf der ersten Panoseite im Prospekt).');