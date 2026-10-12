--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.sortiment_leistung
WHERE art_id IN (SELECT art_id
                 FROM DBP_DATA.sortiment_leistung
                 WHERE art_id IS NOT NULL AND
                       mandant_id = 1 AND
                       kjmo IN (SELECT MIN(b.kjmo) AS kjmo
                                FROM (SELECT MAX(kjwo) AS kjwo
                                      FROM DBP_DATA.art_nielsen_fakten_kjwo
                                      WHERE mandant_id = 1) a
                                JOIN DBP_DATA.tag b
                                  ON a.kjwo = b.kjwo) AND
                       kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
                 GROUP BY 1
                 HAVING COUNT(*) > 1) AND
      kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo
                     WHERE mandant_id = 1) a
               JOIN DBP_DATA.tag b
                 ON a.kjwo = b.kjwo) AND
      gtin IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.sortiment_leistung
WHERE matching_id IN (SELECT matching_id
                      FROM DBP_DATA.sortiment_leistung
                      WHERE kjmo IN (SELECT MIN(b.kjmo) AS kjmo
                                     FROM (SELECT MAX(kjwo) AS kjwo
                                           FROM DBP_DATA.art_nielsen_fakten_kjwo
                                           WHERE mandant_id = 1) a
                                     JOIN DBP_DATA.tag b
                                       ON a.kjwo = b.kjwo) AND
		            mandant_id = 1 AND
                            kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
                      GROUP BY 1
                      HAVING COUNT(*) > 1) AND
      kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo
                     WHERE mandant_id = 1) a
               JOIN DBP_DATA.tag b
                 ON a.kjwo = b.kjwo) AND
      gtin IS NOT NULL AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.sortiment_leistung
WHERE art_id IN (SELECT art_id
                 FROM DBP_DATA.sortiment_leistung
                 WHERE art_id IS NOT NULL AND
                       mandant_id = 1 AND
                       kjmo IN (SELECT MIN(b.kjmo) AS kjmo
                                FROM (SELECT MAX(kjwo) AS kjwo
                                      FROM DBP_DATA.art_nielsen_fakten_kjwo
                                      WHERE mandant_id = 1) a
                                JOIN DBP_DATA.tag b
                                  ON a.kjwo = b.kjwo) AND
                       kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
                 GROUP BY 1
                 HAVING COUNT(*) > 1) AND
      kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo
                     WHERE mandant_id = 1) a
               JOIN DBP_DATA.tag b
                 ON a.kjwo = b.kjwo) AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.sortiment_leistung
WHERE matching_id IN (SELECT matching_id
                      FROM DBP_DATA.sortiment_leistung
                      WHERE kjmo IN (SELECT MIN(b.kjmo) AS kjmo
                                     FROM (SELECT MAX(kjwo) AS kjwo
                                           FROM DBP_DATA.art_nielsen_fakten_kjwo
                                           WHERE mandant_id = 1) a
                                     JOIN DBP_DATA.tag b
                                       ON a.kjwo = b.kjwo) AND
		            mandant_id = 1 AND
                            kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
                      GROUP BY 1
                      HAVING COUNT(*) > 1) AND
      kjmo IN (SELECT MIN(b.kjmo) AS kjmo
               FROM (SELECT MAX(kjwo) AS kjwo
                     FROM DBP_DATA.art_nielsen_fakten_kjwo
                     WHERE mandant_id = 1) a
               JOIN DBP_DATA.tag b
                 ON a.kjwo = b.kjwo) AND
      mandant_id = 1 AND
      kjwo_update IN (SELECT MAX(kjwo_update) AS kjwo_update FROM DBP_DATA.art_kl_preislage_zu_per WHERE mandant_id = 1)
;

