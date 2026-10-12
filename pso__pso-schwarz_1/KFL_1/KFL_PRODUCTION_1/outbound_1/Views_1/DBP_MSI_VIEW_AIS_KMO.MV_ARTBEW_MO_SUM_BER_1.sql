CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artbew_mo_sum_ber_1
(
    kjmo,
    art_id,
    mandant_id,
    gp_id,
    nb_id,
    wup_id,
    bewart_id,
    bewart_det_id,
    bq_findung_id,
    bezugsweg_id,
    posten_id,
    posten_kz,
    posten_id_per,
    posten_kz_per,
    wup_bereinigt_fg,
    wup_bereinigt_fg_vj,
    ean_kasse,
    umsatz_netto,
    vk_menge,
    umsatz_netto_af,
    vk_menge_af,
    umsatz_netto_sa,
    vk_menge_sa
)
AS
SELECT
    v01.kjmo,
    v01.art_id,
    v01.mandant_id,
    v01.gp_id,
    v01.nb_id,
    v01.wup_id,
    v01.bewart_id,
    v01.bewart_det_id,
    v01.bq_findung_id,
    v01.bezugsweg_id,
    v01.posten_id,
    v01.posten_kz,
    v01.posten_id_per,
    v01.posten_kz_per,
    v01.wup_bereinigt_fg,
    v01.wup_bereinigt_fg_vj,
    v01.ean_kasse,

    IFNULL(CASE 
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC)
        ELSE CAST(v01.umsatz_netto AS NUMERIC) 
    END, 0) AS umsatz_netto,

    IFNULL(CAST(v01.menge AS NUMERIC), 0) AS vk_menge,

    IFNULL(CASE 
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC)
        WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMERIC) 
    END, 0) AS umsatz_netto_af,

    IFNULL(CASE 
        WHEN v01.bewart_id IN(1001,1010) THEN CAST(v01.menge AS NUMERIC) 
    END, 0) AS vk_menge_af,

    IFNULL(CASE 
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC)
        WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMERIC) 
    END, 0) AS umsatz_netto_sa,

    IFNULL(CASE 
        WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMERIC) 
    END, 0) AS vk_menge_sa

FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_mo_sum_ber_1 v01
CROSS JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 v02;