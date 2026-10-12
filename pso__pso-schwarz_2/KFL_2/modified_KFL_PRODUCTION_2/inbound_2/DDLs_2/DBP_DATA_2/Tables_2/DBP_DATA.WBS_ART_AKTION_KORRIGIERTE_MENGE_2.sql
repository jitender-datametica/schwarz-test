--==============================================================
-- Table: wbs_art_aktion_korrigierte_menge_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_art_aktion_korrigierte_menge_2
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 14:26:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_ART_AKTION_KORRIGIERTE_MENGE_2 DATA_RETENTION_TIME_IN_DAYS = 15(
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Filial-ID.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Nebenbetriebs-ID.',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnuummer',
   dat_von_aktion                      DATE             NOT NULL COMMENT 'Startdatum des Artikelaktionszeitraums. Kann mehrere Aktionen betreffen, da ein Zeitraum zu mehreren aktion_ids zugeordnet sein kann.',
   dat_bis_aktion                      DATE             NOT NULL COMMENT 'Enddatum des Artikelaktionszeitraums. Kann mehrere Aktionen betreffen, da ein Zeitraum zu mehreren aktion_ids zugeordnet sein kann.',
   zeitraum_korrigierte_menge          NUMBER(29,3)     COMMENT 'Um Außreißer bereinigte Abverkaufsmenge im Zeitraum. Da es in einem Zeitraum mehr als eine_2 Aktion_2 geben kann, kann man nicht unterscheiden zu welcher Aktion_2 ein Abverkauf stattfand. Darum hat die Menge eine_2 andere Granularität als Aktion_2 und ist auf Ebene Zeitraum.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_ART_AKTION_KORRIGIERTE_MENGE PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_von_aktion, dat_bis_aktion) NOT ENFORCED
)  COMMENT = 'SCM-WBS - Table for aiding the loading process. This table stores the data coming from AI correcting outliers of promotional item_2 sales_2 quantities. The loading file from AI over time drops their calculations for older promotions and this table keeps record of the data.
             The corrections for amounts are necessary to create realistic quantity predictions for for future promotions of that article. Outliers happen, i.e., because stores run out of stock, or special outside occasions such as donations lead to large sales_2 quantities. These outliers would skew delivery quantity predictions.';
