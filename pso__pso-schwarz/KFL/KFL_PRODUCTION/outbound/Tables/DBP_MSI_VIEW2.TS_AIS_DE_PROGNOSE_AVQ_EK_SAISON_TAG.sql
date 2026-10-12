--==============================================================
-- Table: ts_ais_de_prognose_avq_ek_saison_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_prognose_avq_ek_saison_tag
   generated from Powerdesigner on Wednesday, 15 May 2024 20:17:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view2.ts_ais_de_prognose_avq_ek_saison_tag (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
ek_saison_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Cluster-ID des zugehörigen EK-Saisonclusters in dem Artikel gebündelt sind.'),
dat_prognose DATE NOT NULL OPTIONS(description='Datum für das die Prognose errechnet wurde.'),
menge_absatz_prognose BIGNUMERIC(38,3) NOT NULL
OPTIONS(description='Absatzprognose, immer gebündelt je Saison(-artikel) pro Tag. Dient der Berechnung einer Ziel-AVQ (Abverkaufsquote). Prognose je Saison grundsätzlich einheitlich je Basismengeneinheit. Vereinzelte Saisons können Stück- und Gewichtsartikel kombinieren, weshalb sich eine Mengeneinheit nicht immer zweifelsfrei zuordnen lässt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ek_saison_id, dat_prognose) NOT ENFORCED
)
OPTIONS(description='AIS DE - Absatzprognose für das EKCO DE AVQ (Abverkaufsquote) Dossier. Absatzprognose gebündelt auf Ebene EK-Saison und Tag. Prognose grundsätzlich je EK-Saison zwischen Stück- und Gewichtsartikel getrennt. Für einzelne Saison-Auswertungen können Stück- und Gewichtsartikel gemischt sein, weshalb sich eine Mengeneinheit nicht immer zweifelsfrei zuordnen lässt.             Achtung: Diese Tabelle hier ist als Zwischenlösung gedacht, bis der Prozess für den Umgang mit Transaction Service Tabellen, die Notwendigkeit Daten manuell ins DWH zu bringen, oder der Umgang mit nicht standardisierten Ladeprozessen geklärt ist.');