CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_ART_KUNDE_VKORG_VW_ZU
-- 10.03.2015 twie: Artikel Mapping von sendenden und empfangenen Werk
--                            Wenn in Dtl versendet und CZ empfangen, dort eine andere Artikelnummer, deshalb muss von de auf cz Material gemappt werden.

(
in_art_id
,mandant_id
,in_art_id_kunde
,mandant_id_kunde
)
AS

   -- Artikel wird auf sich selbst gemappt, inlaendische Lieferung
   --bspw. dt. Werk versendet (dt. Artikel) und dt. Werk empfaengt (dt. Artikel)
   SELECT
   v01.in_art_id, v01.mandant_id, v01.in_art_id AS in_art_id_kunde, v01.mandant_id AS mandant_id_kunde
   FROM dbp_msi_view_flw.mv_l_in_art v01


   UNION ALL


   -- DE Artikel wird auf CZ Artikel gemappt bzw. umgekehrt fuer auslaendische Lieferung
   --bspw. dt. Werk versendet (dt. Artikel) und cz. Werk empfaengt (cz. Artikel)
   SELECT
   v01.in_art_id, v01.mandant_id, v02.in_art_id_kunde, v02.mandant_id_kunde
   FROM dbp_msi_view_flw.mv_l_in_art v01
   INNER JOIN
   (
   SELECT
   v01.flw_art_id AS in_art_id, v01.mandant_id, MAX(v01.flw_art_id_kunde) AS in_art_id_kunde, MAX(v01.mandant_id_kunde) AS mandant_id_kunde
   FROM dbp_view.v_flw_art_kunde_vkorg_vw_zu v01
   GROUP BY
   v01.flw_art_id
   ,v01.mandant_id
   ) v02
   ON v01.in_art_id = v02.in_art_id
   AND v01.mandant_id = v02.mandant_id;