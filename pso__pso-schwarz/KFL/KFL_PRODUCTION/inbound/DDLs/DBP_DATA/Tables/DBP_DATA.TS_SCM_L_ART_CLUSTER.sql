--==============================================================
-- Table: ts_scm_l_art_cluster
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_l_art_cluster
   generated from Powerdesigner on Freitag, 30. April 2021 16:21:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ts_scm_l_art_cluster (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   art_cluster_id                      NUMBER(38,0)    NOT NULL COMMENT 'Artikelcluster ID',
   art_cluster_bez                     VARCHAR(50)     NOT NULL COMMENT 'Artikelcluster Kurzbezeichnung',
   art_cluster_descr                   VARCHAR(255)    COMMENT 'Artikelcluster Beschreibung',
   art_cluster_del_fg                  NUMBER(38,0)    COMMENT 'Artikelcluster Löschflag',
   update_timestamp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'Zeitpunkt letzte Aenderung',
   update_user                         VARCHAR(50)     NOT NULL COMMENT 'User LDAP letzte Aenderung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Artikelcluster (Kopf) für KL_SCM';