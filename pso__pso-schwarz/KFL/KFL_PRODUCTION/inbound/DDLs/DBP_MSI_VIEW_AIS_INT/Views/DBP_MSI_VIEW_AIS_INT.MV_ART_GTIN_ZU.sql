CREATE OR REPLACE VIEW dbp_msi_view_ais_int.mv_art_gtin_zu (
    mandant_id,
    art_id,
    altnv_menge_einh_id,
    gtin_id,
    gtin_typ_kz,
    haupt_gtin_fg
) AS SELECT
    mandant_id,
    art_id,
    altnv_menge_einh_id,
    gtin_id,
    gtin_typ_kz,
    haupt_gtin_fg
FROM dbp_view.v_art_gtin_zu;