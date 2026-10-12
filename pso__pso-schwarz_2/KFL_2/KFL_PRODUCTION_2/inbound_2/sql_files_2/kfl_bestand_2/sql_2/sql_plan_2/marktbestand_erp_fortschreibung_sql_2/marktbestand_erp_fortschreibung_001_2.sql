
--translated statement
DELETE FROM DBP_DATA.marktbestand_erp_2
WHERE dat = CURRENT_DATE- ${LOOP_ID}
AND fortschreibung_fg = 1;


--translated statement
INSERT INTO DBP_DATA.marktbestand_erp_2
(
      mandant_id ,
      art_id ,
      wup_id ,
      nb_id ,
      dat ,
      bestand_id ,
      bezugsweg_id ,
      relevant_fg ,
      menge_lgbest_erp_frei_bme,
      menge_lgbest_erp_qual_bme,
      menge_lgbest_erp_gesp_bme,
      fortschreibung_fg,
      td_insert,
      td_update
)
SELECT
      mandant_id ,
      art_id ,
      wup_id ,
      nb_id ,
      CURRENT_DATE- ${LOOP_ID} as dat ,
      bestand_id ,
      bezugsweg_id ,
      relevant_fg ,
      menge_lgbest_erp_frei_bme,
      menge_lgbest_erp_qual_bme,
      menge_lgbest_erp_gesp_bme,
      1 fortschreibung_fg,
      CURRENT_TIMESTAMP td_insert, 
      CURRENT_TIMESTAMP td_update
FROM DBP_DATA.marktbestand_erp_2
WHERE dat = CURRENT_DATE- ${LOOP_ID} - 1
AND (mandant_id, art_id, wup_id) NOT IN 
(SELECT mandant_id, art_id, wup_id FROM DBP_DATA.marktbestand_erp_2 WHERE dat = CURRENT_DATE- ${LOOP_ID});

