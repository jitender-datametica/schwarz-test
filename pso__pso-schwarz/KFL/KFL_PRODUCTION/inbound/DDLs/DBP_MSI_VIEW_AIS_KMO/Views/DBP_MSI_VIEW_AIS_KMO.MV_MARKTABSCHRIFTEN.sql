CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_MARKTABSCHRIFTEN
--  AL 22.03.2012 Anpassung INNER JOIN auf LEFT JOIN bei art_gp_nm_zu_per
-- AL  26.03.2012 Teilen Menge durch 1000 bei Gewichtsartikel (in der Beladung wird mit 1000 multipliziert)
-- Awol 21.06.12: Join auf bei art_gp_nm_zu_per angepasst. AND v01.mandant_id = v02.mandant_id
-- Awol 13.03.13: Where Bedingung von "v01.abschriftart_id BETWEEN 933 AND 994" auf "v01.abschriftart_id BETWEEN 905 AND 994" geändert. S. Mail Frau Winter 11.03.13
(
mandant_id
, wup_id
, wup_abschrift_id
, positionsnummer
, abschriftart_id
, nb_id
, dat
, woche_id
, absch_menge
, art_id
, lastupd_dat
, abschriftbetrag_netto
, abschriftbetrag_brutto
, gp_id
, posten_kz_per
)
AS
   SELECT
   v01.mandant_id,
   v01.wup_id,
   v01.wup_abschrift_id,
   v01.positionsnummer_id,
   v01.abschriftart_id,
   v01.nb_id,
   v01.dat,
   v01.woche_id,
   CASE
   WHEN v01.gewart_id = 'KG' THEN CAST (v01.menge_abschrift  AS DECIMAL(13,4))/ 1000
   ELSE CAST(v01.menge_abschrift AS DECIMAL(13,4))
   END  * -1,
   v01.art_id,
   v01.lastupd_dat,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(
  CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.abschriftbetrag_netto  ,0)
       WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id =0 THEN COALESCE(v01.abschriftbetrag_netto  ,0) * v01.umrechnungskurs_0
       WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id =1 THEN COALESCE(v01.abschriftbetrag_netto  ,0) * v01.umrechnungskurs_1
       END AS DECIMAL(18,6)) * -1 AS abschriftbetrag_netto,
  CAST(
  CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE( v01.abschriftbetrag_brutto  ,0)
       WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id =0 THEN COALESCE(v01.abschriftbetrag_brutto  ,0) * v01.umrechnungskurs_0
       WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id =1 THEN COALESCE(v01.abschriftbetrag_brutto  ,0) * v01.umrechnungskurs_1
       END AS DECIMAL(18,6)) * -1 AS abschriftbetrag_brutto,
   COALESCE(v01.gp_id, -1),
  -- AP0273934/SPEC0323992 Aufnahme Posten_id / sschuecke 10.10.2025
  v01.posten_kz_per
  FROM DBP_MSI_VIEW_AIS_KMO.TBL_MV_MARKTABSCHRIFTEN v01
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200;