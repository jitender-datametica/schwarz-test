--SPEC0312966 

CREATE OR REPLACE TABLE DBP_ETL.PMR_TMP AS (
SELECT
   mandant_id,
   wup_id,
   nb_id,
   art_id,
   --diagnose_id, 
   --dat_prognoselauf,
   dat,
   CASE 
      WHEN normalaktion_fg = 1 THEN 'SA'
      WHEN kdp_fg = 1 THEN 'AF'
      WHEN bby_fg = 1 THEN 'BBY'
   ELSE 'AF' END AS prognose_trennung_cd ,
   CASE 
      WHEN normalaktion_fg = 1 AND bby_fg = 0 AND kdn_fg = 0 AND kdp_fg = 0 THEN 1
      WHEN normalaktion_fg = 1 AND kdn_fg + kdp_fg > 0 THEN 2
      WHEN normalaktion_fg = 1 AND bby_fg = 1 THEN 6
      WHEN kdn_fg = 1 THEN 3
      WHEN kdp_fg = 1 THEN 4
      WHEN bby_fg = 1 THEN 5
   ELSE -1 END AS prognose_feingliederung_id
FROM (
       SELECT
          aawz.mandant_id,
          aawz.wup_id,
          aawz.nb_id,
          aawz.art_id,
          --diagnose_id, 
          --dat_prognoselauf,
          t.dat,
          COUNT(DISTINCT aawz.angebot_nr) AS anz_offers,
          COUNT(DISTINCT a.aktion_id) AS anz_aktion,
          COUNT(DISTINCT a.bonuskauf_id) AS anz_bby,
          --a.dat_angebot_gueltig_von AS dat_von,
          --a.dat_angebot_gueltig_bis AS dat_bis,
          MAX(preis_vk_brutto_aktion) AS max_vk,
          MAX(a.bonuskauf_fg) AS bby_fg,
          MAX(CASE WHEN a.bonuskauf_fg = 0 THEN 1 ELSE 0 END) AS normalaktion_fg,
          MAX(CASE WHEN a.aktion_typ_id = 'KDN' THEN 1 ELSE 0 END) AS kdn_fg,
          MAX(CASE WHEN a.aktion_typ_id = 'KDP' THEN 1 ELSE 0 END) AS kdp_fg
       FROM dbp_data.angebot_art_wup_zu aawz
            JOIN dbp_data.angebot a ON a.angebot_nr = aawz.angebot_nr AND a.mandant_id = aawz.mandant_id
            JOIN dbp_data.tag t ON t.dat BETWEEN a.dat_angebot_gueltig_von AND a.dat_angebot_gueltig_bis
            --JOIN dbp_data.aktion Ak ON a.aktion_id = ak.aktion_id AND a.mandant_id = ak.mandant_id
            --LEFT JOIN dbp_data.l_bonuskauf bby ON a.aktion_id = bby.aktion_id AND a.mandant_id = bby.mandant_id
        --where bby.bonuskauf_id= 1000510
        --WHERE BONUSKAUF_BEDINGUNG_ID is not null
       GROUP BY aawz.mandant_id, aawz.wup_id, aawz.nb_id, aawz.art_id, t.dat
       )
);

UPDATE dbp_data.udf_prognose u
SET u.prognose_trennung_cd = _tmp.prognose_trennung_cd,
    u.prognose_feingliederung_id = _tmp.prognose_feingliederung_id
FROM DBP_ETL.PMR_TMP _tmp 
WHERE _tmp.mandant_id = u.mandant_id
      AND _tmp.wup_id = u.wup_id
      --AND _tmp.nb_id = u.nb_id
      AND _tmp.art_id = u.art_id
      --AND _tmp.diagnose_id = u.diagnose_id
      --AND _tmp.dat_prognoselauf = u.dat_prognoselauf 
      AND _tmp.dat = u.dat
      AND u.dat > CURRENT_DATE
      AND u.dat_prognoselauf = CURRENT_DATE 
      AND _tmp.dat >= CURRENT_DATE 
;

