--==============================================================
-- Table: wbs_art_aktion_korrigierte_menge
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_aktion_korrigierte_menge
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 14:26:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_art_aktion_korrigierte_menge (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filial-ID.'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetriebs-ID.'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnuummer'),
dat_von_aktion DATE NOT NULL
OPTIONS(description='Startdatum des Artikelaktionszeitraums. Kann mehrere Aktionen betreffen, da ein Zeitraum zu mehreren aktion_ids zugeordnet sein kann.'),
dat_bis_aktion DATE NOT NULL
OPTIONS(description='Enddatum des Artikelaktionszeitraums. Kann mehrere Aktionen betreffen, da ein Zeitraum zu mehreren aktion_ids zugeordnet sein kann.'),
zeitraum_korrigierte_menge BIGNUMERIC(38,3)
OPTIONS(description='Um Außreißer bereinigte Abverkaufsmenge im Zeitraum. Da es in einem Zeitraum mehr als eine Aktion geben kann, kann man nicht unterscheiden zu welcher Aktion ein Abverkauf stattfand. Darum hat die Menge eine andere Granularität als Aktion und ist auf Ebene Zeitraum.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_von_aktion, dat_bis_aktion) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - Table for aiding the loading process. This table stores the data coming from AI correcting outliers of promotional item sales quantities. The loading file from AI over time drops their calculations for older promotions and this table keeps record of the data.             The corrections for amounts are necessary to create realistic quantity predictions for for future promotions of that article. Outliers happen, i.e., because stores run out of stock, or special outside occasions such as donations lead to large sales quantities. These outliers would skew delivery quantity predictions.');