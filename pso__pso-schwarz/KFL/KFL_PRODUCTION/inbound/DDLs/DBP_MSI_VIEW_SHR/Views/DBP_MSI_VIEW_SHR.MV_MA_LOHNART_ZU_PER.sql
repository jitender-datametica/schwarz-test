CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_MA_LOHNART_ZU_PER
--bei Umbuchungsstunden können andere Kostenstellen_id auftreten, das wird aus der Stundentabelle entnommen
--20140307-kkaiser-beib Lohnart 2702 werden nur positive Werte übernommen
--20140428 -kkaiser: Für Mandant 1 und Mitarbeiterkreis = 30 UND für Mandant 3 und Mitarbeiterkreis = 09,17,18,19 müssen wir die Stunden der Lohnarten 7712 (Brutto geglättet), 7723 (ungeglättet) und MVST (Sollstunden) durch 2 teilen.
--20140507 -kkaiser: Lohnarten 2702 separieren in 1 Feld mit positiven Werten, eines mit negativen (Freizeitkonto)
--20140512 -kkaiser: Lohnarten 7726 hinzugefügt, "tatsächlichen Vertragsstunden"
(
mandant_id
, mitarbeiter_id
, kjmo
, system_id
, lohnart_id
, kostenstelle_id
, stunden_lohnart_7722
, stunden_lohnart_7712
, stunden_lohnart_7723
, stunden_lohnart_2702_plus
, stunden_lohnart_2702_minus
, stunden_lohnart_7705
, stunden_lohnart_7514
, stunden_lohnart_7515
, stunden_lohnart_7516
, stunden_lohnart_7518
, stunden_lohnart_7517
, stunden_lohnart_7713
, stunden_lohnart_7752
, stunden_lohnart_2704
, stunden_lohnart_MVST
, stunden_lohnart_7726
)
AS

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