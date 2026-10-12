CREATE OR REPLACE VIEW DBP_VIEW.V_ART_ART_GRUPPE_FLW_2
AS
SELECT
mandant_id
,art_id
,art_gruppe_id
,art_gruppe_bez
,art_klasse_id
,art_klasse_bez
,art_rohstoff_id
,art_rohstoff_bez
FROM dbp_data.art_art_gruppe_flw_2;