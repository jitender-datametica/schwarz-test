--==============================================================
-- Table: prognose_artbew_wg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: prognose_artbew_wg_sum_1
   generated from Powerdesigner on Freitag, 19. Mai 2023 14:44:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.prognose_artbew_wg_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppe'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT, Bezugsdatum der Prognose aus udf_prognose_1'),
dat_prognoselauf DATE NOT NULL
OPTIONS(description='Datum des Prognoselaufs (ENTRY_DATE) aus udf_prognose_1 an dem die Prognose erstellt wurde'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
udf_prognose_horizont BIGNUMERIC(38,3) OPTIONS(description='Anzahl Tage Prognosehorizont UDF (<= 100)'),
fur_prognose_horizont BIGNUMERIC(38,3) OPTIONS(description='Anzahl Tage Prognosehorizont F&R (<= 80)'),
udf_vk_menge BIGNUMERIC(38,3) OPTIONS(description='Menge Absatz in BME für Datensätze MIT UDF-Prognose'),
udf_vk_menge_sa BIGNUMERIC(38,3)
OPTIONS(description='Menge Absatz in BME für Datensätze MIT UDF-Prognose (nur Sonderaktion)'),
udf_vk_menge_af BIGNUMERIC(38,3)
OPTIONS(description='Menge Absatz in BME für Datensätze MIT UDF-Prognose (nur Aktionsfrei)'),
udf_menge_prognose BIGNUMERIC(38,3) OPTIONS(description='Menge Prognose in BME (UDF, nur Aktionsfrei)'),
udf_menge_prognose_sa BIGNUMERIC(38,3) OPTIONS(description='Menge Prognose in BME (UDF)'),
udf_menge_prognose_af BIGNUMERIC(38,3) OPTIONS(description='Menge Prognose in BME (UDF, nur Sonderaktion)'),
udf_abs_diff BIGNUMERIC(38,3) OPTIONS(description='Absolute Differenz Absatz/Prognose UDF'),
udf_abs_diff_sa BIGNUMERIC(38,3) OPTIONS(description='Absolute Differenz Absatz/Prognose UDF (nur Sonderaktion)'),
udf_abs_diff_af BIGNUMERIC(38,3) OPTIONS(description='Absolute Differenz Absatz/Prognose UDF (nur Aktionsfrei)'),
udf_gesteuert_menge_prognose BIGNUMERIC(38,3)
OPTIONS(description='Mengegesteuerte Prognose in BME (UDF, nur Aktionsfrei)'),
udf_gesteuert_menge_prognose_sa BIGNUMERIC(38,3) OPTIONS(description='Menge gesteuerte Prognose in BME (UDF)'),
udf_gesteuert_menge_prognose_af BIGNUMERIC(38,3)
OPTIONS(description='Menge gesteuerte Prognose in BME (UDF, nur Sonderaktion)'),
udf_gesteuert_abs_diff BIGNUMERIC(38,3) OPTIONS(description='Absolute Differenz Absatz/gesteuerte Prognose UDF'),
udf_gesteuert_abs_diff_sa BIGNUMERIC(38,3)
OPTIONS(description='Absolute Differenz Absatz/gesteuerte Prognose UDF (nur Sonderaktion)'),
udf_gesteuert_abs_diff_af BIGNUMERIC(38,3)
OPTIONS(description='Absolute Differenz Absatz/gesteuerte Prognose UDF (nur Aktionsfrei)'),
fur_menge_prognose BIGNUMERIC(38,3) OPTIONS(description='Menge mittlere Prognose in BME (F&R)'),
fur_menge_prognose_sa BIGNUMERIC(38,3) OPTIONS(description='Menge mittlere Prognose in BME (F&R, nur Sonderaktion)'),
fur_menge_prognose_af BIGNUMERIC(38,3) OPTIONS(description='Menge mittlere Prognose in BME (F&R, nur Aktionsfrei)'),
fur_menge_prognose_max BIGNUMERIC(38,3) OPTIONS(description='Menge max. Prognose in BME (F&R)'),
fur_vk_menge BIGNUMERIC(38,3) OPTIONS(description='Menge Absatz in BME für Datensätze MIT F&R-Prognose'),
fur_vk_menge_sa BIGNUMERIC(38,3)
OPTIONS(description='Menge Absatz in BME für Datensätze MIT F&R-Prognose (nur Sonderaktion)'),
fur_vk_menge_af BIGNUMERIC(38,3)
OPTIONS(description='Menge Absatz in BME für Datensätze MIT F&R-Prognose (nur Aktionsfrei)'),
fur_abs_diff BIGNUMERIC(38,3) OPTIONS(description='Absolute Differenz Absatz/Prognose F&R'),
fur_abs_diff_sa BIGNUMERIC(38,3) OPTIONS(description='Absolute Differenz Absatz/Prognose F&R (nur Sonderaktion)'),
fur_abs_diff_af BIGNUMERIC(38,3) OPTIONS(description='Absolute Differenz Absatz/Prognose F&R (nur Aktionsfrei)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat, dat_prognoselauf, wg_id) NOT ENFORCED
)
OPTIONS(description='Vergleich verschiedener Prognosen auf Ebene von Mandant_1, Warenumschlagplatz, Nebenbestriebskennziffer, Warengruppe, Datum für das prognostiziert wird und Datum an dem die Prognose erstellt wurde.             Erstellung der Prognosen erfolgt täglich und automatisiert.                          BME = Basismengeneinheit, BME ist über Warengruppe nicht zwangsläufig additiv, da Stück und Gewicht gemischt möglich sind, dem Fachbereich bekannt.                          Sonderaktion oder Aktionsfrei oder keins davon wird über aktionslistung_fg in Tabelle "aktion_1" gesteuert ( 0=keines, 1=Sonderaktion, null=Aktionsfrei ).                          Werte in Spalten mit "gesteuert" werden für Anpassungen durch Nutzer beim nächsten Lauf bestimmt, Nutzer gibt Bedarfseinflussfaktor in SAP an.');