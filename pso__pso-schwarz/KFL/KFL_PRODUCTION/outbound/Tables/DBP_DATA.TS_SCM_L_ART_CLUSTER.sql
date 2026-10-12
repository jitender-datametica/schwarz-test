--==============================================================
-- Table: ts_scm_l_art_cluster
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_l_art_cluster
   generated from Powerdesigner on Freitag, 30. April 2021 16:21:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_scm_l_art_cluster (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_cluster_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelcluster ID'),
art_cluster_bez STRING(50) NOT NULL OPTIONS(description='Artikelcluster Kurzbezeichnung'),
art_cluster_descr STRING(255) OPTIONS(description='Artikelcluster Beschreibung'),
art_cluster_del_fg BIGNUMERIC(38,0) OPTIONS(description='Artikelcluster Löschflag'),
update_timestamp TIMESTAMP NOT NULL OPTIONS(description='Zeitpunkt letzte Aenderung'),
update_user STRING(50) NOT NULL OPTIONS(description='User LDAP letzte Aenderung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Artikelcluster (Kopf) für KL_SCM');