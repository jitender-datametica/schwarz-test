CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_TS_LIEFERANT_INT_2
   -- 26.10.2015 twie: SPEC0003062 Join auf EKORG, damit nur relevante Lieferantenzuordnungen vom Flag angezeigt werden
   -- 07.12.2016 twie: SPEC0017788 Lieferanten ohne EKG (entspr. EKG -1) sind nicht beschaffungsrelevant
   (
   in_lief_id_int
   ,lief_name
   ,hat_lieferant_fg
   )
   AS
      SELECT
      v01.in_lief_id_int,
      v01.lief_name,
      CASE WHEN v02.in_lief_id_int IS NOT NULL THEN 1 ELSE 0 END AS hat_lieferant_fg
      FROM dbp_view.v_in_lieferant_int_2 v01
      LEFT JOIN
      (--prüfen, ob eine_2 Lieferantenzuordung besteht. Nur Zuordnungen zu relevanten Lieferanten beachten.
      --deshalb durch Join auf EKORG Tabellen gleiche Filterung wie im mv_l_in_lieferant_2
      SELECT
      s01.in_lief_id_int
      FROM dbp_view.v_in_lieferant_2 s01
      INNER  JOIN dbp_view.v_in_lieferant_ekorg_zu_2 s02
      ON s01.mandant_id = s02.mandant_id
      AND s01.in_lief_id = s02.in_lief_id
      AND s02.einkaeufer_grp_id IS NOT NULL
      INNER JOIN dbp_view.v_in_l_ekorg_2 s03
      ON s02.mandant_id = s03.mandant_id
      AND s02.einkaufsorganisation_id = s03.einkaufsorganisation_id
      AND s03.sako_fg = 1
      GROUP BY s01.in_lief_id_int
      ) v02
      ON v01.in_lief_id_int = v02.in_lief_id_int
;