CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_HERST_ZU_EINZIG_1
(
 mandant_id
,art_id
,herst_id
,gp_id
,akt_gp_id
)  TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

WITH ART_GP_ZU_PER_AUFLOESUNG AS
-- Neuanlage AP0201352 / SPEC0231073 - sschuecke 09.01.2024
(
   SELECT
    mandant_id
   ,art_id
   ,herst_id
   FROM dbp_view.v_art_gp_zu_per_1
   WHERE mandant_id > 1
   QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, art_id ORDER BY herst_id DESC NULLS LAST, dat_bis DESC NULLS LAST) = 1

  /*
	Annahmen:
  - Ein Artikel_1 kann immer nur einem Hersteller zugeordnet sein, 1:1 Zuordnung
  - Ändert sich der Hersteller, muss diese Information in der EINA_1 für alle Infosätze (alt und neu) angepasst werden
  */
	  
)
   
   SELECT DISTINCT
    v01.mandant_id
   ,v01.art_id
   ,CASE WHEN v01.herst_id = v02.gp_id THEN -2 ELSE v01.herst_id END herst_id
   ,v02.gp_id
   ,v02.gp_id AS akt_gp_id
   FROM art_gp_zu_per_aufloesung v01
   LEFT JOIN dbp_view.v_art_gp_nm_zu_per_1 v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   WHERE v01.mandant_id > 1;