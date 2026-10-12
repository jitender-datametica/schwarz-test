CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WUP_WOTAG_ZU_PER_1 (mandant_id,wup_id,nb_id,wtag_id,umsatz_prz,dat_von,dat_bis)
AS
   SELECT mandant_id, wup_id, nb_id, wtag_id, umsatz_prz, dat_von, dat_bis from dbp_view.v_wup_wotag_zu_per_1 where mandant_id=1;