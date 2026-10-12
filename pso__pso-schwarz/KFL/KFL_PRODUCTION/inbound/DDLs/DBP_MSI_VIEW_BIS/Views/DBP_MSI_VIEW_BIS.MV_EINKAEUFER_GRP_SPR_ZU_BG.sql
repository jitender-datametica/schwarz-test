CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_EINKAEUFER_GRP_SPR_ZU_BG
-- 17.12.2014: Sprachtabelle für Attribut Einkäufergruppe Lieferant. Dieses fasst nat. und int. Eink.gruppen zusammen aus 2 Tabellen.
-- In der Basistabelle gibt es keinen Mandanten
-- In den Berichten wird von den Attributen her nicht mehr unterschieden, ob es eine nationale Sicht (in_l_einkaeufer_grp)
-- oder eine Internationale Sicht (in_l_einkaeufer_int) ist.
-- Es gibt also eine Einkäufergruppe, die sowohl nationale als auch internationale Inhalte hat
-- Hier wird Mandant 99 erfunden, damit in der Berichts SQL die Daten zusammenfinden
-- 19.02.2015 twie: für Mandant 1 nur Eink.gruppen ausgeben, die mit 'S' beginnen.
--  Cast von einkaeufer_int_id auf CHAR entfällt weil Quelle jetzt CHAR(3)
-- 09.11.2015 twie: auf aktive EKGR filtern (aktiv_fg = 0 sind im SAP gelöscht)
-- 20.09.2016 twie: SPEC0014806 Dummy EKGR - 1für DE ausgeben
-- 06.12.2016 twie: SPEC0017788 EKGR -1 für alle Länder ausschließen, zugeordnete Lieferanten sind nicht beschaffungsrelevant

(
mandant_id
,einkaeufer_grp_id
,einkaeufer_grp_bez
)
AS

   SELECT mandant_id,
   einkaeufer_grp_id,
   einkaeufer_grp_bez
   FROM
   (

   SELECT
   99 AS mandant_id,
   einkaeufer_int_id AS einkaeufer_grp_id,
   einkaeufer_int_name AS einkaeufer_grp_bez
   FROM dbp_view.v_in_l_einkaeufer_int
   ) t0

   UNION

   SELECT *
   FROM
   (
   SELECT
   v01.mandant_id,
   v01.einkaeufer_grp_id,
   CAST(v02.einkaeufer_grp_bez AS VARCHAR(50)) AS einkaeufer_grp_bez
   FROM dbp_view.v_in_l_einkaeufer_grp v01
   INNER JOIN dbp_view.v_in_einkaeufer_grp_spr_zu v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.einkaeufer_grp_id = v02.einkaeufer_grp_id
   WHERE v02.spr_id = 18
   AND v01.aktiv_fg = 1
   AND v01.einkaeufer_grp_id <> '-1'
   AND  (v01.mandant_id <> 1
   OR (v01.mandant_id = 1 AND SUBSTR( v01.einkaeufer_grp_id, 1, 1) = 'S' ))
   ) t1
;