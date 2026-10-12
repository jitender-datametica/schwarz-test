--==============================================================
-- Table: ts_scm_l_wup_cluster_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_l_wup_cluster_2
   generated from Powerdesigner on Freitag, 30. April 2021 16:22:52
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ts_scm_l_wup_cluster_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_cluster_id                      NUMBER(38,0)    NOT NULL COMMENT 'Marktcluster ID',
   wup_cluster_bez                     VARCHAR(50)     NOT NULL COMMENT 'Marktcluster Kurzbezeichnung',
   wup_cluster_descr                   VARCHAR(255)    COMMENT 'Marktcluster Beschreibung',
   wup_cluster_del_fg                  NUMBER(38,0)    COMMENT 'Marktcluster Löschflag',
   update_timestamp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'Zeitpunkt letzte Änderung',
   update_user                         VARCHAR(50)     NOT NULL COMMENT 'User LDAP letzte Änderung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Marktcluster (Kopf) für KL_SCM';