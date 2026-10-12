--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.ma_hier_eb_fkt_wup_zu_per_2
WHERE ma_hierarchie_typ_id = 1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.ma_hier_eb_fkt_wup_zu_per_2
(
  mandant_id,
  ma_hierarchie_typ_id,
  ma_hierarchie_id,
  dat_von,
  ma_funktion_id,
  ma_hierarchie_ebene_id,
  wup_id
)
SELECT
  mandant_id,
  ma_hierarchie_typ_id,
  ma_hierarchie_id,
  dat_von,
  ma_funktion_id,
  ma_hierarchie_ebene_id,
  wup_id
FROM ${TEMP_TABLE} /*DBP_ETL.ma_hier_eb_fkt_wup_zu_per_temp*/
;

