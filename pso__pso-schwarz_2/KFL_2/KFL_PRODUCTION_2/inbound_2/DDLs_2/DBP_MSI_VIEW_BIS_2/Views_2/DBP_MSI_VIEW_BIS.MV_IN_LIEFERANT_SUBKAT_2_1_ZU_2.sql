CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_IN_LIEFERANT_SUBKAT_2_1_ZU_2
      -- 11.12.2012 AL initial, EIndeutige Zuordnung von Lieferenat zu ersten Eintrag in der Subkategorie 2
      (
      in_lief_id
      ,mandant_id
      ,subkategorie_2_id


      )
      AS
         SELECT                dt1.in_lief_id,
         dt1.mandant_id,
         COALESCE(subkategorie_2_id, -1) AS subkategorie_2_id
         FROM dbp_view.v_in_lieferant_2 dt1
         LEFT JOIN
         (SELECT mandant_id,
         in_lief_id,
         subkategorie_2_id
        FROM dbp_view.v_in_lieferant_subkat_2_zu_2 dt2
         WHERE subkategorie_2_id <> -1
         QUALIFY sum(1) over (partition by  mandant_id, in_lief_id order by subkategorie_2_id asc
         ROWS BETWEEN UNBOUNDED PRECEDING AND
         CURRENT ROW)=1
         ) dt2
         ON dt1.in_lief_id=dt2.in_lief_id AND
         dt1.mandant_id=dt2.mandant_id;