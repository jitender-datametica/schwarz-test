--update latest entry in art_auslieferungsgruppe_per by setting valid-until-date to day before, 
--in case the article no longer exists in sap table zlf_auslfel, thus marking it as no longer being valid
UPDATE dbp_data.art_auslieferungsgruppe_per a 
FROM (
    SELECT a1.* 
    FROM dbp_data.art_auslieferungsgruppe_per a1 
    LEFT JOIN dbp_etl.DEBUG_prod_stammdaten_zusatz_art_auslieferungsgruppe_per d1 
    USING (mandant_id, art_id) 
    WHERE d1.art_id IS NULL AND a1.dat_bis >= current_date 
    QUALIFY RANK() OVER (PARTITION BY a1.mandant_id, a1.art_id ORDER BY a1.td_update DESC) = 1
) upd
SET a.dat_bis = current_date - 1 
WHERE a.mandant_id = upd.mandant_id 
AND a.art_id = upd.art_id
AND a.dat_von = upd.dat_von
AND a.dat_bis = upd.dat_bis;
