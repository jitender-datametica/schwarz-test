CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hfm_inventur_termin_owg_wup_detail (mandant_id, wup_id, nb_id
, dat_plan_zaehlung, inventurart_int_id, owg_id, arthiertyp_id, dat_vorletzte_zaehlung, wrg_id, anfangsbestand,
warenzugang, warenzugang_dzl, warenzugang_dzl_korr, warenzugang_zl, warenzugang_zl_korr, warenzugang_retoure,
abschriften_ohne_diebstahl, werbegutschriften, abschriften_operativ, abschriften_ta_vt_sonstige, endbestand_rechnerisch
, endbestand_gezaehlt, umsatz_soll) AS SELECT OWD.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 OWD.nb_id,
 OWD.dat_plan_zaehlung,
 OWD.inventurart_int_id,
 OWD.owg_id,
 OWD.arthiertyp_id,
 OWD.dat_vorletzte_zaehlung,
 OWD.wrg_id,
 OWD.anfangsbestand,
 OWD.warenzugang,
 OWD.warenzugang_dzl,
 OWD.warenzugang_dzl_korr,
 OWD.warenzugang_zl,
 OWD.warenzugang_zl_korr,
 OWD.warenzugang_retoure,
 OWD.abschriften_ohne_diebstahl,
 OWD.werbegutschriften,
 OWD.abschriften_operativ,
 OWD.abschriften_ta_vt_sonstige,
 OWD.endbestand_rechnerisch,
 OWD.endbestand_gezaehlt,
 OWD.umsatz_soll
FROM kfl_production_dbp_view.v_hfm_inventur_termin_owg_wup_detail AS OWD
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON OWD.mandant_id = WUP.mandant_id AND OWD.wup_id = WUP.wup_id;