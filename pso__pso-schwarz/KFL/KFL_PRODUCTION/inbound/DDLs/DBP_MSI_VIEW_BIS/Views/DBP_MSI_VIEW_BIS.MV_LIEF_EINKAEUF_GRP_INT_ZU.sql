CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_LIEF_EINKAEUF_GRP_INT_ZU
-- 17.12.2014 Zuordnungstabelle Int. Einkäufergruppe Lieferant zu Lieferant
-- beinhaltet alle Lieferanten und ggf. deren Zugehörigkeit zu Int. Einkäufergruppe
-- benötigt u.a. in Pflegebericht Zuordnung Lieferant zu Int. Einkäufergruppe
-- Nicht für Reporting, da wird nur das Attribut Einkäufergruppe Lieferant verwendet welches int. und nat. zusammenfasst
-- und eine eigene Zuordnungsstabelle zu Lieferant hat: mv_lief_einkaeuf_grp_zu
-- 19.02.2015 twie: Cast von einkaeufer_int_id auf CHAR entfällt weil Quelle jetzt CHAR(3)
-- 07.12.2016 twie: SPEC0017788 Lieferanten ohne nat. EKG (entspr. EKG -1) sind nicht beschaffungsrelevant

(
lief_mandant_id
,in_lief_id
,grp_mandant_id
,einkaeufer_grp_id
)
AS
   SELECT  v01.mandant_id AS lief_mandant_id,
   v01.in_lief_id,
   99 AS grp_mandant_id,
   COALESCE(v04.einkaeufer_int_id,'-1')  AS einkaeufer_grp_id
   FROM dbp_view.v_in_lieferant v01
   INNER JOIN dbp_view.v_in_lieferant_ekorg_zu v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.in_lief_id = v02.in_lief_id
   AND v02.einkaeufer_grp_id IS NOT NULL
   INNER JOIN dbp_view.v_in_l_ekorg v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.einkaufsorganisation_id = v03.einkaufsorganisation_id
   AND v03.sako_fg=1
   LEFT JOIN dbp_msi_view_bis.ts_einkaeufer_int_lief_zu v04
   ON v01.mandant_id = v04.mandant_id
   AND v01.in_lief_id = v04.in_lief_id

   -- Gibt es mehrere Einträge in LFM1 (in_lieferant_ekorg_zu) zu einem Lieferant
   -- wird kleinste EKORG verwendet
   QUALIFY SUM(1) OVER (PARTITION BY v01.mandant_id, v01.in_lief_id ORDER BY v02.einkaufsorganisation_id ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) =1
;