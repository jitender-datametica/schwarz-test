/* --------------------------------------------------------------------------------
   DDL for table: t_country_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_COUNTRY_1 (
   country_sid                         NUMBER(38,0)     NOT NULL COMMENT 'identisch zur WAWI COUNTRY_ID = WAWI LANGUAGE_ID = WAWI CLIENT_ID',
   src_country_lidl_cd                 VARCHAR(20)      NOT NULL COMMENT 'trad. Schluessel aus WAWI; COUNTRY_ID',
   src_lang_id                         NUMBER(38,0)     COMMENT 'trad. Schluessel aus WAWI fur Language (formal integriert fur Umschluesselung); LANGUAGE_ID',
   country_name                        VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Name des LILAs in Stiftungssprache; ',
   country_grp_sid                     NUMBER(38,0)     COMMENT 'FK auf COUNTRY_1 GROUP',
   lang_sid                            NUMBER(38,0)     COMMENT 'Default-Sprache; FK auf REPORT LANGUAGE',
   lang_cd                             VARCHAR(20)      COMMENT 'Default-Sprache (Code); Quelle: WAWI: x_data.t_ref_language',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_COUNTRY PRIMARY KEY (country_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. CTRY; LIDL-Lander (LILA). 
             manuelle Befullung';

