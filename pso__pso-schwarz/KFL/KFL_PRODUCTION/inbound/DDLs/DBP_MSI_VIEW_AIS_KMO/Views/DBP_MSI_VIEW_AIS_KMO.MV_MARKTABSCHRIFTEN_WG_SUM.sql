CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_MARKTABSCHRIFTEN_WG_SUM
-- INC0563629 Einschränkung auf abschriftart_id > 900 / sschuecke 30.11.2015
(
mandant_id
, wup_id
, nb_id
, abschriftart_id
, wg_id
, arthiertyp_id
, dat
, abschriftbetrag_netto
, abschriftbetrag_brutto
, wrg_id
)
AS
   SELECT
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.abschriftart_id,
   v01.wg_id,
   v01.arthiertyp_id,
   v01.dat,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.abschriftbetrag_netto  ,0)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.abschriftbetrag_netto  ,0) * v300.umrechnungskurs
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.abschriftbetrag_netto  ,0) * v400.umrechnungskurs
             END AS DECIMAL(18,6)) * -1 AS abschriftbetrag_netto,
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE( v01.abschriftbetrag_brutto  ,0)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.abschriftbetrag_brutto  ,0) * v300.umrechnungskurs
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.abschriftbetrag_brutto  ,0) * v400.umrechnungskurs
             END AS DECIMAL(18,6)) * -1 AS abschriftbetrag_brutto,
   v01.wrg_id

  FROM dbp_view.v_marktabschriften_wg_sum v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200

    /*JOIN dbp_view.v_kurs v300
   ON v01.dat BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

    -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs v300
   ON v300.dat_bis = '9999-12-31'
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs v400
   ON v01.dat BETWEEN v400.dat_von AND v400.dat_bis
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   WHERE v01.mandant_id <>1
   AND abschriftart_id > 900;