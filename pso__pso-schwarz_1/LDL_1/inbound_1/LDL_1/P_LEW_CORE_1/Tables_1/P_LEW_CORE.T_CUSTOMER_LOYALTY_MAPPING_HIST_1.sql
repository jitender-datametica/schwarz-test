/* --------------------------------------------------------------------------------
   DDL for table: t_customer_loyalty_mapping_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_LOYALTY_MAPPING_HIST_1 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Kunde; FK auf CUSTOMER',
   loyalty_cd                          VARCHAR(100)     NOT NULL COMMENT 'Loyalty-ID, die fuer den Kunden im LidlPlus-System vergeben wurde; gehasht bei Telefonnummern',
   ident_type_cd                       VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Typ der Loyalty-ID',
   mapping_start_tmsp                  TIMESTAMP_NTZ(9) COMMENT 'Zeitpunkt, ab dem das Mapping fachlich gilt',
   mapping_end_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'Zeitpunkt, bis zu dem das Mapping fachlich gilt',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Lokation ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CUSTOMER_LOYALTY_MAPPING_HIST PRIMARY KEY (loyalty_cd, customer_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. CULO; Mappingtabelle zwischen Loyalty-ID und Customer aus LidlPlus; 
             LidlPlus';

