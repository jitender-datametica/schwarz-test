--==============================================================
-- Table: art_gp_wup_dts_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_wup_dts_zu_per_2
   generated from Powerdesigner on Montag, 16. Januar 2023 16:15:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_gp_wup_dts_zu_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filialnummer und werksbezogene Kundennummer.'),
nb_id BIGNUMERIC(38,0) OPTIONS(description='Nebenbetriebskennziffer.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter). Regel: Neuer Artikel_2 -> Counter +1.'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner-ID (GP_2) / Lieferanten-ID.'),
loesch_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag: Löschkennzeichen. Gibt an, ob dieser Eintrag in SAP zum Löschen markiert wurde.'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von.'),
dat_bis DATE OPTIONS(description='Gültig bis.'),
verkaufsorganisation_id STRING(4) NOT NULL
OPTIONS(description='Organisatorische Einheit, die für den Vertrieb bestimmter Produkte oder Dienstleistungen verantwortlich ist, z.B. KL = Kaufland.'),
vw_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Vertriebswegs. Einkaufs-Sicht auf die wup_2 Objekte. 1 = Ost, 2 = West, 3 = Nord.'),
auslieferungsgruppe_id STRING(4)
OPTIONS(description='ID der Auslieferungsgruppe. Eine_2 Auslieferungsgruppe (manchmal auch Ausliefergruppe) ist eine_2 Bündelung von Artikeln mit gleichen Eigenschaften Aufgrund welchen sie zusammen ausgeliefert werden können, VZ in Richtung Filiale. Z.B.: Food Trocken (Mehl, Konserven, Nudeln), Tiefkühlware (Fisch, Pizza, Eis, Tiefkühlgemuese), etc.'),
dispoteilsortiment_id STRING(9)
OPTIONS(description='Beschaffungsinformationen Dispoteilsortiment (DTS) - SAP Tabelle ZE1WBB06 Feld ZDTS. Der Inhalt ergibt sich aus der Verkettung der Auslieferungsgruppe (z. B. 300 = Food) und den Terminierungsgruppen (nicht sprechendes Gruppierungsmerkmal das Lieferzyklen innerhalb der Auslieferungsgruppe steuert).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, art_id, gp_id, loesch_fg, dat_von) NOT ENFORCED
)
OPTIONS(description='SCM - Filialversorgung Zuordnung Beschaffungszyklen aus ZE1WBB06. SAP lädt die Daten täglich neu ohne sie zu historisieren, was über diese Tabelle hier gelöst wird.');