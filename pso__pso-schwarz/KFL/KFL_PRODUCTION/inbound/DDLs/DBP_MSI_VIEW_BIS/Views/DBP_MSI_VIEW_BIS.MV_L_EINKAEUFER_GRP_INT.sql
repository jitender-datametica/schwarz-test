CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_EINKAEUFER_GRP_INT
   -- 17.12.2014: Lookup für Attribut Int. Einkäufergruppe Lieferant. Dieses wird nur als Hilfsattribut für Transaction Service benötigt
   -- Für Repoting wird nur Attribut Einkäufergruppe Lieferant benutzt, welches int. und nat. Einkgr. zusammenfasst in View mv_l_einkaeufer_grp
   -- In der int. Basistabelle gibt es keinen Mandanten
   -- In den Berichten wird von den Attributen her nicht mehr unterschieden, ob es eine nationale Sicht (in_l_einkaeufer_grp)
   -- oder eine Internationale Sicht (in_l_einkaeufer_int) ist.
   -- Es gibt also eine Einkäufergruppe, die sowohl nationale als auch internationale Inhalte hat
   -- Hier wird Mandant 99 erfunden, damit in der Berichts SQL die Daten zusammenfinden
   -- 19.02.2015 twie: Cast von einkaeufer_int_id auf CHAR entfällt weil Quelle jetzt CHAR(3)

   (
   mandant_id
   ,einkaeufer_grp_id
   )
   AS
      -- In der Basistabelle gibt es keinen Mandanten
      -- In den Berichten wird von den Attributen her nicht mehr unterschieden, ob es eine nationale Sicht (in_l_einkaeufer_grp)
      -- oder eine Internationale Sicht (in_l_einkaeufer_int) ist.
      -- Es gibt also eine Einkäufergruppe, die sowohl nationale als auch internationale Inhalte hat
      -- Hier wird Mandant 99 erfunden, damit in der Berichts SQL die Daten zusammenfinden
      SELECT
      99 AS mandant_id,
      einkaeufer_int_id AS einkaeufer_grp_id
     FROM dbp_view.v_in_l_einkaeufer_int
;