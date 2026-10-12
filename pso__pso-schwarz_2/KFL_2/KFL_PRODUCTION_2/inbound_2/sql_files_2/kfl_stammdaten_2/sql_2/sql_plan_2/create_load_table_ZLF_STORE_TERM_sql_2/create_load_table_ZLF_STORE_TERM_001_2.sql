DROP TABLE IF EXISTS DBP_ETL.zlf_storeterm_2;
CREATE  TABLE DBP_ETL.zlf_storeterm_2  (
 mandant_id                     BYTEINT
,wup_id                         INTEGER
,nb_id                          SMALLINT
,kunde_id                       INTEGER
,wg_id                          SMALLINT
,arthiertyp_id                  BYTEINT
,sortimentslistenart_id         CHAR(1) COLLATE 'en-ci'
,terminierungsgruppe_1_id       CHAR(3) COLLATE 'en-ci'
,terminierungsgruppe_2_id       CHAR(2) COLLATE 'en-ci'
,terminierungsgruppe_3_id       CHAR(2) COLLATE 'en-ci'
,kwoab                          INTEGER
,kwobi                          INTEGER
,auslieferungsgruppe_id         CHAR(4) COLLATE 'en-ci'
,disposition_rhythmus_ltf_id    CHAR(3) COLLATE 'en-ci'
,we_bearbeitungszeit            SMALLINT
,planlieferzeit                 SMALLINT
,td_insert                      TIMESTAMP_LTZ(9)

) ;

