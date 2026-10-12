/* --------------------------------------------------------------------------------
   DDL for table: t_country
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_country (
country_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identisch zur WAWI COUNTRY_ID = WAWI LANGUAGE_ID = WAWI CLIENT_ID'),
src_country_lidl_cd STRING(20) NOT NULL OPTIONS(description='trad. Schluessel aus WAWI; COUNTRY_ID'),
src_lang_id BIGNUMERIC(38,0)
OPTIONS(description='trad. Schluessel aus WAWI fur Language (formal integriert fur Umschluesselung); LANGUAGE_ID'),
country_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Name des LILAs in Stiftungssprache; '),
country_grp_sid BIGNUMERIC(38,0) OPTIONS(description='FK auf COUNTRY GROUP'),
lang_sid BIGNUMERIC(38,0) OPTIONS(description='Default-Sprache; FK auf REPORT LANGUAGE'),
lang_cd STRING(20) OPTIONS(description='Default-Sprache (Code); Quelle: WAWI: x_data.t_ref_language'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (country_sid) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. CTRY; LIDL-Lander (LILA).              manuelle Befullung');