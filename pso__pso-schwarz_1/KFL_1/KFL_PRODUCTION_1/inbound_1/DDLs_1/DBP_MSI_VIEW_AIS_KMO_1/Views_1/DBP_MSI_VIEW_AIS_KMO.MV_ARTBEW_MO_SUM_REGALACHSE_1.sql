CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTBEW_MO_SUM_REGALACHSE_1
--   31.05.2011
--   Aufteilung von Umsatz, Absatz nach Kapazität
-- 31.05.2012 Einstandspreis hinzugefügt EK-2979807
(
  kjmo
, art_id
, fbb_nr
, fachboden_nr
, fachboden_pos
, bewart_id
, mandant_id
, wup_id
, nb_id
, gp_id
, herst_id
--,diff_netto_ums_konz
, ek_mep_Umsatz
, umsatz_mwst_betrag
, umsatz_netto
, vk_menge
, ek_netto4_absatz
)
AS
   SELECT
   kjmo,
   v01.art_id,
   fbb_nr,
   fachboden_nr,
   fachboden_pos,
   bewart_id,
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.gp_id,
   herst_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CASE WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
        WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.ek_mep AS NUMBER(38,5)) END * kapazitaet_faktor AS ek_mep_Umsatz,
   CASE WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
        WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END * kapazitaet_faktor AS umsatz_mwst_betrag,
   CASE WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
        WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END * kapazitaet_faktor AS umsatz_netto,
   CAST(menge AS NUMBER(38,5)) * kapazitaet_faktor,
   CASE WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 0 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
        WHEN v03.wrg_typ_id = 0 AND v03.berichtskurs_typ_id = 1 THEN CAST(v01.einstandspreis * v01.umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.einstandspreis AS NUMBER(38,5)) END * kapazitaet_faktor AS ek_netto4_absatz
  FROM DBP_MSI_VIEW_AIS_KMO.TBL_MV_ARTBEW_MO_SUM_REGALACHSE_1 v01

    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v03;