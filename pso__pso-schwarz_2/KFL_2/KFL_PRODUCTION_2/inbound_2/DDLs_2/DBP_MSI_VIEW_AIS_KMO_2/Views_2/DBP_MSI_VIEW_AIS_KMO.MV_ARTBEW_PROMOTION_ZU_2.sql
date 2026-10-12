CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTBEW_PROMOTION_ZU_2
-- Anfo #592827 Erweiterung Feld menge_promo, umsatz_promo_netto, umsatz_mwst; sschuecke 18.07.2014
-- 20160610 kkaiser: Zeilen unter -- Ermittlung EK netto2 und EK netto3:
--                                                            AND v01.wup_id = v04.wup_id
--                                                            AND v01.nb_id = v04.nb_id  entfernt, Fehlerkorrektur
-- INC0795721 Daten kommen bereits in Landeswährung, daher Änderung der Umrechnung auf wrg_typ_id = 0; sschuecke 06.07.2016
-- Erweiterung Join auf artbew_2, um gp_id zu ermitteln; sschuecke 07.07.2016
-- Einschränkung auf promo_fg = 1, um Verdopplungen zu vermeiden; sschuecke 15.07.2016

(
 art_id
,mandant_id
,wup_id
,nb_id
,dat
,bonuskauf_id
,konditionsart_id
,ean_kasse
,wrg_id
,betrag_promo_netto
,betrag_promo_netto_abgleich
,betrag_mwst
,betrag_mwst_abgleich
,umsatz_promo_netto
,umsatz_mwst
,menge_promo
,ek_netto2_promo
,ek_netto4_promo
,umrechnungskurs
)
AS

   SELECT
   v01.art_id,
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.dat,
   COALESCE(v02.bonuskauf_id , '-1'),
   v01.konditionsart_id,
   v01.ean_kasse,
   v01.wrg_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST (CASE
   WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.betrag_promo_netto, 0)
   WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.betrag_promo_netto, 0) * v300.umrechnungskurs
   WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.betrag_promo_netto, 0) * v400.umrechnungskurs
   END AS DECIMAL(18,8))  AS betrag_promo_netto,
   /*CAST (CASE
   WHEN v03.dat IS NOT NULL THEN COALESCE(v01.betrag_promo_netto, 0)
   END AS DECIMAL(18,8)) AS betrag_promo_netto_abgleich,*/
   CAST (CASE
   WHEN v03.dat IS NOT NULL AND v200.wrg_typ_id = 1 THEN COALESCE(v01.betrag_promo_netto, 0)
   WHEN v03.dat IS NOT NULL AND v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.betrag_promo_netto, 0) * v300.umrechnungskurs
   WHEN v03.dat IS NOT NULL AND v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.betrag_promo_netto, 0) * v400.umrechnungskurs
   END AS DECIMAL(18,8)) AS betrag_promo_netto_abgleich,
   CAST (CASE
   WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.betrag_mwst, 0)
   WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.betrag_mwst, 0) * v300.umrechnungskurs
   WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.betrag_mwst, 0) * v400.umrechnungskurs
   END AS DECIMAL(18,8)) AS betrag_mwst,
   /*CAST (CASE
   WHEN v03.dat IS NOT NULL THEN COALESCE(v01.betrag_mwst, 0)
   END AS DECIMAL(18,8)) AS betrag_mwst_abgleich,*/
   CAST (CASE
   WHEN v03.dat IS NOT NULL AND v200.wrg_typ_id = 1 THEN COALESCE(v01.betrag_mwst, 0)
   WHEN v03.dat IS NOT NULL AND v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.betrag_mwst, 0) * v300.umrechnungskurs
   WHEN v03.dat IS NOT NULL AND v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.betrag_mwst, 0) * v400.umrechnungskurs
   END AS DECIMAL(18,8)) AS betrag_mwst_abgleich,
   CAST (CASE
   WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.umsatz_promo_netto, 0)
   WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.umsatz_promo_netto, 0) * v300.umrechnungskurs
   WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.umsatz_promo_netto, 0) * v400.umrechnungskurs
   END AS DECIMAL(18,8))  AS umsatz_promo_netto,
   CAST (CASE
   WHEN v200.wrg_typ_id  = 1 THEN COALESCE(v01.umsatz_mwst, 0)
   WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.umsatz_mwst, 0) * v300.umrechnungskurs
   WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.umsatz_mwst, 0) * v400.umrechnungskurs
   END AS DECIMAL(18,8))  AS umsatz_mwst,
   v01.menge_promo,
   CAST(v05.ek_nettonetto * v01.menge_promo AS DECIMAL(18,8)) AS  ek_netto2_promo,
   CAST(v05.einstandspreis * v01.menge_promo AS DECIMAL(18,8)) AS ek_netto4_promo,
   v01.umrechnungskurs

   FROM DBP_DATA.ARTBEW_PROMOTION_ZU_2  v01

   JOIN DBP_DATA.MANDANT_2 v100
   ON  v01.mandant_id = v100.mandant_id
   LEFT OUTER JOIN DBP_DATA.L_BONUSKAUF_2  v02
   ON   v01.mandant_id = v02.mandant_id
   AND v01.bonuskauf_id = v02.bonuskauf_id
   LEFT OUTER JOIN dbp_msi_view_ais_kmo.mv_bonuskauf_mandant_kondition_2  v03
   ON  v01.mandant_id = v03.mandant_id
   AND v01.bonuskauf_id = v03.bonuskauf_id
   AND v01.dat = v03.dat
   AND v01.konditionsart_id = v03.konditionsart_id
   INNER JOIN DBP_DATA.ARTBEW_2 v04
   ON  v01.mandant_id = v04.mandant_id
   AND v01.wup_id = v04.wup_id
   AND v01.nb_id = v04.nb_id
   AND v01.art_id = v04.art_id
   AND v01.dat = v04.dat

   -- Ermittlung EK netto2 und EK netto3
   JOIN DBP_DATA.ART_GP_WUP_ZU_PER_2 v05
   ON  v01.mandant_id = v05.mandant_id
   AND v01.art_id = v05.art_id
   AND v01.wrg_id = v05.wrg_id
   AND v01.dat BETWEEN v05.dat_von AND v05.dat_bis
   AND v04.gp_id = v05.gp_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

   /*JOIN dbp_view.v_kurs_2 v300
   ON CURRENT_DATE BETWEEN v300.dat_von AND v300.dat_bis
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN DBP_DATA.KURS_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN DBP_DATA.KURS_2 v400
   ON v01.dat BETWEEN v400.dat_von AND v400.dat_bis
   AND v100.default_wrg = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   WHERE v01.mandant_id <> 1
   AND v04.promo_fg = 1
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
      --AP0227085/SPEC0284781 Filter E-Loading Artikel_2 / sschuecke 25.02.2025
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);