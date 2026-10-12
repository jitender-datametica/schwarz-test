CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTBEW_REGALACHSE_2
--    30.05.2011
--      Aufteilung von Umsatz, Absatz nach Kapazität
(
  art_id
, fbb_nr
, fachboden_nr
, fachboden_pos
, bewart_id
, dat
, ek_mep_Umsatz
, gp_id
, herst_id
, mandant_id
, mwst_id
, nb_id
, umsatz_mwst_betrag
, umsatz_netto
, VK_Menge
, wrg_2
, wup_id
, bezugsweg_id
, aktion_id
)
AS
   SELECT
   v01.art_id,
   fbb_nr,
   fachboden_nr,
   fachboden_pos,
   bewart_id,
   dat,
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.ek_mep AS NUMBER(38,5)) END * kapazitaet_faktor AS ek_mep_Umsatz,
   v01.gp_id,
   herst_id,
   v01.mandant_id,
   mwst_id,
   v01.nb_id,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END * kapazitaet_faktor AS umsatz_mwst_betrag,
      
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END * kapazitaet_faktor AS umsatz_netto,
   CAST(menge AS NUMBER(38,5)) * kapazitaet_faktor,
   wrg_2,
   v01.wup_id,
   bezugsweg_id,
   aktion_id

  FROM dbp_view.v_artbew_2 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02

   JOIN dbp_view.v_regalachse_akt_2 v03
   ON v01.art_id = v03.art_id
   AND v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id
   AND v01.nb_id = v03.nb_id

   WHERE v01.mandant_id  <>1 AND v03.mandant_id <> 1
   --AP0190987/SPEC0225041 Filter E-Loading Artikel_2 / sschuecke 17.11.2023
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500);