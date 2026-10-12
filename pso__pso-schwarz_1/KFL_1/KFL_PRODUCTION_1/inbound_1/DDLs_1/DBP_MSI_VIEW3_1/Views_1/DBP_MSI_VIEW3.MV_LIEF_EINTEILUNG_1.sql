CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIEF_EINTEILUNG_1 (best_beleg_id, best_beleg_pos_id, dat_lief_bewertung, dat_lief_wunsch, einteil_id, mahnung_anz, mandant_id, menge_einteil)
AS
   SELECT best_beleg_id, best_beleg_pos_id, dat_lief_bewertung, dat_lief_wunsch, einteil_id, mahnung_anz, mandant_id, menge_einteil FROM dbp_view.v_lief_einteilung_1;