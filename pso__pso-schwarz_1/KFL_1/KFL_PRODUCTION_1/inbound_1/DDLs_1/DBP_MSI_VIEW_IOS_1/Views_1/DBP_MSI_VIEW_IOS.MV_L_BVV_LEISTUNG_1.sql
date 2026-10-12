CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_BVV_LEISTUNG_1 AS
   SELECT bvv_leist_id, psp_end_nr, psp_end_nr AS bvv_gewerk_id, 
   /*Untergewerk Zuordnung*/
   CASE 
    --Infrastrukturmassnahmen
    WHEN bvv_leist_id BETWEEN 7 AND 11 THEN 7 
    -- Erschliessungsmassnahmen / Anschlusskosten
    WHEN bvv_leist_id BETWEEN 12 AND 17 THEN 12 
    -- Baukosten / Gebaeude
    WHEN bvv_leist_id = 993 OR bvv_leist_id BETWEEN 18 AND 85 OR bvv_leist_id BETWEEN 300 AND 399 THEN 18 
    -- Baunebenkosten
    WHEN bvv_leist_id = 994 OR bvv_leist_id BETWEEN 87 AND 123 OR bvv_leist_id BETWEEN 400 AND 499 THEN 87  
    -- Einrichtung Ladenbau
    WHEN bvv_leist_id = 995 OR bvv_leist_id BETWEEN 125 AND 158 OR bvv_leist_id BETWEEN 500 AND 699 THEN 158 
    -- Kaelte/Kuehlung
    WHEN bvv_leist_id = 996 OR bvv_leist_id BETWEEN 159 AND 162 OR bvv_leist_id BETWEEN 700 AND 799 THEN 159 
    -- IT/Kassen
    WHEN bvv_leist_id = 997 OR bvv_leist_id BETWEEN 163 AND 165 OR bvv_leist_id BETWEEN 800 AND 990 THEN 163 
    -- Entwicklungs-/Beratungskosten
    WHEN bvv_leist_id IN (3,991) OR bvv_leist_id BETWEEN 166 AND 199 THEN 3 
    -- Erwerbskosten Grundstueck/Gebaeude
    WHEN bvv_leist_id IN (5,992) OR bvv_leist_id BETWEEN 200 AND 299 THEN 5
    -- Sonstiges (normalfall nur 1 und 2 )
    ELSE bvv_leist_id 
   END bvv_u_gewerk_id, 
   /*Immobilie / Mobilie Zuordnung*/
   CASE 
    -- Kosten ausserhalb der Immobilie
    WHEN bvv_leist_id IN (991,992) OR bvv_leist_id BETWEEN 1 AND 5 OR bvv_leist_id BETWEEN 166 AND 299 THEN 1
    -- Immobilie
    WHEN bvv_leist_id IN (993,994) OR bvv_leist_id BETWEEN 7 AND 123 OR bvv_leist_id BETWEEN 300 AND 499 THEN 7
    -- Mobilie
    WHEN bvv_leist_id IN (995,996,997) OR bvv_leist_id BETWEEN 125 AND 165 OR bvv_leist_id BETWEEN 500 AND 990 THEN 125
    ELSE bvv_leist_id 
   END bvv_immo_mob_id, 
   /*Untergewerk Summe Zuordnung*/
   CASE 
    -- Infrastruktur
    WHEN bvv_leist_id BETWEEN 7 AND 17 THEN 1
    -- Baukosten/Gebaeude
    WHEN bvv_leist_id = 993 OR bvv_leist_id BETWEEN 18 AND 85 OR bvv_leist_id BETWEEN 300 AND 399 THEN 2
    -- Baunebenkosten
    WHEN bvv_leist_id = 994 OR bvv_leist_id BETWEEN 87 AND 123 OR bvv_leist_id BETWEEN 400 AND 499 THEN 3
    -- Einrichtung Ladenbau
    WHEN bvv_leist_id = 995 OR bvv_leist_id BETWEEN 125 AND 158 OR bvv_leist_id BETWEEN 500 AND 699 THEN 4
    -- Erwerbskosten Grundstueck/Gebaeude
    WHEN bvv_leist_id IN (5,992) OR bvv_leist_id BETWEEN 200 AND 299 THEN 5
    -- Entwicklungs-/Beratungskosten
    WHEN bvv_leist_id = 991 OR bvv_leist_id BETWEEN 1 AND 3 OR bvv_leist_id BETWEEN 166 AND 199 THEN 6
    -- Kaelte/Kuehlung
    WHEN bvv_leist_id = 996 OR bvv_leist_id BETWEEN 159 AND 162 OR bvv_leist_id BETWEEN 700 AND 799 THEN 7
    -- IT/Kassen
    WHEN bvv_leist_id = 997 OR bvv_leist_id BETWEEN 163 AND 165 OR bvv_leist_id BETWEEN 800 AND 999 THEN 8
    ELSE bvv_leist_id 
   END bvv_u_gewerk_summe_id
   FROM dbp_view.v_l_bvv_leistung_1;