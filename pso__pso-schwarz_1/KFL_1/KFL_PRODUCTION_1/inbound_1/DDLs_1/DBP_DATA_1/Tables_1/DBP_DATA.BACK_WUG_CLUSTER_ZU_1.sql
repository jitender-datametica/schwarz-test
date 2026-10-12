--==============================================================
-- Table: back_wug_cluster_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: back_wug_cluster_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BACK_WUG_CLUSTER_ZU_1 (
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID. Kennzeichnet',
   wg_id                               NUMBER(38,0)     NOT NULL COMMENT 'ID der Warengruppe',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wug_id                              NUMBER(38,0)     NOT NULL COMMENT 'Warenuntergruppe-ID. Die Warenuntergruppe ist nur zusammen mit der Warengruppe eindeutig',
   wug_cluster_id                      NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BACK_WUG_CLUSTER_ZU PRIMARY KEY (arthiertyp_id, wg_id, mandant_id, wug_id) NOT ENFORCED
)  COMMENT = 'VIS Backshop -Zuordnung wug_1-Cluster zu Warenuntergruppe aus der Quelltabelle zek_bake_wgicl';

