--==============================================================
-- Table: avq_werbung_pmr_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: avq_werbung_pmr_det_2
   generated from Powerdesigner on Mittwoch, 8. Oktober 2025 08:32:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.avq_werbung_pmr_det_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
dat_aktion_von DATE NOT NULL OPTIONS(description='Werbung/Aktion_2 gültig ab'),
dat_aktion_bis DATE NOT NULL OPTIONS(description='Werbung/Aktion_2 gültig bis'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Nummer des Angebots aus PMR'),
werbemittelkanal_id STRING(4) NOT NULL
OPTIONS(description='Werbemittel Art_2 ID - medium through which the advertisement is shown (paper, digital)'),
werbemittel_id STRING(2) NOT NULL
OPTIONS(description='Werbemittel - on what item_2 the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)'),
werbeflaechenthema_cd STRING(50) NOT NULL OPTIONS(description='Code des Werbeflaechenthemas'),
werbeflaechenabschnitt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbeflächenabschnitts'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Eindeutige Kennung einer Aktion_2 aus der Quelle wakh.aktnr'),
dat_sperrung BIGNUMERIC(38,0) OPTIONS(description='Datum, zu dem ein Artikel_2 gesperrt wurde. Aus aktion_art_wup_zu_2'),
dat_preisaktivierung DATE OPTIONS(description='Datum der Aktionspreisaktivierung. Aus aktion_art_wup_zu_2'),
dat_geloescht_sap DATE OPTIONS(description='Datum der Löschung. Aus aktion_art_wup_zu_2'),
kjwo BIGNUMERIC(38,0)
OPTIONS(description='Kalenderjahreswoche. Format JJJJWW. Fuer DE die Woche_2, in der die Werbung endet. Fuer KMO die Woche_2, in der die Werbung beginnt.'),
bby_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Bonusbuy'),
kdn_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: KDN-Aktion_2 (K-CARD)'),
kdp_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: KDP-Aktion_2 (Kundenindividuell)'),
pmr_top_art_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='TOP-Artikel_2 Flag (PMR)'),
werbemittel_avq_prio_nr BIGNUMERIC(38,0)
OPTIONS(description='Für die AVQ können verschiedene Werbemittel zusammengefasst werden, ID gibt die Reihenfolge / Priorisierung vor'),
werbeflaechenabschnitt_avq_prio_nr BIGNUMERIC(38,0) OPTIONS(description='Bezeichnung des Werbeflaechenthemas (AVQ)'),
werbeflaechenthema_avq_prio_nr BIGNUMERIC(38,0)
OPTIONS(description='Für die AVQ können verschiedene Werbeflächenthemen zusammengefasst und/oder priorisiert werden, ID gibt die Reihenfolge vor'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_aktion_von, dat_aktion_bis, angebot_nr, werbemittelkanal_id,
 werbemittel_id, werbeflaechenthema_cd, werbeflaechenabschnitt_id) NOT ENFORCED
)
OPTIONS(description='AVQ(Abverkaufsquote) PMR-Details - Zusatzebene, enthält alle relevanten Aktionen sowie Angebote(Offers) im Aktionszeitraum inkl. aller zugeordneter Werbemittel/Flächen/Abschnitte.');