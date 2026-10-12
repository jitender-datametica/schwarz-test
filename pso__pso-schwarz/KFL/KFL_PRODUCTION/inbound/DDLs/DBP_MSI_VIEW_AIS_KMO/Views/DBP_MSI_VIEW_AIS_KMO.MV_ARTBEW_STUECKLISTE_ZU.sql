CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTBEW_STUECKLISTE_ZU 
AS

   SELECT

   mandant_id,
   wup_id,
   nb_id,
   art_id,
   dat,
   komponente_art_id,
   stueckliste_id,
   wrg_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.umsatz_mwst_betrag* umrechnungskurs AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_mwst_betrag* umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END vks_umsatz_mwst_betrag,
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.umsatz_netto * umrechnungskurs AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_netto * umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END vks_umsatz_netto,
   CAST(v01.menge AS NUMBER(38,5)) AS vks_vk_menge,
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.ek_brutto * umrechnungskurs AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_brutto * umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.ek_brutto AS NUMBER(38,5)) END vks_ek_brutto_absatz,
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.ek_netto *  umrechnungskurs AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_netto *  umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.ek_netto AS NUMBER(38,5)) END vks_ek_netto_absatz,
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.ek_nettonetto *umrechnungskurs AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_nettonetto *umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.ek_nettonetto AS NUMBER(38,5)) END vks_ek_netto2_absatz,
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.ek_mep * umrechnungskurs AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_mep * umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.ek_mep AS NUMBER(38,5)) END vks_ek_netto3_absatz,
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.einstandspreis * umrechnungskurs AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.einstandspreis * umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.einstandspreis AS NUMBER(38,5)) END vks_ek_netto4_absatz,
   CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.ek_netto_bnk * umrechnungskurs AS NUMBER(38,5))
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_netto_bnk * umrechnungskurs_hist AS NUMBER(38,5))
        ELSE CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END vks_ek_nettobnk_absatz,
   bq_findung_id,
   umrechnungskurs


   FROM DBP_DATA.ARTBEW_STUECKLISTE_ZU v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v02


   WHERE v01.mandant_id <> 1
   --AP0190987/SPEC0225041 Filter E-Loading Artikel / sschuecke 17.11.2023
   AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
      --AP0227085/SPEC0284781 Filter E-Loading Artikel / sschuecke 25.02.2025
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640)
   ;