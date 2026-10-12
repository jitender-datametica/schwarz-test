CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_LIEF_EINKAEUF_GRP_ZU_1
   -- 17.12.2014 Zuordnungstabelle Einkäufergruppe Lieferant zu Lieferant
   -- Zuordung int. Eink.gr zu Lieferant per Transaction Service, wird aus ts Tabelle gelesen
   -- Zuordung nat. Eink.gr zu Lieferant kommt aus SAP Tabelle
   -- beides wird hier zusammengefügt, da Attribut Einkäufergruppe Lieferant die int. und nat. beinhaltet
   -- 19.02.2015 twie: Cast von einkaeufer_int_id auf CHAR entfällt weil Quelle jetzt CHAR(3)
   -- 07.12.2016 twie: SPEC0017788 Lieferanten ohne EKG (entspr. EKG -1) sind nicht beschaffungsrelevant

   (
   lief_mandant_id
   ,in_lief_id
   ,grp_mandant_id
   ,einkaeufer_grp_id
   )
   AS
      SELECT lief_mandant_id,
      in_lief_id,
      grp_mandant_id,
      einkaeufer_grp_id
      FROM
      (
      SELECT v01.mandant_id AS lief_mandant_id,
      v01.in_lief_id,
      99 AS grp_mandant_id,
      COALESCE(v01.einkaeufer_int_id,'-1') AS einkaeufer_grp_id
      FROM dbp_msi_view_bis.ts_einkaeufer_int_lief_zu_1 v01
      ) t0

      UNION

      SELECT lief_mandant_id,
      in_lief_id,
      grp_mandant_id,
      einkaeufer_grp_id
      FROM
      (
      SELECT v01.mandant_id AS lief_mandant_id,
      v01.in_lief_id,
      v01.mandant_id AS grp_mandant_id,
      v01.einkaeufer_grp_id
      FROM dbp_view.v_in_lieferant_ekorg_zu_1 v01
      INNER JOIN dbp_view.v_in_l_ekorg_1 v02
      ON v01.mandant_id = v02.mandant_id
      AND v01.einkaufsorganisation_id = v02.einkaufsorganisation_id
      AND v02.sako_fg = 1
      AND v01.einkaeufer_grp_id IS NOT NULL

      -- Gibt es mehrere Einträge in LFM1_1 (in_lieferant_ekorg_zu_1) zu einem Lieferant
      -- wird klienste EKORG verwendet

      QUALIFY SUM(1) OVER (PARTITION BY v01.mandant_id, v01.in_lief_id ORDER BY v02.einkaufsorganisation_id ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) = 1
      ) t1_1
;