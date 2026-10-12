CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_ZEK
-- Filter auf zek_id > 000 und wbl_id > 000 wurde entfernt, damit Umsätze im VS Cockpit enthalten sind.
-- In anderen Sichten wird zek_id im Dataset herausgefiltert / sschuecke 13.12.2018
(
mandant_id
,zek_id
,wbl_id
,zek_id_lang
,zek_name
,zek_id_lang_name
)
AS
   SELECT
    v01.mandant_id
   ,v01.zek_id
   ,v01.wbl_id
    -- Anpassung bisherige Logik mit FM000 aufgrund Änderung Spalte zek_id zu Textfeld - AP0172759/SPEC0207789 sschuecke 01.09.2023
  ,CASE WHEN (TRY_TO_NUMBER(v01.zek_id)::VARCHAR) IS NULL OR TRY_TO_NUMBER(v01.zek_id)::VARCHAR != zek_id  THEN zek_id
                            ELSE TO_VARCHAR(TRY_TO_NUMBER(v01.zek_id), 'FM000')
                            END AS zek_id_lang
   ,v01.zek_name
   ,zek_id_lang || ' ' || v01.zek_name zek_id_lang_name

   FROM dbp_view.v_zek v01;