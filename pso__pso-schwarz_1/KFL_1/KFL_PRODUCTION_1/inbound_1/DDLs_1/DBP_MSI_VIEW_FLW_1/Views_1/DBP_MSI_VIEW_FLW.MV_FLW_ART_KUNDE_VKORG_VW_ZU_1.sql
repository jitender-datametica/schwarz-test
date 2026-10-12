CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_ART_KUNDE_VKORG_VW_ZU_1
-- 10.03.2015 twie: Artikel_1 Mapping von sendenden und empfangenen Werk
--                            Wenn in Dtl versendet und CZ empfangen, dort eine_1 andere Artikelnummer, deshalb muss von de auf cz Material gemappt werden.

(
in_art_id
,mandant_id
,in_art_id_kunde
,mandant_id_kunde
)
AS

   -- Artikel_1 wird auf sich selbst gemappt, inlaendische Lieferung
   --bspw. dt. Werk versendet (dt. Artikel_1) und dt. Werk empfaengt (dt. Artikel_1)
   SELECT
   v01.in_art_id, v01.mandant_id, v01.in_art_id AS in_art_id_kunde, v01.mandant_id AS mandant_id_kunde
   FROM dbp_msi_view_flw.mv_l_in_art_1 v01


   UNION ALL


   -- DE Artikel_1 wird auf CZ Artikel_1 gemappt bzw. umgekehrt fuer auslaendische Lieferung
   --bspw. dt. Werk versendet (dt. Artikel_1) und cz. Werk empfaengt (cz. Artikel_1)
   SELECT
   v01.in_art_id, v01.mandant_id, v02.in_art_id_kunde, v02.mandant_id_kunde
   FROM dbp_msi_view_flw.mv_l_in_art_1 v01
   INNER JOIN
   (
   SELECT
   v01.flw_art_id AS in_art_id, v01.mandant_id, MAX(v01.flw_art_id_kunde) AS in_art_id_kunde, MAX(v01.mandant_id_kunde) AS mandant_id_kunde
   FROM dbp_view.v_flw_art_kunde_vkorg_vw_zu_1 v01
   GROUP BY
   v01.flw_art_id
   ,v01.mandant_id
   ) v02
   ON v01.in_art_id = v02.in_art_id
   AND v01.mandant_id = v02.mandant_id;