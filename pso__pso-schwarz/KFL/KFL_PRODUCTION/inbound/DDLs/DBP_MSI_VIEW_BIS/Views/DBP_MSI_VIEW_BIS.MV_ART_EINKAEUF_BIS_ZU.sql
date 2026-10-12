CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_ART_EINKAEUF_BIS_ZU
-- 19.06.2015 Zuordnungstabelle Einkäufergruppe Material zu Material (=Artikel)
-- In der in_art Tabelle gibt es sowohl eine Spalte mit Zuordnung des Artikels zu int. Eink.gr. (einkaeufer_bis_int_id)
-- sowie zu nat. Eink.gr. (einkaeufer_grp_id)
-- beides wird hier zusammengefügt, da Attribut Einkäufergruppe Material die int. und nat. beinhaltet
-- somit gemeinsame Zuordnungstabelle, ein Artikel kann 2x vorkommen, 1x int und 1x nat
(
art_mandant_id
,in_art_id
,eink_mandant_id
,einkaeufer_bis_id
)
AS
   SELECT art_mandant_id,
   in_art_id,
   eink_mandant_id,
   einkaeufer_bis_id
   FROM
   (
   SELECT v01.mandant_id AS art_mandant_id,
   v01.in_art_id,
   99 AS eink_mandant_id,
   v01.einkaeufer_bis_int_id AS einkaeufer_bis_id
   FROM dbp_view.v_in_art v01
   ) t0

   UNION

   SELECT art_mandant_id,
   in_art_id,
   eink_mandant_id,
   einkaeufer_bis_id
   FROM
   (
   SELECT v01.mandant_id AS art_mandant_id,
   v01.in_art_id,
   mandant_id AS eink_mandant_id,
   COALESCE(v01.einkaeufer_grp_id,'-1') AS einkaeufer_bis_id
   FROM dbp_view.v_in_art v01
   ) t1;