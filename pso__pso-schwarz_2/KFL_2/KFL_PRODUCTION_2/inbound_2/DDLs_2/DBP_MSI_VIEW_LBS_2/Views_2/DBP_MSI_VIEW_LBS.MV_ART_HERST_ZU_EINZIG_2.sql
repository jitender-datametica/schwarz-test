CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_ART_HERST_ZU_EINZIG_2(
	MANDANT_ID,
	ART_ID,
	HERST_ID,
	GP_ID,
	AKT_GP_ID
) AS

WITH ART_GP_ZU_PER_AUFLOESUNG AS
-- Neuanlage AP0201352 / SPEC0231073 - sschuecke 09.01.2024
(
   SELECT
    mandant_id
   ,art_id
   ,herst_id
   FROM dbp_view.v_art_gp_zu_per_2
   QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, art_id ORDER BY herst_id DESC NULLS LAST, dat_bis DESC NULLS LAST) = 1

  /*
	Annahmen:
  - Ein Artikel_2 kann immer nur einem Hersteller zugeordnet sein, 1:1 Zuordnung
  - Ändert sich der Hersteller, muss diese Information in der EINA_2 für alle Infosätze (alt und neu) angepasst werden
  */
	  
)
   
   SELECT DISTINCT
    v01.mandant_id
   ,v01.art_id
   ,CASE WHEN v01.herst_id = v02.gp_id THEN -2 ELSE v01.herst_id END herst_id
   ,v02.gp_id
   ,v02.gp_id AS akt_gp_id
   FROM art_gp_zu_per_aufloesung v01
   LEFT JOIN dbp_view.v_art_gp_nm_zu_per_2 v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id;