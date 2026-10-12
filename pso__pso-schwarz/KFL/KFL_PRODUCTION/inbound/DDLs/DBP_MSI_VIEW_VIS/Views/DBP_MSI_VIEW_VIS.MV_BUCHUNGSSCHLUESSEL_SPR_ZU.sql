CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BUCHUNGSSCHLUESSEL_SPR_ZU as

   SELECT DISTINCT
   buchungsschluessel_id, MAX(CASE WHEN spr_id =  22 THEN buchungsschluessel_bez END) AS buchungsschluessel_bez                 -- standard == DE
   , MAX(CASE WHEN spr_id =  22 THEN buchungsschluessel_bez END) AS buchungsschluessel_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN buchungsschluessel_bez END), buchungsschluessel_bez_de) AS buchungsschluessel_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN buchungsschluessel_bez END), buchungsschluessel_bez_de) AS buchungsschluessel_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN buchungsschluessel_bez END), buchungsschluessel_bez_de) AS buchungsschluessel_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN buchungsschluessel_bez END), buchungsschluessel_bez_de) AS buchungsschluessel_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN buchungsschluessel_bez END), buchungsschluessel_bez_de) AS buchungsschluessel_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN buchungsschluessel_bez END), buchungsschluessel_bez_de) AS buchungsschluessel_bez_bg    -- BG


   FROM DBP_V_ODS.v_buchungsschluessel_spr_zu

   Group by buchungsschluessel_id;