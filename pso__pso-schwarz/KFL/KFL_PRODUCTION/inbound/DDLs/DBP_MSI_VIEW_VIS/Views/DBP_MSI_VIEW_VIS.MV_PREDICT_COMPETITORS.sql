CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PREDICT_COMPETITORS
(
	GOOGLE_PLACE_ID,
	MANDANT_ID,
	COMPETITOR_NAME,
	WUP_NAME,
	WUP_STR,
	WUP_STANDORT,
	LAENGENGRAD,
	BREITENGRAD
) AS
SELECT
  google_place_id
 ,mandant_id
 ,competitor_name
 ,dbp_process.Transcriptc(wup_name) AS wup_name
 ,dbp_process.Transcriptc(wup_str) AS wup_str
 ,wup_standort
 ,laengengrad
 ,breitengrad
FROM dbp_view.v_predict_competitors;