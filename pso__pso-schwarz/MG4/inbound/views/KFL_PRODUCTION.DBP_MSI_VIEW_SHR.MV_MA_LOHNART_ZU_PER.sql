create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MA_LOHNART_ZU_PER(
	MANDANT_ID,
	MITARBEITER_ID,
	KJMO,
	SYSTEM_ID,
	LOHNART_ID,
	KOSTENSTELLE_ID,
	STUNDEN_LOHNART_7722,
	STUNDEN_LOHNART_7712,
	STUNDEN_LOHNART_7723,
	STUNDEN_LOHNART_2702_PLUS,
	STUNDEN_LOHNART_2702_MINUS,
	STUNDEN_LOHNART_7705,
	STUNDEN_LOHNART_7514,
	STUNDEN_LOHNART_7515,
	STUNDEN_LOHNART_7516,
	STUNDEN_LOHNART_7518,
	STUNDEN_LOHNART_7517,
	STUNDEN_LOHNART_7713,
	STUNDEN_LOHNART_7752,
	STUNDEN_LOHNART_2704,
	STUNDEN_LOHNART_MVST,
	STUNDEN_LOHNART_7726
) as

   SELECT
   v01.mandant_id, v01.mitarbeiter_id, v01.kjmo, v01.system_id, v01.lohnart_id, CASE WHEN V01.lohnart_id = '2704' THEN v01.kostenstelle_id ELSE v02.kostenstelle_id  END AS kostenstelle_id, CASE WHEN V01.lohnart_id = '7722' THEN v01.stunden_lohnart ELSE NULL END AS stunden_lohnart_7722, CASE WHEN V01.lohnart_id = '7712' AND ((v01.mandant_id = 1 AND v03.mitarbeiter_kreis_id = '30') OR  (v01.mandant_id = 3 AND v03.mitarbeiter_kreis_id IN ('09','17','18','19')) )
   THEN TRUNC( v01.stunden_lohnart / 2)
   WHEN V01.lohnart_id = '7712' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7712, CASE WHEN V01.lohnart_id = '7723' AND ((v01.mandant_id = 1 AND v03.mitarbeiter_kreis_id = '30') OR  (v01.mandant_id = 3 AND v03.mitarbeiter_kreis_id IN ('09','17','18','19')) )
   THEN TRUNC( v01.stunden_lohnart / 2)
   WHEN V01.lohnart_id = '7723' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7723, CASE WHEN V01.lohnart_id = '2702' AND  v01.stunden_lohnart > 0 THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_2702_plus, CASE WHEN V01.lohnart_id = '2702' AND  v01.stunden_lohnart < 0 THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_2702_minus, CASE WHEN V01.lohnart_id = '7705' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7705, CASE WHEN V01.lohnart_id = '7514' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7514, CASE WHEN V01.lohnart_id = '7515' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7515, CASE WHEN V01.lohnart_id = '7516' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7516, CASE WHEN V01.lohnart_id = '7518' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7518, CASE WHEN V01.lohnart_id = '7517' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7517, CASE WHEN V01.lohnart_id = '7713' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7713, CASE WHEN V01.lohnart_id = '7752' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7752, CASE WHEN V01.lohnart_id = '2704' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_2704, CASE WHEN V01.lohnart_id = 'MVST' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_MVST, CASE WHEN V01.lohnart_id = '7726' THEN v01.stunden_lohnart ELSE NULL  END AS stunden_lohnart_7726

   FROM dbp_view.v_ma_lohnart_zu_per v01
   LEFT OUTER JOIN dbp_view.v_ma_kostenstelle_zu_per v02
   ON V01.mandant_id = V02.mandant_id
   AND V01.mitarbeiter_id = V02.mitarbeiter_id
   AND V01.kjmo = V02.kjmo
   LEFT OUTER JOIN dbp_view.v_ma_kreis_zu_per v03
   ON V01.mandant_id = V03.mandant_id
   AND V01.mitarbeiter_id = V03.mitarbeiter_id
   AND V01.kjmo = V03.kjmo  ;