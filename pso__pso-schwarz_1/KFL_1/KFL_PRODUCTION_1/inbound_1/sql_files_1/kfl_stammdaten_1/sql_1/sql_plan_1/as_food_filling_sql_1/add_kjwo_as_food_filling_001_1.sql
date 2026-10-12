
UPDATE dbp_data.as_food_det_1
SET kjwo = b.kjwo
FROM dbp_data.woche_kj_kl_1 b
WHERE dbp_data.as_food_det.kjwo_kl = b.kjwo_kl;

-- Remove duplicate rows (mandant_id,wup_id,nb_id,art_id,dat_auslistung,phase_id,kjwo) and keep only 1 row for each tuple, with sum of the values
DROP TABLE IF EXISTS dbp_etl.as_food_duplicate_kjwo_1;
CREATE TABLE dbp_etl.as_food_duplicate_kjwo_1 AS
SELECT art_id
                ,mandant_id
                ,nb_id
                ,wup_id
                ,dat_auslistung
                ,phase_id
                ,kjwo
                ,max(kjwo_kl) as kjwo_kl
    ,max(phase_wo) as phase_wo
                ,max(phase_vk_brutto) as phase_vk_brutto
                ,max(phase_vk_netto) as phase_vk_netto
                ,sum(menge_totalabschrift) as menge_totalabschrift
                ,sum(betrag_totalabschrift_netto) as betrag_totalabschrift_netto
                ,sum(menge_preisabschrift) as menge_preisabschrift
                ,sum(betrag_preisabschrift_netto) as betrag_preisabschrift_netto
                ,sum(menge_endbestand_phase) as menge_endbestand_phase
                ,sum(menge_absatz) as menge_absatz
                ,sum(umsatz_netto) as umsatz_netto
FROM dbp_data.as_food_det_1
WHERE (
                                mandant_id
                                ,wup_id
                                ,nb_id
                                ,art_id
                                ,dat_auslistung
                                ,phase_id
                                ,kjwo
                                ) IN (
                                SELECT mandant_id
                                                ,wup_id
                                                ,nb_id
                                                ,art_id
                                                ,dat_auslistung
                                                ,phase_id
                                                ,kjwo
                                FROM dbp_data.as_food_det_1
                                GROUP BY mandant_id
                                                ,wup_id
                                                ,nb_id
                                                ,art_id
                                                ,dat_auslistung
                                                ,phase_id
                                                ,kjwo
                                HAVING count(1) > 1
                                )
GROUP BY mandant_id
                ,wup_id
                ,nb_id
                ,art_id
                ,dat_auslistung
                ,phase_id
                ,kjwo;

DELETE FROM dbp_data.as_food_det_1
WHERE (
                                mandant_id
                                ,wup_id
                                ,nb_id
                                ,art_id
                                ,dat_auslistung
                                ,phase_id
                                ,kjwo
                                ) IN (
                                SELECT mandant_id
                                                ,wup_id
                                                ,nb_id
                                                ,art_id
                                                ,dat_auslistung
                                                ,phase_id
                                                ,kjwo
                                FROM dbp_etl.as_food_duplicate_kjwo_1
                                );

INSERT INTO dbp_data.as_food_det_1 (
                art_id
                ,mandant_id
                ,nb_id
                ,wup_id
                ,dat_auslistung
                ,phase_id
                ,kjwo
                ,kjwo_kl
                ,phase_wo
                ,phase_vk_brutto
                ,phase_vk_netto
                ,menge_totalabschrift
                ,betrag_totalabschrift_netto
                ,menge_preisabschrift
                ,betrag_preisabschrift_netto
                ,menge_endbestand_phase
                ,menge_absatz
                ,umsatz_netto
                )
SELECT art_id
                ,mandant_id
                ,nb_id
                ,wup_id
                ,dat_auslistung
                ,phase_id
                ,kjwo
                ,kjwo_kl
                ,phase_wo
                ,phase_vk_brutto
                ,phase_vk_netto
                ,menge_totalabschrift
                ,betrag_totalabschrift_netto
                ,menge_preisabschrift
                ,betrag_preisabschrift_netto
                ,menge_endbestand_phase
                ,menge_absatz
                ,umsatz_netto
FROM dbp_etl.as_food_duplicate_kjwo_1;
COMMIT;
