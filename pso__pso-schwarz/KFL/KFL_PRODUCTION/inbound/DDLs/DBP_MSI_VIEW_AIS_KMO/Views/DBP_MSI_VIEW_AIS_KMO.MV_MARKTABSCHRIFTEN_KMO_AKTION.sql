CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_MARKTABSCHRIFTEN_KMO_AKTION
-- Aufnahme Filterung aktion_relevant_fg =1 lt. Mail vom 01.02.2018 S. Gross / sschuecke 01.02.2018
(
wup_id
, nb_id
, aktion_id
, mandant_id
, dat
, art_id
, menge_abschrift
, abschriftbetrag_netto
, abschriftbetrag_brutto
, wrg_id
)
AS
   SELECT
   v01.wup_id,
   v01.nb_id,
   v01.aktion_id,
   v01.mandant_id,
   v01.dat,
   v01.art_id,
   v01.menge_abschrift,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST (CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.abschriftbetrag_netto, 0)
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.abschriftbetrag_netto, 0) * v300.umrechnungskurs
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.abschriftbetrag_netto, 0) * v400.umrechnungskurs
              END AS DECIMAL(18,8))  AS abschriftbetrag_netto,
   CAST (CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.abschriftbetrag_brutto, 0)
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.abschriftbetrag_brutto, 0) * v300.umrechnungskurs
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.abschriftbetrag_brutto, 0) * v400.umrechnungskurs
              END AS DECIMAL(18,8))  AS abschriftbetrag_brutto,
   wrg_id

  FROM dbp_view.v_marktabschriften_kmo_aktion v01

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200

    /*JOIN dbp_view.v_kurs v300
   ON CURRENT_DATE BETWEEN v300.dat_von AND v300.dat_bis
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

    -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs v300
   ON v300.dat_bis = '9999-12-31'
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs v400
   ON v01.dat BETWEEN v400.dat_von AND v400.dat_bis
   AND v100.default_wrg = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   WHERE v01.mandant_id > 1
   AND aktion_relevant_fg = 1;