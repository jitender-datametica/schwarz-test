CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PREDICT_GOOGLE_REVIEW_COMPETITORS_2
(
	GOOGLE_PLACE_ID,
	KJMO,
	PREDICT_REVIEW_COUNT,
	PREDICT_RATING_AVG
) AS
SELECT
  google_place_id
 ,kjmo
 ,predict_review_count
 ,predict_rating_avg
FROM dbp_view.v_predict_google_review_competitors_2;