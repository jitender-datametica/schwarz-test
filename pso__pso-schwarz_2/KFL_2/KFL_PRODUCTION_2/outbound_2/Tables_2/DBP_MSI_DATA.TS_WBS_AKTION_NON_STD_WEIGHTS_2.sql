--==============================================================
-- Table: ts_wbs_aktion_non_std_weights_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_aktion_non_std_weights_2
   generated from Powerdesigner on Donnerstag, 1. Dezember 2022 18:54:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_wbs_aktion_non_std_weights_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
werbe_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Werbetyp-ID. sollte werbe_typ_id heißen (eine_2 weitere Bezeichnung für den gleichen Inhalt ist unnötig). Ein Werbetyp ist ein Standardwerbezeitraum. Dieser sagt je Mandant_2 aus, von welchem bis zu welchem Wochentag eine_2 Aktion_2 geht. (Die festgelegten Tage eines Eintrags lassen sich danach aber manuell verändern = abweichender Werbezeitraum.)'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderwoche in der die Aktion_2 startet.'),
dat_quelle DATE NOT NULL
OPTIONS(description='Quelldatum, von dem die prozentualen Abverkäufe der Werbeartikel abgezogen und auf ein anderes Zieldatum umverteilt werden. Von einem Quelldatum kann mehrmals abgezogen und an verschiedene Zieldaten verteilt werden.'),
dat_ziel DATE NOT NULL
OPTIONS(description='Zieldatum, an das die prozentualen Abverkäufe Werbemenge umverteilt werden (die vom Quelldatum abgezogen wurden).'),
gewichtung_prz BIGNUMERIC(38,3)
OPTIONS(description='Gewichtungen für Hadoop oder Databricks. Prozentsatz der Abverkäufe der Werbeartikel. Wird teils gespeichert als Zahl zwischen 0 und 100.'),
dat_von_orig DATE NOT NULL
OPTIONS(description='Original promotion start. Calculation of promotion start/-end-Date similar to MV_WERBE_WOCHE_WBS.'),
dat_bis_orig DATE NOT NULL
OPTIONS(description='Original promotion end. Calculation of promotion start/-end-Date similar to MV_WERBE_WOCHE_WBS.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbe_typ_id, kjwo, dat_quelle, dat_ziel) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - Weights for WBS non-standard promotion calculation, content maintained by transaction services document. Weights signal how much (in percent) of the expected sales_2 of promotional goods is transferred from a source to a target date, in case of a non-std promotion with different dates.');