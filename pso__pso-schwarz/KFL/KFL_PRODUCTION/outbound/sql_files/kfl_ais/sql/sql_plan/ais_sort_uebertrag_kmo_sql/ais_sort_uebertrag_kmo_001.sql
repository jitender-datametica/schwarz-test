DELETE FROM dbp_data.sortiment_leistung
WHERE art_id IN (SELECT art_id
      FROM dbp_data.sortiment_leistung
      WHERE art_id IS NOT NULL
       AND mandant_id = ${mandant_id}
       AND kjmo IN (SELECT MAX(kjmo) AS kjmo
         FROM dbp_data.art_nielsen_fakten_kjmo
         WHERE mandant_id = ${mandant_id})
       AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
         FROM dbp_data.art_kl_preislage_zu_per
         WHERE mandant_id = ${mandant_id})
      GROUP BY art_id
      HAVING COUNT(*) > 1) AND kjmo IN (SELECT MAX(kjmo) AS kjmo
      FROM dbp_data.art_nielsen_fakten_kjmo
      WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND kjwo_update IN (SELECT MAX(kjwo_update) AS
     kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}) AND gtin IS NOT NULL;


DELETE FROM dbp_data.sortiment_leistung
WHERE matching_id IN (SELECT matching_id
      FROM dbp_data.sortiment_leistung
      WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
         FROM dbp_data.art_nielsen_fakten_kjmo
         WHERE mandant_id = ${mandant_id})
       AND mandant_id = ${mandant_id}
       AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
         FROM dbp_data.art_kl_preislage_zu_per
         WHERE mandant_id = ${mandant_id})
      GROUP BY matching_id
      HAVING COUNT(*) > 1) AND kjmo IN (SELECT MAX(kjmo) AS kjmo
      FROM dbp_data.art_nielsen_fakten_kjmo
      WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND kjwo_update IN (SELECT MAX(kjwo_update) AS
     kjwo_update
    FROM dbp_data.art_kl_preislage_zu_per
    WHERE mandant_id = ${mandant_id}) AND gtin IS NOT NULL;


DELETE FROM dbp_data.sortiment_leistung
WHERE art_id IN (SELECT art_id
     FROM dbp_data.sortiment_leistung
     WHERE art_id IS NOT NULL
      AND mandant_id = ${mandant_id}
      AND kjmo IN (SELECT MAX(kjmo) AS kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id})
      AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id})
     GROUP BY art_id
     HAVING COUNT(*) > 1) AND kjmo IN (SELECT MAX(kjmo) AS kjmo
     FROM dbp_data.art_nielsen_fakten_kjmo
     WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND kjwo_update IN (SELECT MAX(kjwo_update) AS
    kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per
   WHERE mandant_id = ${mandant_id});


DELETE FROM dbp_data.sortiment_leistung
WHERE matching_id IN (SELECT matching_id
     FROM dbp_data.sortiment_leistung
     WHERE kjmo IN (SELECT MAX(kjmo) AS kjmo
        FROM dbp_data.art_nielsen_fakten_kjmo
        WHERE mandant_id = ${mandant_id})
      AND mandant_id = ${mandant_id}
      AND kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update
        FROM dbp_data.art_kl_preislage_zu_per
        WHERE mandant_id = ${mandant_id})
     GROUP BY matching_id
     HAVING COUNT(*) > 1) AND kjmo IN (SELECT MAX(kjmo) AS kjmo
     FROM dbp_data.art_nielsen_fakten_kjmo
     WHERE mandant_id = ${mandant_id}) AND mandant_id = ${mandant_id} AND kjwo_update IN (SELECT MAX(kjwo_update) AS
    kjwo_update
   FROM dbp_data.art_kl_preislage_zu_per
   WHERE mandant_id = ${mandant_id});