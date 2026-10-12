/* --------------------------------------------------------------------------------
   DDL for table: t_lil_period_descr
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_period_descr (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the client'),
period_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PERIOD'),
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Sprache - Code'),
period_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Perioden-Beschreibung'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (period_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $ Uebersetzungstabelle fuer Periodenkennzeichnungen fur Projekt LIAM LIFT / CM             ');