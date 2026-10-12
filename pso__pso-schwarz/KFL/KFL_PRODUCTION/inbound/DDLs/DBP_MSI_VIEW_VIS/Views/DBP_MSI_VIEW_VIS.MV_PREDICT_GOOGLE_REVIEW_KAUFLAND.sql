CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PREDICT_GOOGLE_REVIEW_KAUFLAND(
	GOOGLE_PLACE_ID,
	KJMO,
	MANDANT_ID,
	WUP_ID,
	PREDICT_REVIEW_COUNT,
	PREDICT_RATING_AVG
) AS

	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
	
SELECT
 pgr.google_place_id
 , pgr.kjmo
 , pgr.mandant_id
 , wup.aktuell_wup_id 																AS wup_id
 , pgr.predict_review_count
 , pgr.predict_rating_avg
FROM dbp_view.v_predict_google_review_kaufland pgr

INNER JOIN dbp_view.v_wup wup
ON pgr.mandant_id = wup.mandant_id AND pgr.wup_id = wup.wup_id
;