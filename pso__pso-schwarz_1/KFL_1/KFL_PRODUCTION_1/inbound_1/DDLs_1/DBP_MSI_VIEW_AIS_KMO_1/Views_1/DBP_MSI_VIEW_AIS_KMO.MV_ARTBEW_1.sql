CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTBEW_1
(
  dat
, art_id
, mandant_id
, gp_id
, nb_id
, wup_id
, bewart_id
, bewart_det_id
, bq_findung_id
, bezugsweg_id
, posten_id_per
, posten_kz_per
, wup_bereinigt_fg
, wup_bereinigt_fg_vj
, wup_bereinigt_fg_vj_wo

, umsatz_mwst_betrag
, umsatz_netto
, vk_menge
, ek_brutto_absatz
, ek_netto_absatz
, ek_nettobnk_absatz
, ek_netto2_absatz
, ek_netto3_absatz
, ek_netto3_inkl_fwu_absatz
, ek_netto4_absatz
, ek_gld_absatz

, umsatz_mwst_betrag_af
, umsatz_netto_af
, vk_menge_af
, ek_brutto_absatz_af
, ek_netto_absatz_af
, ek_nettobnk_absatz_af
, ek_netto2_absatz_af
, ek_netto3_absatz_af
, ek_netto3_inkl_fwu_absatz_af
, ek_netto4_absatz_af
, ek_gld_absatz_af

, umsatz_mwst_betrag_sa
, umsatz_netto_sa
, vk_menge_sa
, ek_brutto_absatz_sa
, ek_netto_absatz_sa
, ek_nettobnk_absatz_sa
, ek_netto2_absatz_sa
, ek_netto3_absatz_sa
, ek_netto3_inkl_fwu_absatz_sa
, ek_netto4_absatz_sa
, ek_gld_absatz_sa
, ean_kasse

, umsatz_af_non_loyalty
, umsatz_af_loyalty
, umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby
, umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby
, umsatz_af_exkl_schwarz_media_u_bonrabatt_bby
, umsatz_af_loyalty_schwarz_media
, umsatz_sa_non_loyalty
, umsatz_sa_loyalty
, umsatz_bby_non_loyalty
, umsatz_bby_loyalty
, umsatz_kdn_bby_loyalty
, umsatz_kdp_bby_loyalty
, umsatz_af_bonrabatt_non_loyalty
, umsatz_af_bonrabatt_loyalty
, umsatz_af_bonrabatt

, vk_menge_af_non_loyalty
, vk_menge_af_loyalty
, vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby
, vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby
, vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby
, vk_menge_af_loyalty_schwarz_media
, vk_menge_sa_non_loyalty
, vk_menge_sa_loyalty
, vk_menge_bby_non_loyalty
, vk_menge_bby_loyalty
, vk_menge_kdn_bby_loyalty
, vk_menge_kdp_bby_loyalty
, vk_menge_bonrabatt_bby_non_loyalty
, vk_menge_bonrabatt_bby_loyalty
, vk_menge_bonrabatt_bby

, pv_aktion_sa_loyalty
, pv_aktion_sa_loyalty_bby
, pv_aktion_sa_loyalty_kdn_bby
, pv_aktion_sa_loyalty_kdp_bby
, pv_aktion_sa_non_loyalty
, pv_aktion_sa_non_loyalty_bby
, pv_bby_loyalty
, pv_bby_non_loyalty
, pv_kdn_bby_loyalty
, pv_kdp_bby_loyalty
, pv_bonrabatt_bby_non_loyalty
, pv_bonrabatt_bby_loyalty
, pv_bonrabatt_bby

, bonusbasis
, bonusbasis_af
, bonusbasis_sa
, ek_mepol
, ek_mepol_af
, ek_mepol_sa
)
AS
-- SPEC0068483 - adding bewart_1 1010 in AF columns
-- AP0077097, SPEC0094265 - new umsatz and absatz metrics
-- AP0077097, SPEC0094266 - new PV metrics
-- AP0143687, SPEC0172769 - new EK metrics
-- AP0152678, SPEC0187452 - new EK n3 inkl FWU metrics
-- AP0147481, SPEC0220258 - neue Bewart_id SMP 
-- AP0212516, SPEC0243813 - Anpassungen AF Kennzahlen 
-- 20231205 WUP_1 Bereinigt Berechnung voruebergehend hier berechnen. Zukuenftig soll es direkt in der ARTBEW_1 vorhanden sein  
-- AP0261549 Bewegungsart bei pv_kdp_bby_loyalty hinzufügen

