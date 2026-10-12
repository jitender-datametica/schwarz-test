CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_GP_1
    -- 23.10.2013 twie: gp_name_sort eingefügt, damit man trotz {} noch sortieren kann
    (
    mandant_id
    , gp_id
    , einkaufsorganisation_id
    , dat_von
    , dat_bis
    , anlieferung_id
    , gp_name
    , gp_name_sort
    , gp_strasse
    , gp_plz
    , gp_ort
    , land_id
    , hgp_id
    , zek_id
    , lieferzeit
    , zahlungsziel
    , agb_id
    , iso_id
    , eigenverpackung_id
    , eigenmarke_id
    , audit_id
    , audit_dat
    , herst_fg
    , zahlart_id
    , retour_sperr_fg
    , gp_branche_id
    , loesch_fg
    , system_id
    )
    AS
       SELECT
       v01.mandant_id,
       v01.gp_id,
       v01.einkaufsorganisation_id,
       v01.dat_von,
       v01.dat_bis,
       v01.anlieferung_id,
       CASE WHEN v01.loesch_fg = 1 THEN '{' || v01.gp_name  || '}' ELSE v01.gp_name END AS gp_name,
       v01.gp_name AS gp_name_sort,
       v01.gp_strasse,
       v01.gp_plz,
       v01.gp_ort,
       v01.land_id,
       v01.hgp_id,
       v01.zek_id,
       v01.lieferzeit,
       v01.zahlungsziel_id,
       v01.agb_id,
       v01.iso_id,
       v01.eigenverpackung_id,
       v01.eigenmarke_id,
       v01.audit_id,
       v01.audit_dat,
       v01.herst_fg,
       v01.zahlart_id,
       COALESCE(v01.retour_sperr_fg, 0) AS retour_sperr_fg,
       v01.gp_branche_id,
       COALESCE(v01.loesch_fg, 0) AS loesch_fg,
       7 AS system_id
FROM dbp_view.v_gp_1 v01
       WHERE v01.mandant_id = 1
       AND (v01.gp_id > 999999 OR v01.gp_id BETWEEN 9211 AND 9220 OR v01.gp_id = -1)
 ;