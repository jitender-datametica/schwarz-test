--==============================================================
-- Table: ts_scm_l_wup_cluster_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_l_wup_cluster_1
   generated from Powerdesigner on Freitag, 30. April 2021 16:22:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_scm_l_wup_cluster_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_cluster_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktcluster ID'),
wup_cluster_bez STRING(50) NOT NULL OPTIONS(description='Marktcluster Kurzbezeichnung'),
wup_cluster_descr STRING(255) OPTIONS(description='Marktcluster Beschreibung'),
wup_cluster_del_fg BIGNUMERIC(38,0) OPTIONS(description='Marktcluster Löschflag'),
update_timestamp TIMESTAMP NOT NULL OPTIONS(description='Zeitpunkt letzte Änderung'),
update_user STRING(50) NOT NULL OPTIONS(description='User LDAP letzte Änderung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Marktcluster (Kopf) für KL_SCM');