WITH t_wup_bereinigt AS(
    SELECT  
        v01.dat, 
        v02.mandant_id,
        v02.wup_id,
        --SPEC0256280 sschuecke 24.07.2024 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo,
        CASE WHEN v01.dat LIKE '%-02-29' 
            THEN wup_bereinigt_fg_vj_wo
        WHEN  (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) 
            THEN 1 
        ELSE 0 END AS wup_bereinigt_fg_vj
    FROM DBP_DATA.TAG_1 v01
    JOIN DBP_DATA.WUP_1 v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    LEFT JOIN DBP_DATA.TAG_1 v03
        ON (v01.dat = v03.dat_vj_kt)
    LEFT JOIN DBP_DATA.TAG_1 v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
        AND v02.nb_id = 0
        AND v02.mandant_id <> 1
)
SELECT
v01.dat,
v01.art_id,
v01.mandant_id,
v01.gp_id,
v01.nb_id,
v01.wup_id,
v01.bewart_id,
v01.bewart_det_id,
v01.bq_findung_id,
v01.bezugsweg_id,
CAST(CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END AS VARCHAR(2)) AS posten_id_per,
CASE WHEN v01.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per,
v05.wup_bereinigt_fg_akt AS wup_bereinigt_fg,
v05.wup_bereinigt_fg_vj,
v05.wup_bereinigt_fg_vj_wo,
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto,
CAST(v01.menge AS NUMBER(38,5)) AS vk_menge,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_brutto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.ek_brutto AS NUMBER(38,5)) END ek_brutto_absatz,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.ek_netto AS NUMBER(38,5)) END ek_netto_absatz,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_netto_bnk * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END ek_nettobnk_absatz,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_nettonetto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.ek_nettonetto AS NUMBER(38,5)) END ek_netto2_absatz,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.ek_mep AS NUMBER(38,5)) END ek_netto3_absatz,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_kal_basis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_kal_basis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.ek_kal_basis AS NUMBER(38,5)) END ek_netto3_inkl_fwu_absatz,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.einstandspreis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_af,
CASE
WHEN v01.bewart_id IN(1001,1010) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_brutto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_brutto AS NUMBER(38,5)) END ek_brutto_absatz_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto AS NUMBER(38,5)) END ek_netto_absatz_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto_bnk * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END ek_nettobnk_absatz_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_nettonetto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_nettonetto AS NUMBER(38,5)) END ek_netto2_absatz_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_mep AS NUMBER(38,5)) END ek_netto3_absatz_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_kal_basis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_kal_basis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_kal_basis AS NUMBER(38,5)) END ek_netto3_inkl_fwu_absatz_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.einstandspreis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_sa,
CASE
WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_brutto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_brutto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_brutto AS NUMBER(38,5)) END ek_brutto_absatz_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto AS NUMBER(38,5)) END ek_netto_absatz_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_netto_bnk_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto_bnk * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_netto_bnk AS NUMBER(38,5)) END ek_nettobnk_absatz_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_nettonetto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_nettonetto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_nettonetto AS NUMBER(38,5)) END ek_netto2_absatz_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_mep_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep AS NUMBER(38,5)) END ek_netto3_absatz_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_kal_basis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_kal_basis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_kal_basis AS NUMBER(38,5)) END ek_netto3_inkl_fwu_absatz_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_einstandspreis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.einstandspreis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.einstandspreis AS NUMBER(38,5)) END ek_netto4_absatz_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_ek_gld_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_gld * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_gld AS NUMBER(38,5)) END ek_gld_absatz_sa,

(CASE
WHEN v01.ean_kasse BETWEEN 100000 AND 999999 THEN  v01.ean_kasse * 10000000 -- 10 Milionen

ELSE v01.ean_kasse END ) AS ean_kasse,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100110,100130) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100110,100130) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100110,100130) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_non_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100111 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100111 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100111 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100110 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100110 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100110 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
umsatz_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby + umsatz_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby AS umsatz_af_exkl_schwarz_media_u_bonrabatt_bby,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100121 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100121 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100121 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_loyalty_schwarz_media,

CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100210 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_sa_non_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100211 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_sa_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100220 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_bby_non_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100221 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100221 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100221 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_bby_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100231 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100231 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100231 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_kdn_bby_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100241 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100241 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100241 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_kdp_bby_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100130 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100130 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100130 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_bonrabatt_non_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100131 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100131 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100131 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_af_bonrabatt_loyalty,
umsatz_af_bonrabatt_non_loyalty + umsatz_af_bonrabatt_loyalty AS umsatz_af_bonrabatt,
CASE
WHEN v01.bewart_det_id IN (100110,100130) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_non_loyalty,
CASE
WHEN v01.bewart_det_id IN (100111,100121,100131) THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_loyalty,
CASE
WHEN v01.bewart_det_id = 100111 THEN CAST(v01.menge AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
CASE
WHEN v01.bewart_det_id = 100110 THEN CAST(v01.menge AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby + vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
CASE
WHEN v01.bewart_det_id = 100121 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_af_loyalty_schwarz_media,
CASE
WHEN v01.bewart_det_id = 100210 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa_non_loyalty,
CASE
WHEN v01.bewart_det_id = 100211 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_sa_loyalty,
CASE
WHEN v01.bewart_det_id = 100220 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_bby_non_loyalty,
CASE
WHEN v01.bewart_det_id = 100221 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_bby_loyalty,
CASE
WHEN v01.bewart_det_id = 100231 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_kdn_bby_loyalty,
CASE
WHEN v01.bewart_det_id = 100241 THEN CAST(v01.menge AS NUMBER(38,5)) END vk_menge_kdp_bby_loyalty,
CASE
WHEN v01.bewart_det_id = 100130 THEN CAST(v01.menge AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_bonrabatt_bby_non_loyalty,
CASE
WHEN v01.bewart_det_id = 100131 THEN CAST(v01.menge AS NUMBER(38,5))
ELSE CAST(0 AS NUMBER(38,5)) END vk_menge_bonrabatt_bby_loyalty,
vk_menge_bonrabatt_bby_loyalty + vk_menge_bonrabatt_bby_non_loyalty AS vk_menge_bonrabatt_bby,
/*, CASE WHEN v01.bewart_det_id IN (100211,100221,100231,100241) THEN CAST((v01.pv_aktion + v01.pv_aktion_bby + v01.pv_aktion_kdn_bby + v01.pv_aktion_kdp_bby) AS NUMBER(38,5)) */
/*END pv_sa_loyalty*/
/*, CASE WHEN v01.bewart_det_id IN (100210,100220) THEN CAST((v01.pv_aktion + v01.pv_aktion_bby) AS NUMBER(38,5)) */
/*END pv_sa_non_loyalty*/
/*, CASE WHEN v01.bewart_det_id = 100221 THEN CAST(v01.pv_bby AS NUMBER(38,5)) */
/*END pv_bby_loyalty*/
/*, CASE WHEN v01.bewart_det_id = 100220 THEN CAST(v01.pv_bby AS NUMBER(38,5)) */
/*END pv_bby_non_loyalty*/
/*, CASE WHEN v01.bewart_det_id = 100231 THEN CAST(v01.pv_kdn_bby AS NUMBER(38,5)) */
/*END pv_kdn_bby_loyalty*/
/*, CASE WHEN v01.bewart_det_id = 100241 THEN CAST(v01.pv_kdp_bby AS NUMBER(38,5)) */
/*END pv_kdp_bby_loyalty */
-- AP0180589/SPEC0237461 Verwendung der pv_konz Spalten aus Tabelle statt Umrechnungskurs / ssch1303 16.02.2024
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100211 THEN CAST(v01.pv_aktion_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.pv_aktion * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100211 THEN CAST(v01.pv_aktion AS NUMBER(38,5)) END pv_aktion_sa_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100221, 100211) THEN CAST(v01.pv_aktion_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100221, 100211) THEN CAST(v01.pv_aktion_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100221, 100211) THEN CAST(v01.pv_aktion_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_bby,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdn_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdn_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdn_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_kdn_bby,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100241, 100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdp_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100241, 100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdp_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100241, 100231, 100221, 100211) THEN CAST(v01.pv_aktion_kdp_bby AS NUMBER(38,5)) END pv_aktion_sa_loyalty_kdp_bby,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100210 THEN CAST(v01.pv_aktion_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.pv_aktion * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100210 THEN CAST(v01.pv_aktion AS NUMBER(38,5)) END pv_aktion_sa_non_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100220, 100210) THEN CAST(v01.pv_aktion_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100220, 100210) THEN CAST(v01.pv_aktion_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100220, 100210) THEN CAST(v01.pv_aktion_bby AS NUMBER(38,5)) END pv_aktion_sa_non_loyalty_bby,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100221,100231,100241) THEN CAST(v01.pv_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100221,100231,100241) THEN CAST(v01.pv_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100221,100231,100241) THEN CAST(v01.pv_bby AS NUMBER(38,5)) END pv_bby_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id = 100220 THEN CAST(v01.pv_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.pv_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id = 100220 THEN CAST(v01.pv_bby AS NUMBER(38,5)) END pv_bby_non_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100231, 100241) THEN CAST(v01.pv_kdn_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100231, 100241) THEN CAST(v01.pv_kdn_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100231, 100241) THEN CAST(v01.pv_kdn_bby AS NUMBER(38,5)) END pv_kdn_bby_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0  THEN CAST(v01.pv_kdp_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.pv_kdp_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1  THEN CAST(v01.pv_kdp_bby AS NUMBER(38,5)) END pv_kdp_bby_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100210,100220, 100130) THEN CAST(v01.pv_bonrabatt_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100210,100220, 100130) THEN CAST(v01.pv_bonrabatt_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100210,100220, 100130) THEN CAST(v01.pv_bonrabatt_bby AS NUMBER(38,5)) END pv_bonrabatt_bby_non_loyalty,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_det_id IN (100211, 100221, 100231, 100241,100131) THEN CAST(v01.pv_bonrabatt_bby_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_det_id IN (100211, 100221, 100231, 100241,100131) THEN CAST(v01.pv_bonrabatt_bby * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100211, 100221, 100231, 100241,100131) THEN CAST(v01.pv_bonrabatt_bby AS NUMBER(38,5)) END pv_bonrabatt_bby_loyalty,
pv_bonrabatt_bby_non_loyalty + pv_bonrabatt_bby_loyalty AS  pv_bonrabatt_bby,
--AP0143687, SPEC0172769 - new EK metrics
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.bonusbasis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.bonusbasis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.bonusbasis AS NUMBER(38,5)) END bonusbasis,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.bonusbasis AS NUMBER(38,5)) END bonusbasis_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.bonusbasis AS NUMBER(38,5)) END bonusbasis_sa,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.ek_mep_vor_fwu_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.ek_mep_vor_fwu * v01.umrechnungskurs_hist AS NUMBER(38,5))
     ELSE CAST(v01.ek_mep_vor_fwu AS NUMBER(38,5)) END ek_mepol,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.ek_mep_vor_fwu_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.ek_mep_vor_fwu * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN (1001,1010) THEN CAST(v01.ek_mep_vor_fwu AS NUMBER(38,5)) END ek_mepol_af,
CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep_vor_fwu_konz AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep_vor_fwu * v01.umrechnungskurs_hist AS NUMBER(38,5))
     WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.ek_mep_vor_fwu AS NUMBER(38,5)) END ek_mepol_sa

FROM DBP_DATA.ARTBEW_1 v01

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v02

-- Umrechnung Standardkurs, Tageskurs AP0077097, SPEC0094266 - new PV metrics     
-- AP0180589/SPEC0237461 Entfall JOIN auf Kurstabelle aufgrund Verwendung der pv_konz Spalten / ssch1303 16.02.2024  
--JOIN
--dbp_view.v_kurs_1 v03
--ON v01.dat BETWEEN v03.dat_von AND v03.dat_bis
--AND v01.wrg_1 = v03.von_wrg_id
--AND v03.kurstyp_id = 9
--AND v03.nach_wrg_id ='EUR'

LEFT JOIN DBP_DATA.ART_PER_1 v04
ON v01.art_id = v04.art_id
AND v01.mandant_id = v04.mandant_id
AND v01.dat BETWEEN v04.dat_von-1 AND v04.dat_bis-1

LEFT JOIN t_wup_bereinigt v05
ON v01.dat = v05.dat
AND v01.mandant_id = v05.mandant_id 
AND v01.wup_id = v05.wup_id


WHERE v01.mandant_id <> 1
--AP0190987/SPEC0225041 Filter E-Loading Artikel_1 / sschuecke 17.11.2023
AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
   --AP0227085/SPEC0284781 Filter E-Loading Artikel_1 / sschuecke 25.02.2025
   AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
   AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
   AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
   AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
   AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);