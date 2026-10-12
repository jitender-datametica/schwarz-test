CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_EINKAEUFER_GRP_2
   -- 17.12.2014: Lookup für Attribut Einkäufergruppe Lieferant. Dieses fasst nat. und int. Eink.gruppen zusammen aus 2 Tabellen.
   -- In der int. Basistabelle gibt es keinen Mandanten
   -- In den Berichten wird von den Attributen her nicht mehr unterschieden, ob es eine_2 nationale Sicht (in_l_einkaeufer_grp_2)
   -- oder eine_2 Internationale Sicht (in_l_einkaeufer_int_2) ist.
   -- Es gibt also eine_2 Einkäufergruppe, die sowohl nationale als auch internationale Inhalte hat
   -- Hier wird Mandant_2 99 erfunden, damit in der Berichts SQL die Daten zusammenfinden
   -- 19.02.2015 twie: für Mandant_2 1 nur Eink.gruppen ausgeben, die mit 'S' beginnen.
   --  Cast von einkaeufer_int_id auf CHAR entfällt weil Quelle jetzt CHAR(3)
   -- 09.11.2015 twie: auf aktive EKGR filtern (aktiv_fg = 0 sind im SAP gelöscht)
   -- 20.09.2016 twie: SPEC0014806 Dummy_2 EKGR - 1für DE ausgeben
   -- 06.12.2016 twie: SPEC0017788 EKGR -1 für alle Länder ausschließen, zugeordnete Lieferanten sind nicht beschaffungsrelevant

   (
   mandant_id
   ,einkaeufer_grp_id
   )
   AS

      SELECT mandant_id,
      einkaeufer_grp_id
      FROM
      (

      SELECT
      99 AS mandant_id,
      einkaeufer_int_id AS einkaeufer_grp_id
      FROM dbp_view.v_in_l_einkaeufer_int_2
      ) t0

      UNION

      SELECT mandant_id,
      einkaeufer_grp_id
      FROM
      (
      SELECT
      v01.mandant_id,
      v01.einkaeufer_grp_id
      FROM dbp_view.v_in_l_einkaeufer_grp_2 v01
      WHERE v01.aktiv_fg = 1
      AND einkaeufer_grp_id <> '-1'
      AND (v01.mandant_id <> 1
      OR (v01.mandant_id = 1 AND SUBSTR( v01.einkaeufer_grp_id, 1, 1) = 'S' ))
      ) t1_2
;