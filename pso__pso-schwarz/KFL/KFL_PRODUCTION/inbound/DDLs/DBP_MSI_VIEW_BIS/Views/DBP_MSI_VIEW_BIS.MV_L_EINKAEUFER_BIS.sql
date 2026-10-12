CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_EINKAEUFER_BIS
-- 16.06.2014 twie: Lookup für Attribut Einkäufergruppe Material. Dieses fasst nat. und int. Eink.gruppen zusammen aus 2 Tabellen.
-- Somit können nat. und int. EKGR über das gleiche Attribut gesteuert werden. Für die int. wird die 99 als Mandant definiert.
-- Funktioniert analog der Einkäufergruppe Lieferant (mv_l_einkaeufer_grp) mit den gleichen Einträgen, nur diese sind nicht dem Lieferant sondern dem Material zugordnet
-- 09.11.2015 twie: auf aktive EKGR filtern (aktiv_fg = 0 sind im SAP gelöscht)
-- 20.09.2016 twie: SPEC0014806 Dummy EKGR - 1für DE ausgeben

(
mandant_id
,einkaeufer_bis_id
)
AS

   SELECT mandant_id,
   einkaeufer_bis_id
   FROM
   (

   SELECT
   99 AS mandant_id,
   einkaeufer_bis_int_id AS einkaeufer_bis_id
   FROM dbp_view.v_in_l_einkaeufer_bis_int
   ) t0

   UNION

   SELECT mandant_id,
   einkaeufer_bis_id
   FROM
   (
   SELECT
   v01.mandant_id,
   v01.einkaeufer_grp_id AS einkaeufer_bis_id
   FROM dbp_view.v_in_l_einkaeufer_grp v01
   WHERE v01.aktiv_fg = 1
   AND (v01.mandant_id <> 1
   OR (v01.mandant_id = 1 AND (SUBSTR(v01.einkaeufer_grp_id, 1, 1) = 'S' OR v01.einkaeufer_grp_id = '-1')))
   ) t1
;