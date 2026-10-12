CREATE TABLE P_LEW_CORE.T_REF_CONTACT_MEDIUM (
   contact_medium_cd         VARCHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'code of the contact medium as used to link to the common WAWI description table',
   contact_medium_descr      VARCHAR(100)  COMMENT 'description of the contact medium as used to link to the common WAWI description table',
   dwh_load_id               NUMBER(38,0)  NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created        	    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated      	    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_REF_CONTACT_MEDIUM PRIMARY KEY (contact_medium_cd)
       NOT enforced
)
COMMENT = '$Revision: 0000 $. table contains types of contact medias
          Source: static reference, derived from WAWI table t007_description';