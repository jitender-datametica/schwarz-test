CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_BEST_2
--NSR0828595, mcie, 03/07/2019, added loesch_fg=0 in where clause

(
best_beleg_id,
bestellart_id,
dat_aenderung,
dat_best_beleg,
einkaufsorganisation_id,
gp_id,
loesch_fg,
mandant_id,
nachbest_fg,
kunde_id,
wup_id,
nb_id,
anz_pos_aktiv,
empfaenger_wup_id
)
AS
   SELECT
   best_beleg_id,
   bestellart_id,
   dat_aenderung,
   dat_best_beleg,
   einkaufsorganisation_id,
   gp_id,
   loesch_fg,
   mandant_id,
   nachbest_fg,
   CASE WHEN CAST(SUBSTR(kunde_id,7,4) AS INTEGER) IS NULL THEN 0 ELSE CAST(SUBSTR(kunde_id,7,4) AS INTEGER) END AS kunde_id,
   wup_id,
   nb_id,
   anz_pos_aktiv,
   empfaenger_wup_id
   FROM dbp_view.v_besch_best_2
   where einkaufsorganisation_id <> 5000 AND loesch_fg = 0;