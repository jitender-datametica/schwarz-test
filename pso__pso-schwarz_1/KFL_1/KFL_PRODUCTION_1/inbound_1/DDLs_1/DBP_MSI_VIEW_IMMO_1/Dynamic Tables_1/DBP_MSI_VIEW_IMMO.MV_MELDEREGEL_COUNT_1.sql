CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MELDEREGEL_COUNT_1(
	MANDANT_ID,
	MV_INTRENO,
	KJMO,
	MELDEREGEL_MAX
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.mv_intreno, v1.kjmo, MAX(melderegel) AS melderegel_max
   --,sum(cast(v1.melderegel AS integer)) AS melderegel_sum
   FROM (
   SELECT
   v1.mandant_id, v1.mv_intreno, v1.kjmo, v1.melderegel, v1.VERSION, v1.rhythmus_art, v1.nullumsatz
   FROM dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_1 v1
   WHERE v1.VERSION=(SELECT MAX(VERSION) FROM dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_1  v2 WHERE v1.mv_intreno=v2.mv_intreno AND v1.kjmo=v2.kjmo AND v1.melderegel=v2.melderegel)

   )
   --dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_1
   v1
   WHERE v1.rhythmus_art='0001' AND v1.nullumsatz <>'X'
   GROUP BY 1,2,3;