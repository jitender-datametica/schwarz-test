/* --------------------------------------------------------------------------------
   DDL for table: t_lil_retailer_descr_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_lil_retailer_descr_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the client'),
retailer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key RETAILER'),
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Sprache - Code'),
retailer_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Einzelhaendler-Beschreibung'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (retailer_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $ Mehrsprachige Bezeichnungen fuer Einzelhaendler / -Gruppen');